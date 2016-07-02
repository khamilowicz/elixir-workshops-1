defmodule Tepsa.Test.Support do

  def register_exchange(context) do
    Tepsa.CityExchange.init("Krakow")
    context
  end

  def register_city(context) do
    Tepsa.City.init
    {city, prefix} = Tepsa.City.register("Krakow")
    context
    |> Map.put(:city, city)
    |> Map.put(:prefix, to_string(prefix))
  end

  def register_number(context) do
    number = Tepsa.Exchange.register_new_number(context[:city])
    Map.put(context, :number, number)
  end
end
