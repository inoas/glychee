defmodule GlycheeBenchee do
  @moduledoc """
  Allows running of Benchee from Gleam.
  """

  @type configuration_key_t() :: :warmup | :time | :memory_time | :reduction_time

  @default_warmup 4
  @default_time 4
  @default_memory_time 8
  @default_reduction_time 4
  @default_parallel 1

  @doc """
  Runs Benchee with some standard settings.

  Takes a list of function tuples.

  ## Example

  ```elixir
  list_of_function_tuples = [
    {"flat_map", fn -> Enum.flat_map(test_data, fn i -> [i, i * i]) end}
  ]
  ```
  """
  @spec run(list({String.t(), function()})) :: Benchee.Suite.t()
  def run(list_of_function_tuples),
    do:
      list_of_function_tuples
      |> Enum.into(%{})
      |> Benchee.run(get_configurations())

  @doc """
  Initializes ETS based global configuration.
  """
  @spec initialize_configuration() :: atom()
  def initialize_configuration,
    do: :ets.new(:glychee_configuration, [:set, :protected, :named_table])

  @doc """
  Sets an ETS based global configuration pair.
  """
  @spec set_configuration_pair(configuration_key_t(), pos_integer()) :: boolean()
  def set_configuration_pair(key, value) when is_atom(key),
    do: :ets.insert(:glychee_configuration, {key, value})

  @spec get_configurations() :: keyword()
  defp get_configurations do
    [
      get_configuration(:warmup, @default_warmup),
      get_configuration(:time, @default_time),
      get_configuration(:memory_time, @default_memory_time),
      get_configuration(:reduction_time, @default_reduction_time),
      get_configuration(:parallel, @default_parallel)
    ]
  end

  @spec get_configuration(configuration_key_t(), pos_integer()) :: {atom(), pos_integer()}
  defp get_configuration(key, default)
       when is_atom(key) and is_integer(default) and default > 0 do
    # Checks if the `:glychee_configuration` ETS table exists.
    if :lists.member(:glychee_configuration, :ets.all()) do
      case :ets.lookup(:glychee_configuration, key) do
        [] -> {key, default}
        [{key, value} | _tail] -> {key, value}
      end
    else
      {key, default}
    end
  end
end
