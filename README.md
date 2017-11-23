# README

This application is a rails server to control a MineSweeper game session. :bomb:

# System Config

* **Ruby Version**: 2.3.1

* **Rails Version**: 5.0.0.1

* **MongoDB Version**: 3.4.10

# Endpoints

The server has the following endpoints:

* **POST** `/board`: Creates a new Board, example:
```
{
  "height": 5,
  "width": 5,
  "bombs_count": 4
}
```
Creates a board with 5 lines, 5 columns and 4 bombs randomly generated.

**Note: This application controls a game session, therefore it is possible to create only one board per session, creating another one will overwrite the older.**

* **DELETE** `/board`: Deletes the current board.


* **GET** `/status`: Return a JSON with the status of the current game. Example:

```
{
  "playing": true
}
```


* **PATCH** `/flag`: Places a flag in the passed position, return `400` in case of the position is invalid. Example:

{
  "line": 1,
  "column": 3
}


* **PATCH** `/play`: Is equivalent to a "click" on the specified position. It also discovers the neighbour cells. Example:

{
  "line": 0,
  "column": "4"
}

# Test Cases

Spec tests were made using **RSpec** version **3.7**.

# Launch The Application

The application uses MongoDB for NoSQL data handling. Here are some options for launching the server.


## Development Mode in Your Local Terminal

If you have a Linux machine and a bash terminal, you can use it in development mode. Use the following commands:

### Prerequisites

Make sure you have [ruby](https://rvm.io/rvm/install) and [mongod](https://docs.mongodb.com/manual/installation/) installed.

### Usage

Run:

```
$ gem install bundler && bundle install
```

To install all dependencies

```
$ sudo service mongod start
```

To launch mongod as a systemctl service.

```
$ bundle exec rails puma -b 0.0.0.0
```

To launch your application on port `3000`

## Using Docker Compose

This application can be run as a Docker Container and Compose can be used to orchestrate de dependencies.

### Prerequisites

Make sure you have [docker](https://docs.docker.com/engine/installation/) and [docker compose](https://docs.docker.com/compose/install/) installed.

### Usage

To run the standalone application (without database it crashes), run:

```
$ docker run --name minesweeper-server -d -p 3000:3000 vinhags/minesweeper
```

Or, use it with docker compose:

```
$ docker-compose up
```

**You need to be in the source folder so the docker-compose.yaml can be loaded**

