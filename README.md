# Ruby Starter Kit
This app is a starter kit for writing code and [tests](https://github.com/seattlerb/minitest#label-Specs) in ruby. Use it as a seed for starting a new ruby project. Use the following command to copy this app's code to a new directory:
```console
mkdir -p path/to/new
cp -r path/to/this/directory path/to/new/directory
```

## Dependencies
The only local dependency you need to configure to use this codebase is `docker-compose`. This is great, because once you have docker working, it eliminates the "well it works on my machine" kind of problems. If it works on docker for you, it will work in docker for anyone.

## Install
* Build the image.
  ```console
  docker-compose build
  ```

## Run
* Drop into the container.
  ```console
  docker-compose run --rm app bash
  ```
* Run the tests.
  ```console
  rake test
  ```
* Run `irb`.
  ```console
  irb -Ilib
  ```
* Run the linter.
  ```console
  rubocop
  ```
  * For more usage instructions, see [the rubocop documentation](https://docs.rubocop.org/rubocop/usage/basic_usage.html).

## Debug
* Documentation for `pry` is [here](https://github.com/pry/pry).
* Set a breakpoint with `require 'pry'; ::Kernel.binding.pry`.
* Show where you are with `whereami`.
* Continue with `exit`.
* Quit with `exit!`.
