# Glychee · A Simple Gleam Benchmark Runner

[![Hex Package](https://img.shields.io/hexpm/v/glychee?color=ffaff3&label=%F0%9F%93%A6)](https://hex.pm/packages/glychee)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3?label=%F0%9F%93%9A)](https://hexdocs.pm/glychee/)
[![License](https://img.shields.io/hexpm/l/glychee?color=ffaff3&label=%F0%9F%93%83)](https://github.com/inoas/glychee/blob/main/LICENSE)

A simple [Gleam](https://gleam.run) benchmark runner which wraps [**Benchee**](https://github.com/bencheeorg/benchee) for the heavy lifting.

Named after *Gleam*, *Benchee* and their fruity [*Lychee*](https://en.wikipedia.org/wiki/Lychee) offspring:

<figure>
  <img src="https://raw.githubusercontent.com/inoas/glychee/main/glychee-logo.jpg" alt="Glychee Logo" style="max-height: 33vh; width: auto; height: auto" width="480" height="480"/>
  <figcaption><i><small>Imaginary Glychees</small></i></figcaption>
</figure>

## Requirements

- Requires **Gleam 1.0** or later.
- For benchmarking on target JavaScript see <https://hex.pm/packages/gleamy_bench>,
  as Glychee only allows benchmarking on target Erlang.
- Glychee is dependency free except for *Benchee* and *Elixir*.
- A recent Elixir and Hex must be installed. You might be required to run
  `mix local.hex` after installing Elixir.

## Quick start

1. Add ***Glychee*** to your project: `gleam add glychee --dev`.
2. Create a custom benchmarking module for example named `my_benchmark` that
   contains a `main`-function. In that module you will define which `Function`s
   to benchmark with one or many `Data`.
3. Run the benchmark:

   ```shell
   gleam clean && \
   gleam build && \
   gleam run -m my_benchmark
   ```

### Full example

If you do not have a Gleam project yet, create it with:

```shell
gleam new foobar
cd foobar
```

To add and run a demo of **Glychee**:

1. `gleam add glychee --dev`
2. In your project create a file named `src/my_benchmark.gleam` with following source code:

   ```gleam
   import gleam/int
   import gleam/list
   import glychee/benchmark
   import glychee/configuration

   pub fn main() {
     // Configuration is optional
     configuration.initialize()
     configuration.set_pair(configuration.Warmup, 2)
     configuration.set_pair(configuration.Parallel, 2)

     // Run the benchmarks
     benchmark.run(
       [
         benchmark.Function(label: "list.sort()", callable: fn(test_data) {
           fn() { list.sort(test_data, int.compare) }
         }),
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
   ```

3. Then run in your terminal via:

   ```shell
   gleam clean && \
   gleam build && \
   gleam run -m my_benchmark
   ```

Now you can alter the functions and data specified in above's example to
whichever function of your application or library you want to benchmark.

Note that you can benchmark multiple functions with different data sets
in one go.

## Documentation

**Glychee**'s documentation can be found at <https://hexdocs.pm/glychee>.

## License

[Apache 2.0](./LICENSE)
