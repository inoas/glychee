import gleam/list
import gleam/string
import gleam/io

pub type Function(test_data, any) {
  Function(label: String, fun: fn(test_data) -> any)
}

pub type Data(data) {
  Data(label: String, data: data)
}

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

external fn benchee_wrapper_run(List(#(String, any))) -> any =
  "Elixir.GlycheeBenchee" "run"
