//// Contains custom types `Function` and `Data` and a runner function to run
//// a list of these benchmark functions against a list of benchmark data.
////

import glychee/helpers as h

/// Function pairs a `label` with a function returning a callable.
///
/// The function requires some `test_data`.
///
/// The label is used as part of the benchmark's stdout output.
///
pub type Function(test_data, any) {
  Function(label: String, callable: fn(test_data) -> fn() -> any)
}

/// Data pairs arbitrary data to benchmark on with a label.
///
/// The label is used as part of the benchmark's `stdout` output.
///
pub type Data(data) {
  Data(label: String, data: data)
}

/// Separator to be used for stdout printing
///
const separator_line = "================================================================================"

/// Takes a `List` of `Function` and `List` of `Data` and runs benchmarks for each
/// `Function` combined with each `Data` grouped by `Data` first and `Function`
/// second.
///
/// Utilizes `Benchee` and its `stdout`'s output to print the function's benchmark
/// results for all data.
///
pub fn run(
  function_list: List(Function(test_data, any)),
  data_list: List(Data(test_data)),
) -> Nil {
  h.gleam_list_each(data_list, fn(data) {
    h.gleam_io_println("\n\n")
    h.gleam_io_println(separator_line <> "\n")
    h.gleam_io_println("==== data set: " <> data.label)
    h.gleam_io_println("\n")
    h.gleam_io_println(separator_line <> "\n")
    h.gleam_io_println("\n")

    function_list
    |> h.gleam_list_map(fn(function: Function(test_data, any)) {
      #(function.label, function.callable(data.data))
    })
    |> benchee_wrapper_run
  })
}

/// Wrapper for Elixir's Benchee
///
@external(erlang, "Elixir.GlycheeBenchee", "run")
fn benchee_wrapper_run(
  list_of_function_tuples list_of_function_tuples: List(#(String, any)),
) -> any
