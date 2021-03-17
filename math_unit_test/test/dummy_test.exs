defmodule DummyTest do
  use ExUnit.Case

  setup do
    IO.puts "Initial Setup"

    on_exit(&cleanup/0)

	  %{
		  status: :sleeping
	  }
	end

  setup :define_test_data

  setup context do
    IO.puts "Additional Setup"
		IO.puts "Current Context: #{inspect(context)}"

		:ok
	end

  defp define_test_data(context) do
    IO.puts "Current Context: #{inspect(context)}"
    IO.puts "Inside define_test_data"

	  %{
      status: :running
	  }
	end

  defp cleanup() do
	  IO.puts "Cleaning up after the test"
  end

  test "Some dummy test", context do
      IO.puts "Running the dummy test"
      IO.puts "Final Context: #{inspect(context)}"
  end
end
