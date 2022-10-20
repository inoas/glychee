# glychee

[![Package Version](https://img.shields.io/hexpm/v/glychee)](https://hex.pm/packages/glychee)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glychee/)

A simple gleam benchmark runner which wraps <https://github.com/bencheeorg/benchee>.

## Quick start

Notice: Requires at least gleam 0.0.0-nightly-221019 or gleam 0.24.

1. Add glychee to your project: `gleam add glychee`.
2. Create a a custom benchmarking module that contains a main function.
   See `glychee_example_custom_benchmark_module.gleam` as an example.
   In that module you will define which `Function`s to benchmark with one or many `Data`.
3. Run the benchmark. `bin/glychee_example_benchmark_call.sh` in this library shows an example on how do do it:

   ```sh
   erl -pa ./build/dev/erlang/*/ebin -noshell -eval \
     'gleam@@main:run(glychee_example_custom_benchmark_module)';
   ```

## Installation

If available on Hex this package can be added to your Gleam project:

```sh
gleam add glychee
```

Glychee's documentation can be found at <https://hexdocs.pm/glychee>.
