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

## Debug
* documentation [here](https://github.com/pry/pry)
* set a breakpoint with `require 'pry'; binding.pry`
* continue with `exit`
* quit with `exit!`
