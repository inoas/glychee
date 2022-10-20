import gleam/io

if javascript {
  pub fn main() {
    app()
  }
}

if erlang {
  import gleam/erlang
  import benchmark_runner
  import gleam/list
  import gleam/int

  pub fn main() {
    case erlang.start_arguments() {
      ["benchmark"] -> {
        benchmark_runner.run(
          [
            #(
              "list.sort()",
              fn(test_data) { fn() { list.sort(test_data, int.compare) } },
            ),
          ],
          [#("tiny presorted list", list.range(1, 20))],
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
