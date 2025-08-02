#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Install npm dependencies with specific flags for Render
npm install --no-optional --production=false

# Build assets
npm run build
npm run build:css

# Run database migrations
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate