# CitySurvey

## What's CitySurvey?
CitySurvey is a simple web application that helps users create online forms and collect data from other users. Current features include:
* Single-user authentication & authorization
* Create form with multiple form fields
* Specify the type of a field as 
    * Text-based (short text, paragraph)
    * Select-based (choose one, choose multiple & drop-down menu)
* Set a field as required or optional
* Publish a form and share the token-protected form URL with people from which you would like to collect information
* View the submissions of a form

## Testing
CitySurvey's test suite is based on [RSpec](https://rspec.info/) and [factory_bot](https://github.com/thoughtbot/factory_bot) 

## Deployment
CitySurvey can be deployed to any platform that supports [Ruby](https://www.ruby-lang.org/) (2.6.3+) and [PostgreSQL](https://www.postgresql.org/), such as [Heroku](https://www.heroku.com/). Please see the `Gemfile` for gem dependencies

## Issues/edge cases
* If a user adds two or more form fields/form field option with the same name/value and create/update the form, the app will crash with a database unique constraint exception
* `Remove field` link should be hidden when there is only one form field left
* `Remove option` link should be hidden when there is only one form field option left
* After a user adds a new form field and chooses one of the select types (radio, checkbox or drop-down), there should be one form field option by default (to save one click of "Add option")
* The limit of 100 characters for a form entry is too low for a paragraph (textarea) field

## Todo
* Multiple-user authentication & authorization
* Form pagination and search
* Form fields reordering
* Send form by email
* Duplicate submission prevention
* Form editing after it is published
* Form styling (color, font style, etc)
* Form submission charts
