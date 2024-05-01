# Changelog

## 1.1.2 - 2024-05-01

- Change title for better search results.

## 1.1.1 - 2024-05-01

- Change title for better search results.

## 1.1.0 - 2024-02-28

- Allow optional configuration:

  ```gleam
  import glychee/configuration
  import glychee/benchmark

  pub fn main() {
    // Configuration is optional
    configuration.initialize()
    configuration.set_pair(configuration.Warmup, 2)
    configuration.set_pair(configuration.Parallel, 2)

    // Run the benchmark
    benchmark.run(...)
  }
  ```

  As of now, all values are positive integers, and supported keys are:

  - MemoryTime
  - Parallel
  - ReductionTime
  - Time
  - Warmup

## 1.0.2 - 2024-02-27

- Fix hiding of internals.

## 1.0.1 - 2024-02-27

- Mark helpers module as internal.

## 1.0.0 - 2024-02-27

- Update for **Gleam** `~> 1.0`.
- Some code cleanup and refactorings.
- Also updates Benchee dep to `~> 1.3`.

## 0.3.0 - 2023-06-14

- Update for **Gleam** `~> 0.30`.

## 0.2.7 - 2023-01-20

- Improved readme instructions on how to run the Glychee.

## 0.2.6 - 2023-01-01

- Instruct to use `gleam add glychee --dev` to add as a dev dependency, only.

## 0.2.5 - 2023-01-01

- Fix logo on _hexpm_.

## 0.2.4 - 2023-01-01

- Readme
- Typos
- Logo

## 0.2.3 - 2022-10-25

- Now just requires Gleam 0.24.0 instead of an unreleased nightly version.

## 0.2.2 - 2022-10-25

- Changed Benchee configuration settings to:

  ```elixir
  [
    warmup: 4,
    time: 8,
    memory_time: 4,
    reduction_time: 4
  ]
  ```

## v0.2.0 - 2022-10-21

- Removed these dependencies: gleam's `stdlib`, `gleam_erlang`, and `gleeunit`,
  which means Glychee can be used in these projects to benchmark themselves.
