defmodule Tepsa.CityTest do
  use ExUnit.Case, async: true
  doctest Tepsa.City

  describe "register/1" do
    setup [:initialize_registers]

    test "returns city name with prefix" do
      assert {"Krakow", 99} == Tepsa.City.register("Krakow")
      assert {"Warszawa", 98} == Tepsa.City.register("Warszawa")
      assert {"Krakow", 99} == Tepsa.City.register("Krakow")
    end
  end

  def initialize_registers(_) do
    Tepsa.City.init
    :ok
  end
end
