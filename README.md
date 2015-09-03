# Bookstore

This is very simple app with 2 API endpoints for demonstration purpose.

## Versions

Application has some versions which are in v1|v2|... branches.

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % bin/setup

It assumes you have a machine equipped with Ruby, Postgres(>=9.3), etc.

After setting up, you can switch before application versions:

    % git checkout v1|v2|...

Than you should recreate DB for this version:

    % bundle exec db:reset

After all, you can run the application:

    % bin/rails s

## Running Rspec specs from the command line

Command line:

    % bundle exec rspec spec

## Endpoints

### Get book statistic

    GET  /api/v1/publishers/:id/shops

where

    :id is publisher id

### Mark book as sold

    POST /api/v1/shops/:shop_id/order

where

    :shop_id - shop id
    :book_id - book id
    :copies  - copies to mark
