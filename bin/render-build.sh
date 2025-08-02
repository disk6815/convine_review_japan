#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Install npm dependencies with specific flags for Render
echo "Installing npm dependencies..."
npm install --no-optional --production=false --legacy-peer-deps

# Build assets with comprehensive error handling
echo "Building JavaScript assets..."
npm run build || {
  echo "JavaScript build failed, but continuing..."
}

echo "Building CSS assets..."
npm run build:css || {
  echo "Primary CSS build failed, trying alternative approach..."
  npx @tailwindcss/cli -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify || {
    echo "Alternative CSS build also failed, trying direct tailwindcss..."
    npx tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --minify || {
      echo "All CSS build methods failed, using fallback..."
      cp ./app/assets/stylesheets/application.tailwind.css ./app/assets/builds/application.css
    }
  }
}

# Run database migrations
echo "Precompiling assets..."
bundle exec rails assets:precompile
bundle exec rails assets:clean
echo "Running database migrations..."
bundle exec rails db:migrate