set -o errexit

# Set package managers to npm
export JSBUNDLING_PACKAGE_MANAGER=npm
export CSSBUNDLING_PACKAGE_MANAGER=npm

bundle install
npm install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
bundle exec rails db:seed