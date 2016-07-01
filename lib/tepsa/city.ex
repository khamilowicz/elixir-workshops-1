defmodule Tepsa.City do

  @docmodule """
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
  Registers given city, returns tuple of city name and city prefix

  iex>  Tepsa.City.init
  iex>  Tepsa.City.register("Krakow")
  {"Krakow", 99}
  """
  def register(name) do
    prefix = Agent.get_and_update(__MODULE__, &register_or_return_prefix(&1, name))
    {name, prefix}
  end

  def register_or_return_prefix({prefix, cities} = state, name) do
    if cities[name] do
      {cities[name], state}
    else
      {prefix, {prefix - 1, Map.put(cities, name, prefix)}}
    end
  end
end
