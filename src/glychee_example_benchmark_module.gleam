//// Example module not to be called directly but could be mimicked in your
//// application or library.
////

if erlang {
  import glychee/benchmark
  import gleam/list
  import gleam/int

  /// Main function so that this call can succeed:
  /// `erl -pa ./build/dev/erlang/*/ebin -noshell -eval 'gleam@@main:run(glychee_example_benchmark_module)'`
  ///
  pub fn main() {
    benchmark.run(
      [
        benchmark.Function(
          label: "list.sort()",
          fun: fn(test_data) { fn() { list.sort(test_data, int.compare) } },
        ),
        benchmark.Function(
          label: "erlang:lists:sort()",
          fun: fn(test_data) { fn() { erlang_lists_of_int_sort(test_data) } },
        ),
      ],
      [
        benchmark.Data(label: "pre-sorted list", data: list.range(1, 100_000)),
        benchmark.Data(
          label: "reversed list",
          data: list.range(1, 100_000)
          |> list.reverse,
        ),
        benchmark.Data(
          label: "shuffled list",
          data: list.range(1, 100_000)
          |> elixir_enum_shuffle,
        ),
      ],
    )
  }

  /// Helper function to shuffle a list,
  /// because at the time of writing Gleam's stdlib did not feature `list.shuffle()`.
  ///
  external fn elixir_enum_shuffle(List(a)) -> List(a) =
    "Elixir.Enum" "shuffle"

  /// A wrapper for Erlang's built-in list sorting implementation.
  /// Used as a bechmark baseline/comparsion to Gleam's stdlib `list.sort()`.
  ///
  external fn erlang_lists_of_int_sort(List(a)) -> List(a) =
    "lists" "sort"
}
