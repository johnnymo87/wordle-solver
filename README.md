# Wordle Solver

This is a solver for the viral [wordle game](https://www.powerlanguage.co.uk/wordle/). __**STOP! A wordle solver is anti-fun!**__ Unless you have a weird definition of fun, like me :)

This solver is inspired by [this reddit post](https://www.reddit.com/r/wordlegame/comments/ruqhh6/i_did_some_analysis_on_the_best_words_to_get), and helped along by [this word list](https://gist.github.com/b0o/fcd431739fe483c1fe3aee9381da275d), found by [Maddison Hellstrom](https://github.com/b0o).

Run the solver like so:
```console
docker-compose run --rm app ruby lib/wordle.rb
```
The solver prints five suggestions, but you'll probably only ever take the first one. The first suggested one is always `slate`. Take `slate` and enter it into the wordle game. Take the wordle game's response and enter it into this program, as shown in the demo below. Enter the word you used, followed by a space, followed by a tally of each letter's color, using `g` for green, `y` for yellow, and `b` for black, and then press enter. For example, in the demo below, when I entered `slate` into wordle, it scored `bbgbb`, so I typed `slate bbgbb` into this program, and then the program recommended a new guess to me.

## Demo
![wordle-solver](https://user-images.githubusercontent.com/3466499/148653596-4a29a114-1ba6-4dce-a45b-a487648f9a36.gif)

## Dependencies
The only local dependency you need to configure to use this codebase is `docker-compose`. This is great, because once you have docker working, it eliminates the "well it works on my machine" kind of problems. If it works on docker for you, it will work in docker for anyone.

## Install
* Build the image.
  ```console
  docker-compose build
  ```

## Run
* Run the app one time and exit:
  ```console
  docker-compose run --rm app
  ```
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
* Documentation for `debug.gem` is [here](https://github.com/ruby/debug).
* Set a breakpoint with `require 'debug'; binding.break`.
* Show where you are with `list` and `list -`.
* Continue with `continue`.
* Quit and kill the program with `kill!`.
* More control flow options are documented [here](https://github.com/ruby/debug#control-flow).
