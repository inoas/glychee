import gleam/list
import gleam/string
import gleam/io

pub fn run(
  function_sets: List(#(String, fn(data) -> a)),
  data_sets: List(#(String, data)),
) -> Nil {
  data_sets
  |> list.each(fn(data_set) {
    let data_label = data_set.0
    let data = data_set.1

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
      let benchmark_callable = function(data)
      #(function_label, benchmark_callable)
    })
    |> run_on_benchee_base
  })

  Nil
}

external fn run_on_benchee_base(List(#(String, a))) -> a =
  "Elixir.BencheeWrapper" "run"
