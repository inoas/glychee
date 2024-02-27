//// Contains helper functions copied from Gleam's stlib,
//// so that there are no deps on Glychee.
////

/// Replaces stdlib's `list.each`.
///
pub fn gleam_list_each(list: List(a), f: fn(a) -> b) -> Nil {
  case list {
    [] -> Nil
    [x, ..xs] -> {
      f(x)
      gleam_list_each(xs, f)
    }
  }
}

/// Replaces stdlib's `io.println`
///
@external(erlang, "io", "put_chars")
pub fn gleam_io_println(text text: String) -> Nil

/// Replaces stdlib's `list.map`
///
pub fn gleam_list_map(
  list list: List(a),
  callable callable: fn(a) -> b,
) -> List(b) {
  do_erlang_lists_map(callable, list)
}

@external(erlang, "lists", "map")
fn do_erlang_lists_map(
  callable callable: fn(a) -> b,
  list list: List(a),
) -> List(b)
