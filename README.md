# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Render Deployment

This application is configured for deployment on Render with the following setup:

- **Build Command**: `./bin/render-build.sh`
- **Package Manager**: npm (configured for Render environment)
- **Database**: PostgreSQL
- **Environment Variables**: 
  - `JSBUNDLING_PACKAGE_MANAGER=npm`
  - `CSSBUNDLING_PACKAGE_MANAGER=npm`

### Build Process
1. Bundle install
2. npm install
3. Assets precompile
4. Database migration
5. Database seeding
