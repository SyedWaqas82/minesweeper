# Minesweeper

## Setup

Install the app dependencies:

```
bundle install
rails db:create
rails db:migrate
rails webpacker:install
rails webpacker:install:react
```

## Tests

To run all tests:

```
rails db:test:prepare
rails db:migrate RAILS_ENV=test
rails test
rails test:system
```
