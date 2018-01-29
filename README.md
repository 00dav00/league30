# README

[![Build Status](https://travis-ci.org/00dav00/league30.svg?branch=master)](https://travis-ci.org/00dav00/league30)

## Setup local environment

- Install docker version 17.12 and Docker Compose 1.16. To build and start the containers to develop locally.

  ```bash
  docker-compose up -d --build
  ```

  Docker compose will build 2 containers:

  - app - Puma server running on the local port 3000
  - db - Database with PostgresSQL 10

- Create the database and run migrations

  ```bash
  docker-compose run app ./bin/setup
  ```

- To execute comands inside of the docker follow this sintaxis.

  ```bash
  docker-compose run <conatiner name> <command>
  docker-compose run app ./bin/rails c
 ```

