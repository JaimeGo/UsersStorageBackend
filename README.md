
# UsersStorageFrontend
Collection of users developed in Rails 5.2.3

## Description
Backend of a user Crud made in Ruby on Rails. It supports the ability to upload profile pictures (optionally) to the local environment through Active Storage, and it has CORS enabled. The app is configured as a REST api with versions, which is why the endpoints are in the path '/api/v1/users'. In the 'postman' folder, you can find a Postman collection and environment I used to test the backend. It is configured to be used without copy-paste.

## Installation
From the root folder of the project, run the commands:

rails db:create

rails db:migrate

rails s -p 3001
