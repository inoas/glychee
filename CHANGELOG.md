# Changelog

## 0.2.3

- Now just requires gleam 0.24.0 instead of some unreleased nightly version.

## 0.2.2

- Changed benchee configuration settings to:

  ```elixir
  [
    warmup: 4,
    time: 8,
    memory_time: 4,
    reduction_time: 4
  ]
  ```

## v0.2.0

- Removed these dependencies: gleam's `stdlib`, `gleam_erlang`, and `gleeunit` anymore
