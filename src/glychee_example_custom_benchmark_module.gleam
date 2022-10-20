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
        benchmark.Function(
          label: "erlang:lists:sort()",
          fun: fn(test_data) { fn() { erlang_lists_of_int_sort(test_data) } },
        ),
      ],
      [
        benchmark.Data(label: "pre-sorted list", data: list.range(1, 1_000)),
        benchmark.Data(
          label: "reversed list",
          data: list.range(1, 1_000)
          |> list.reverse,
        ),
        benchmark.Data(
          label: "shuffled list",
          data: list.range(1, 1_000)
          |> elixir_enum_shuffle,
        ),
      ],
    )
  }

  external fn elixir_enum_shuffle(List(a)) -> List(a) =
    "Elixir.Enum" "shuffle"

  external fn erlang_lists_of_int_sort(List(a)) -> List(a) =
    "lists" "sort"
}
