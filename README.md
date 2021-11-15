# Ruby Starter Kit

A starter kit for writing code and [tests](https://github.com/seattlerb/minitest#label-Specs) in ruby.

#### Dependencies
* docker
* docker-compose

## Install
* Build the image.
  ```sh
  docker-compose build
  ```

## Run
* Drop into the container.
  ```sh
  docker-compose run --rm app bash
  ```
* Run the tests.
  ```sh
  rake test
  ```
* Run `irb`.
  ```sh
  irb -Ilib
  ```
* Run the linter.
  ```sh
  rubocop
  ```
  * For more usage instructions, see [the rubocop documentation](https://docs.rubocop.org/rubocop/usage/basic_usage.html).


## Copy
* This command will clone even hidden files and directories.
  ```sh
  mkdir -p path/to/new
  cp -rT path/to/this/directory path/to/new/directory
  ```
  * It's OK if `path/to/new/directory` already exists.
  * It's not OK if `path/to/new` doesn't exist, hence the `mkdir -p`.

## Debug
* Documentation for `pry` is [here](https://github.com/pry/pry).
* Set a breakpoint with `require 'pry'; ::Kernel.binding.pry`.
* Show where you are with `whereami`.
* Continue with `exit`.
* Quit with `exit!`.
