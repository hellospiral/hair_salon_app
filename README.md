# Hair Salon

#### Database Web Application for business using Ruby, Sinatra, and PostgreSQL

#### By Matt Carlson

## Description

The app allows an administrator for a hair salon to create, read, edit, and delete stylists and clients, and assign multiple clients to a stylist.

## Setup/Installation Requirements

### Database Setup Instructions:

* in PSQL:
* CREATE DATABASE hair_salon;
* CREATE TABLE stylists (id serial primary key, name varchar, phone varchar, email varchar);
* CREATE TABLE clients (id serial primary key, name varchar, phone varchar, email varchar, stylist_id int);

### Server Setup Instructions:
* Clone this repo
* Open an http server in the top level of the cloned directory. For a mac, run this command in your terminal:
* ruby app.rb
* Open your browser to localhost:4567

## Technologies Used

* Ruby
* Sinatra
* PostgreSQL
* Rspec
* Capybara
* HTML
* Bootstrap

### License

This software is licensed under the MIT license.

Copyright (c) 2016 Matt Carlson
