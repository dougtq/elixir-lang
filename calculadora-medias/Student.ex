defmodule Student do
  @moduledoc """
  Define a Student struct and functions to handle a student
  """


  defstruct name: nil, results: []

  @doc """
  Creates a student struct.

  ## Parameters
  - `name` - Full name of the student.
  """
  def main(name) do
    %Student{ name: name }
  end

  @doc """
  Get the first name of a student.

  ## Parameters
  - `student` - A student struct
  """
  def first_name(%Student{ name: name } = _student) do
    [first | _tail] = String.split(name)

    first
  end

  @doc """
  Get the last name of a student.

  ## Parameters
  - `student` - A student struct
  """
  def last_name(%Student{ name: name } = _student) do
    String.split(name)
    |>  List.last
  end
end
