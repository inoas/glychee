//// Contains custom types `Function` and `Data` and a runner function to run
//// a list of these benchmark functions against a list of benchmark data.

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
  gleam_stdlib_each(
    data_list,
    fn(data) {
      erlang_io_put_chars("\n\n")
      erlang_io_put_chars(separator_line <> "\n")
      erlang_io_put_chars("==== data set: " <> data.label)
      erlang_io_put_chars("\n")
      erlang_io_put_chars(separator_line <> "\n")
      erlang_io_put_chars("\n")

      function_list
      |> erlang_lists_map(
        fn(function: Function(test_data, any)) {
          #(function.label, function.callable(data.data))
        },
        _,
      )
      |> benchee_wrapper_run
    },
  )
}

/// Copy of stdlib's implementation.
/// Copied here, so that there are no deps on Glychee.
///
fn gleam_stdlib_each(list: List(a), f: fn(a) -> b) -> Nil {
  case list {
    [] -> Nil
    [x, ..xs] -> {
      f(x)
      gleam_stdlib_each(xs, f)
    }
  }
}

/// Replaces stdlib's io.println
/// so that there are no deps on Glychee.
///
external fn erlang_io_put_chars(text: String) -> Nil =
  "io" "put_chars"

/// Replaces stdlib's list.map
/// so that there are no deps on Glychee.
///
external fn erlang_lists_map(callable: fn(a) -> b, list: List(a)) -> List(b) =
  "lists" "map"

/// Wrapper for Elixir's Benchee
///
external fn benchee_wrapper_run(
  list_of_function_tuples: List(#(String, any)),
) -> any =
  "Elixir.GlycheeBenchee" "run"

if javascript {
  import gleam/int

  external type Timer

  pub fn run_benchmarks() -> Nil {
    let bench_data =
      list.repeat("The quick brown fox jumps over the lazy dog", 10_000_000)

    let bench_timer = create_timer()
    bench_data
    |> string.join_old("\n")
    let timing = read_timer(bench_timer)
    io.print(
      "string.join (current impl) took " <> int.to_string(timing) <> "ms\n",
    )

    let bench_timer = create_timer()
    bench_data
    |> string.join_gleam("\n")
    let timing = read_timer(bench_timer)
    io.print(
      "string.join (gleam impl) took " <> int.to_string(timing) <> "ms\n",
    )

    let bench_timer = create_timer()
    bench_data
    |> string.join("\n")
    let timing = read_timer(bench_timer)
    io.print("string.join (js ffi impl) " <> int.to_string(timing) <> "ms\n")

    Nil
  }

  external fn create_timer() -> Timer =
    "./glychee.mjs" "create_timer"

  external fn read_timer(timer: Timer) -> Int =
    "./glychee.mjs" "read_timer"
}
