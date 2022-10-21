//// Benchmark
////
//// Contain's custom types and a runner function to process those.
////
//// ### Example
////
//// ```gleam
//// // In your application or library in src/benchmark.gleam:
//// import glychee/benchmark
//// import gleam/list
//// import gleam/int
////
//// pub fn main() {
////   benchmark.run(
////     [
////       benchmark.Function(
////         // swap the label for your function name's
////         label: "list.sort()",
////         fun: fn(test_data) {
////          fn() {
////            // swap for your function to benchmark
////            list.sort(test_data, int.compare)
////          }
////        },
////       ),
////       // You can add another function here to compare against.
////     ],
////     [
////       // Replace these with data expected by your function(s).
////       benchmark.Data(
////        label: "pre-sorted list",
////        data: list.range(1, 100_000)
////      ),
////       benchmark.Data(
////         label: "reversed list",
////         data: list.range(1, 100_000)
////         |> list.reverse,
////       )
////     ],
////   )
//// }
//// ```
////
//// Run via:
////
//// ```
//// gleam clean && \
//// gleam build && \
//// erl -pa ./build/dev/erlang/*/ebin -noshell -eval 'gleam@@main:run(benchmark)'
//// ```

import gleam/list
import gleam/string
import gleam/io

/// Function pairs a `label` with a function returning a callable.
/// The function requires some `test_data`.
///
/// The label is used as part of the benchmark's stdout output.
///
pub type Function(test_data, any) {
  Function(label: String, fun: fn(test_data) -> any)
}

/// Data pairs arbitrary data, such as a `List(Int)` with a label.
///
/// The label is used as part of the benchmark's stdout output.
///
pub type Data(data) {
  Data(label: String, data: data)
}

/// Takes a List of Function and List of Data and runs benchmarks for each
/// Function combined with each Data grouped by Data first and Function
/// second.
///
/// Utilized Benchee and its stdout's output for the function benchmarking.
///
pub fn run(
  function_sets: List(Function(test_data, any)),
  data_sets: List(Data(test_data)),
) -> Nil {
  list.each(
    data_sets,
    fn(data_set) {
      io.print("\n\n")
      io.println(string.repeat("=", 80))
      io.println(
        "== data set: " <> data_set.label <> " "
        |> string.pad_right(80, "="),
      )
      io.println(string.repeat("=", 80))
      io.print("\n")

      function_sets
      |> list.map(fn(function_set) {
        #(function_set.label, function_set.fun(data_set.data))
      })
      |> benchee_wrapper_run
    },
  )
}

/// Wrapper for Elixir's Benchee
///
external fn benchee_wrapper_run(List(#(String, any))) -> any =
  "Elixir.GlycheeBenchee" "run"
