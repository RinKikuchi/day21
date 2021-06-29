defmodule Converter do

  def main do
    list = load() |> data_to_list()

    tops  =list
    |> slice_top()
    |> top_to_map()

    lines = list
    |> slice_line()
    |> line_to_map()

    triangles= list
    |> slice_triangle()
    |> triangle_to_map()

    IO.inspect(tops)
    IO.inspect(lines)
    IO.inspect(triangles)

    {:ok, json} = map_to_json(tops ++ lines ++ triangles)
    IO.inspect(json)
    |> Poison.decode!(%{keys: :atoms!})
  end

  def load do
    {:ok, data} = File.read("cube.gts")
    data
  end

  def data_to_list(data) do
    data
    |> String.replace("\n", " ")
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end

  def slice_top(list) do
   Enum.slice(list, 3, Enum.at(list, 0)*3)
  end

  def slice_line(list) do
    Enum.slice(list, Enum.at(list, 0)*3 +3, Enum.at(list, 1)*2)
  end

  def slice_triangle(list) do
    Enum.slice(list, -(Enum.at(list, 2)*3), Enum.at(list, 2)*3)
  end

  def top_to_map(top) do
     Enum.chunk_every(top, 3)
     |> Enum.map(&(Enum.zip([:x, :y, :z], &1)))
     |> Enum.map(&Enum.into(&1,%{}))
  end

  def line_to_map(line) do
    Enum.chunk_every(line, 2)
     |> Enum.map(&(Enum.zip([:start, :end], &1)))
     |> Enum.map(&Enum.into(&1,%{}))
  end

  def triangle_to_map(triangle) do
    Enum.chunk_every(triangle, 3)
    |> Enum.map(&(Enum.zip([:top1, :top2, :top3], &1)))
    |> Enum.map(&Enum.into(&1,%{}))
  end

  def map_to_json(map) do
    map
    |> Poison.encode()
  end

end
