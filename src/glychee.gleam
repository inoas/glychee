import gleam/io

if javascript {
  pub fn main() {
    app()
  }
}

if erlang {
  import gleam/erlang
  import benchmark_runner.{DataSet, run_benchmark}
  import gleam/list
  import gleam/int

  pub fn main() {
    case erlang.start_arguments() {
      ["benchmark"] -> {
        run_benchmark(
          [
            #(
              "list.sort()",
              fn(test_data) { fn() { list.sort(test_data, int.compare) } },
            ),
          ],
          [DataSet(label: "tiny presorted list", data: list.range(1, 20))],
        )
        Nil
      }
      _ -> app()
    }
  }
}

fn app() {
  io.println("Hello from glychee!")
}
