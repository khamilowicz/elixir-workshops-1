defmodule Tepsa.CityTest do
  use ExUnit.Case, async: true
  doctest Tepsa.City

  describe "register/1" do
    setup [:initialize_registers]

    test "returns city name with prefix" do
      assert {"Krakow", "2"} == Tepsa.City.register("Krakow")
      assert {"Warszawa", "1"} == Tepsa.City.register("Warszawa")
      assert {"Krakow", "2"} == Tepsa.City.register("Krakow")
    end

    test "returns {:error, :max_city_number} if all prefixes were used" do
      assert {"Krakow", "2"} == Tepsa.City.register("Krakow")
      assert {"Warszawa", "1"} == Tepsa.City.register("Warszawa")
      assert {"Poznan", "0"} == Tepsa.City.register("Poznan")
      assert {:error, :max_city_number} == Tepsa.City.register("Lodz")
      assert {:error, :max_city_number} == Tepsa.City.register("Skawina")
    end
  end

  def initialize_registers(_) do
    Tepsa.City.init(3)
    :ok
  end
end
