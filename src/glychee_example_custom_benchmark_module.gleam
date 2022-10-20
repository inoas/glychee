if erlang {
  import glychee/benchmark
  import gleam/list
  import gleam/int

  pub fn main() {
    benchmark.run(
      [
        benchmark.Function(
          label: "list.merge_sort()",
          fun: fn(test_data) { fn() { list.sort(test_data, int.compare) } },
        ),
        benchmark.Function(
          label: "list.insertion_sort()",
          fun: fn(test_data) { fn() { list.sort(test_data, int.compare) } },
        ),
      ],
      [
        benchmark.Data(label: "tiny presorted list", data: list.range(1, 20)),
        benchmark.Data(
          label: "medium presorted list",
          data: list.range(1, 1000),
        ),
      ],
    )
  }
}
