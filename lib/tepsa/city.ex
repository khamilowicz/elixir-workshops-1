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
  iex>  Tepsa.City.register("Warszawa")
  {"Krakow", 98}
  """
  def register(name) do
    prefix = Agent.get(__MODULE__, fn(s) -> 
     elem(s, 0)
    end)
    {name, prefix}
    end
  end
