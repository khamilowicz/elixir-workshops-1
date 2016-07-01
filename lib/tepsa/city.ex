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
    prefix = Agent.get(__MODULE__, fn(s) ->
      elem(s, 0)
    end)
    :ok = Agent.update(__MODULE__, fn({prefix, cities}) ->
      {prefix - 1, cities}
    end)
  {name, prefix}
  end
end
