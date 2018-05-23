# Hub Acceptance Tests

This is an attempt at a new style of hub acceptance tests using Cucumber and Capybara.
Hopefully, they'll be more maintainable than what we have now.


## Running

Run the acceptance tests with:

    ./pre-commit.sh

To run them for a different test environment, export the `TEST_ENV` environment variable with one of the following:

  * local
  * joint


## Configuration

Config for the different test environments is stored in `features/step_definitions/environments.yml`.
