defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def hello do
    :world
  end

  @spec main(charlist) :: %Identicon.Image{}
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @spec hash_input(charlist) :: %Identicon.Image{}
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list

    %Identicon.Image{ hex: hex }
  end

  @spec pick_color(%Identicon.Image{hex: [byte]}) :: %Identicon.Image{}
  def pick_color(%Identicon.Image{ hex: [r, g, b | _tail ] } = image) do
    %Identicon.Image{ image | rgb: { r, g, b }}
  end

  @spec build_grid(%Identicon.Image{hex: [byte], rgb: {byte}}) :: %Identicon.Image{}
  def build_grid(%Identicon.Image{ hex: hex } = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{ image | grid: grid }
  end

  @spec mirror_row(list) :: list
  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end

  @spec filter_odd_squares(%Identicon.Image{}) :: %Identicon.Image{}
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter(grid, fn({ x, _y }) ->
      rem(x, 2) == 0
    end)

    %Identicon.Image{image | grid: grid}
  end

  @spec build_pixel_map(%Identicon.Image{}) :: %Identicon.Image{}
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({ _code, idx }) ->
      horizontal = rem(idx, 5) * 50
      vertical = div(idx, 5) * 50

      top_left = { horizontal, vertical }
      bottom_right = { horizontal + 50, vertical  + 50}

      { top_left, bottom_right }
    end

    %Identicon.Image{ image | pixel_map: pixel_map }
  end

  @spec draw_image(%Identicon.Image{}) :: binary
  def draw_image(%Identicon.Image{rgb: rgb, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill_object = :egd.color(rgb)

    Enum.each pixel_map, fn({ start, stop }) ->
      :egd.filledRectangle(image, start, stop, fill_object)
    end

    :egd.render(image)
  end

  @spec save_image(binary, charlist) :: :ok | {:error, atom}
  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end
end
