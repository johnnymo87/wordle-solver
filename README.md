# Ruby Starter Kit

A starter kit for writing code and [tests](https://github.com/seattlerb/minitest#label-Specs) in ruby.

#### Dependencies
* docker
* docker-compose

## Install
* build the image
  ```sh
  docker-compose build
  ```

## Run
* run the tests
  ```sh
  docker-compose run --rm app
  ```
* run something else, like `bash` or `irb`
  ```sh
  docker-compose run --rm app irb -Ilib
  ```

## Copy
* this command will clone even hidden files and directories
  ```sh
  mkdir -p path/to/new
  cp -rT path/to/this/directory path/to/new/directory
  ```
  * it's OK if `path/to/new/directory` already exists
  * it's not OK if `path/to/new` doesn't exist, hence the `mkdir -p`

## Debug
* documentation [here](https://github.com/pry/pry)
* set a breakpoint with `require 'pry'; binding.pry`
* show where you are with `whereami`
* continue with `exit`
* quit with `exit!`
