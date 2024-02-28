//// Optional configuration of Benchee.
////
//// Configuration is stored in ETS.

/// For details see [Benchee docs' configuration chapter](https://hexdocs.pm/benchee/Benchee.Configuration.html#t:user_configuration/0).
pub type BencheeConfigurationKey {
  MemoryTime
  Parallel
  ReductionTime
  Time
  Warmup
}

/// Configuration values are all positive integers.
///
pub type BencheeConfigurationValue =
  Int

/// Initialize the ETS configuration table.
///
@external(erlang, "Elixir.GlycheeBenchee", "initialize_configuration")
pub fn initialize() -> Nil

/// Set a config pair.
///
@external(erlang, "Elixir.GlycheeBenchee", "set_configuration_pair")
pub fn set_pair(
  key configuration_key: BencheeConfigurationKey,
  value configuration_value: BencheeConfigurationValue,
) -> Bool
