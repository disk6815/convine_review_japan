set -o errexit

# Set package managers to npm and disable yarn
export JSBUNDLING_PACKAGE_MANAGER=npm
export CSSBUNDLING_PACKAGE_MANAGER=npm
export YARN_IGNORE_PATH=1
export YARN_IGNORE_ENGINES=1

# Remove yarn.lock if it exists to force npm
rm -f yarn.lock

bundle install
npm install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed