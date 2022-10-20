# Glychee

[![Package Version](https://img.shields.io/hexpm/v/glychee)](https://hex.pm/packages/glychee)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glychee/)

A simple gleam benchmark runner which wraps
<https://github.com/bencheeorg/benchee>.

## Quick start

_Notice: Requires at least gleam 0.24 (or gleam 0.0.0-nightly-221019 or later)._

Also requires elixir and hex to be installed. You might be required to run
`mix local.hex` after installing elixir.

1. Add glychee to your project: `gleam add glychee`.
2. Create a a custom benchmarking module that contains a `main`-function.
   See `glychee_example_benchmark_module.gleam` as an example.
   In that module you will define which `Function`s to benchmark with one or
   many `Data`.
3. Run the benchmark. `bin/glychee_example_benchmark_call.sh` in this
   library's source shows an example on how do do it:

### Example

If you do not have a project yet, create it with:

```sh
gleam new foobar
cd foobar
```

Create a file named `src/benchmark.gleam` with following contents:

```gleam
if erlang {
  import glychee/benchmark
  import gleam/list
  import gleam/int

  pub fn main() {
    benchmark.run(
      [
        benchmark.Function(
          label: "list.sort()",
          fun: fn(test_data) { fn() { list.sort(test_data, int.compare) } },
        ),
      ],
      [
        benchmark.Data(label: "pre-sorted list", data: list.range(1, 100_000)),
        benchmark.Data(
          label: "reversed list",
          data: list.range(1, 100_000)
          |> list.reverse,
        ),
      ],
    )
  }
}
```

Then run via:

```sh
gleam clean && \
gleam build && \
erl -pa ./build/dev/erlang/*/ebin -noshell \
  -eval 'gleam@@main:run(benchmark)'
```

## Installation

If available on Hex this package can be added to your Gleam project:

```sh
gleam add glychee
```

Glychee's documentation can be found at <https://hexdocs.pm/glychee>.
