pub type BencheeConfigurationKey {
  MemoryTime
  Parallel
  ReductionTime
  Time
  Warmup
}

pub type BencheeConfigurationValue =
  Int

@external(erlang, "Elixir.GlycheeBenchee", "initialize_configuration")
pub fn initialize() -> Nil

@external(erlang, "Elixir.GlycheeBenchee", "set_configuration_pair")
pub fn set_pair(
  key configuration_key: BencheeConfigurationKey,
  value configuration_value: BencheeConfigurationValue,
) -> Bool
