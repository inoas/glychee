import gleam/list
import gleam/string
import gleam/io

pub type FunctionSet(test_data, any) {
  FunctionSet(label: String, callable: fn(test_data) -> any)
}

pub type DataSet(data) {
  DataSet(label: String, data: data)
}

pub fn run_benchmark(
  function_sets: List(#(String, fn(data) -> a)),
  data_sets: List(DataSet(data)),
) -> Nil {
  data_sets
  |> list.each(fn(data_set) {
    let data_label = data_set.label
    let data = data_set.data

    io.print("\n\n")
    io.println(string.repeat("=", 80))
    io.println(
      "== data set: " <> data_label <> " "
      |> string.pad_right(80, "="),
    )
    io.println(string.repeat("=", 80))
    io.print("\n")

    function_sets
    |> list.map(fn(function_set) {
      let function_label = function_set.0
      let function = function_set.1
      io.debug(function)
      let benchmark_callable = function(data)
      #(function_label, benchmark_callable)
    })
    |> run_on_benchee_base
  })

  Nil
}

external fn run_on_benchee_base(List(#(String, a))) -> a =
  "Elixir.BencheeWrapper" "run"
