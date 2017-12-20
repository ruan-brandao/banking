# Banking

[![Ebert](https://ebertapp.io/github/ruan-brandao/banking.svg)](https://ebertapp.io/github/ruan-brandao/banking)
[![Build Status](https://semaphoreci.com/api/v1/ruan-brandao/banking/branches/master/badge.svg)](https://semaphoreci.com/ruan-brandao/banking)

Simple implementation of a RESTFul API to manage banking accounts

## Dependencies
This project has the following dependencies:

* Ruby 2.4
* Rails 5.1.4

## Setup the project
To run the project, do the following steps:

1. Install the dependencies listed above
2. `$ git clone <REPOSITORY_URL> banking` - Clone the repository
3. `$ cd banking` - Go into the project directory
4. `$ bundle install` - Install the project's gems
5. `$ bin/rake db:migrate` - Setup the project's database

If everything goes OK, you can now run the project.

## Running the project
1. Run `$ bin/rails server` on the project directory
2. Open [http://localhost:3000](http://localhost:3000) at your web browser

## Running the tests
Run `$ bin/rspec` to run the tests.
