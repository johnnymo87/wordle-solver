# Ruby Starter Kit
This app is a starter kit for writing code and [tests](https://github.com/seattlerb/minitest#label-Specs) in ruby. Use it as a seed for starting a new ruby project. Use the following command to copy this app's code to a new directory:
```console
mkdir -p path/to/new
cp -r path/to/this/directory path/to/new/directory
```

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

## Debug
* Documentation for `pry` is [here](https://github.com/pry/pry).
* Set a breakpoint with `require 'pry'; ::Kernel.binding.pry`.
* Show where you are with `whereami`.
* Continue with `exit`.
* Quit with `exit!`.
