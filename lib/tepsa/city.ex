defmodule Tepsa.City do

  @moduledoc """
  This module implements city register
  """


  @doc """
  Initialize city registry

  iex> {:ok, pid} = Tepsa.City.init
  iex> is_pid(pid)
  true
  """
  def init(max_cities \\ 100) do
    Agent.start_link(fn -> {max_cities - 1, %{}} end, name: __MODULE__)
  end

  @doc """
  Returns prefix for given city of :error
  """
  def prefix(city) do
    case Agent.get(__MODULE__, fn({_, cities}) -> cities[city] end) do
      prefix when is_bitstring(prefix) -> prefix
      _other -> :error
    end
  end

  def city_exchange(prefix) do
    city =
      Agent.get(__MODULE__, fn({_, cities}) -> 
       {city, _p} = Enum.find(cities, fn({city, c_prefix}) -> prefix == c_prefix end)
       city
      end)
    Tepsa.CityExchange.city_exchange_process_id(city)
  end

  @doc """
  Registers given city, returns tuple of city name and city prefix

  iex>  Tepsa.City.init
  iex>  Tepsa.City.register("Krakow")
  {"Krakow", "99"}
  """
  def register(name) do
    Agent.get_and_update(__MODULE__, __MODULE__, :register_or_return_prefix, [name])
  end

  def register_or_return_prefix({-1, _cities} = state, _name) do
    {{:error, :max_city_number}, state}
  end
  def register_or_return_prefix({prefix, cities} = state, name) do
    if cities[name] do
      {{name, cities[name]}, state}
    else
      {{name, to_string(prefix)}, {prefix - 1, Map.put(cities, name, to_string(prefix))}}
    end
  end
end
