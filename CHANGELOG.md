# Changelog

## 0.2.4

- Readme
- Typos
- Logo

## 0.2.3

- Now just requires Gleam 0.24.0 instead of an unreleased nightly version.

## 0.2.2

- Changed Benchee configuration settings to:

  ```elixir
  [
    warmup: 4,
    time: 8,
    memory_time: 4,
    reduction_time: 4
  ]
  ```

## v0.2.0

- Removed these dependencies: gleam's `stdlib`, `gleam_erlang`, and `gleeunit`,
  which means Glychee can be used in these projects to benchmark themselves.
