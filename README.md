# Glychee · A simple Gleam benchmark runner

[![Hex Package](https://img.shields.io/hexpm/v/glychee?color=ffaff3&label=%F0%9F%93%A6)](https://hex.pm/packages/glychee)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3?label=%F0%9F%93%9A)](https://hexdocs.pm/glychee/)
[![License](https://img.shields.io/hexpm/l/glychee?color=ffaff3&label=%F0%9F%93%83)](https://github.com/inoas/glychee/blob/main/LICENSE)

A simple Gleam benchmark runner which wraps
[Benchee](https://github.com/bencheeorg/benchee) for the heavy lifting.

Named after [*Gleam*](https://gleam.run), *Benchee* and their fruity [*Lychee*](https://en.wikipedia.org/wiki/Lychee) offspring:

<figure>
  <img src="https://raw.githubusercontent.com/inoas/glychee/main/glychee-logo.png" alt="Glychee Logo" width="480" style="max-height: 10em"/>
  <figcaption><i><small>Glychee</small></i></figcaption>
</figure>

## Requirements

- Requires Gleam 0.24 or later.
- A recent Elixir and Hex must be installed. You might be required to run
  `mix local.hex` after installing Elixir.
- Only allows benchmarking of target Erang and not target JavaScript.

## Quick start

1. Add Glychee to your project: `gleam add glychee`.
2. Create a custom benchmarking module for example named `my_benchmark` that
   contains a `main`-function. In that module you will define which `Function`s
   to benchmark with one or many `Data`.
3. Run the benchmark:

   ```sh
   gleam clean && \
   gleam build && \
   erl -pa ./build/dev/erlang/*/ebin -noshell -eval 'gleam@@main:run(my_benchmark)'
   ```

### Full example

If you do not have a Gleam project yet, create it with:

```sh
gleam new foobar
cd foobar
```

Add *Glychee*: `gleam add glychee`, then in your project create a file named
`src/benchmark.gleam` with following source code:

```gleam
if erlang {
  import gleam/int
  import gleam/list
  import glychee/benchmark

  pub fn main() {
    benchmark.run(
      [
        benchmark.Function(
          label: "list.sort()",
          callable: fn(test_data) {
            fn() {
              list.sort(test_data, int.compare)
            }
          },
        ),
      ],
      [
        benchmark.Data(
          label: "pre-sorted list",
          data: list.range(1, 100_000),
        ),
        benchmark.Data(
          label: "reversed list",
          data: list.range(1, 100_000) |> list.reverse,
        ),
      ],
    )
  }
}
```

Then run in your terminal via:

```sh
gleam clean && \
gleam build && \
erl -pa ./build/dev/erlang/*/ebin -noshell -eval 'gleam@@main:run(benchmark)'
```

Now you can alter the functions and data specified in above's example to
whichever function of your application or library you want to benchmark.

Note that you can benchmark multiple functions with different data sets
in one go.

## Documentation

Glychee's documentation can be found at <https://hexdocs.pm/glychee>.

## License

[Apache 2.0](./LICENSE)
