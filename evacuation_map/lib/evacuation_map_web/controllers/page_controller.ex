defmodule EvacuationMapWeb.PageController do
  use EvacuationMapWeb, :controller

  def index(conn, params) do
    {:ok, data} = File.read("130001_evacuation_center.csv")
    [hd|tl] = data|> String.trim("\uFEFF")|> String.split("\r\n")|> Enum.map(&String.split(&1,","))
    cities = Enum.map(tl, &Enum.at(&1, 3))|> Enum.uniq()
    centers = Enum.map(tl, &Enum.zip(hd,&1))|> Enum.map(&Enum.into(&1, %{}))
    render(conn, "index.html", cities: cities, centers: centers, selected: params["city"])
  end
end
