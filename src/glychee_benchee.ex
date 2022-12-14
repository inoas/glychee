defmodule GlycheeBenchee do
  @moduledoc """
  Allows running of Benchee from  Gleam
  """

  @doc """
  Runs Benchee with some standard settings.

  Takes a list of function tuples, for example:

      list_of_function_tuples [
        {"flat_map", fn -> Enum.flat_map(test_data, fn i -> [i, i * i]) end}
      ]
  """
  def run(list_of_function_tuples) do
    map_of_function_tuples = list_of_function_tuples |> Enum.into(%{})

    Benchee.run(
      map_of_function_tuples,
      warmup: 4,
      time: 8,
      memory_time: 4,
      reduction_time: 4
    )
  end
end
