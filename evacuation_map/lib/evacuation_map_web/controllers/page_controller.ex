defmodule EvacuationMapWeb.PageController do
  use EvacuationMapWeb, :controller

  def index(conn, params) do
    {:ok, data} = File.read("130001_evacuation_center.csv")
    [hd|tl] = data|> String.trim("\uFEFF")|> String.split("\r\n")|> Enum.map(&String.split(&1,","))
    cities = Enum.map(tl, &Enum.at(&1, 3))|> Enum.uniq()
    centers = Enum.map(tl, &Enum.zip(hd,&1))|> Enum.map(&Enum.into(&1, %{}))
    lat = 35.685344
    lng = 139.739763
    render(conn, "index.html", cities: cities, centers: centers, selected: params["city"], lat: lat, lng: lng, searched: params["address"])
  end

  def push(conn, params) do
    %{"address" => searched} = params
    url = "https://www.geocoding.jp/api/"
    %HTTPoison.Response{body: body} = HTTPoison.get!(url,[], params: [q: searched])
    IO.inspect("------------------------------")
    IO.inspect(body)
    IO.inspect("------------------------------")
    map = XmlToMap.naive_map(body)
    IO.inspect("------------------------------")
    IO.inspect(map)
    IO.inspect("------------------------------")
    lat = map["result"]["coordinate"]["lat"]
    lng = map["result"]["coordinate"]["lng"]
    searched_city = String.trim(params["address"],"東京都")
    {:ok, data} = File.read("130001_evacuation_center.csv")
    [hd|tl] = data|> String.trim("\uFEFF")|> String.split("\r\n")|> Enum.map(&String.split(&1,","))
    cities = Enum.map(tl, &Enum.at(&1, 3))|> Enum.uniq()
    centers = Enum.map(tl, &Enum.zip(hd,&1))|> Enum.map(&Enum.into(&1, %{}))
    render(conn, "index.html", cities: cities, centers: centers, searched: searched_city, selected: params["city"], lat: lat, lng: lng)
  end
end
