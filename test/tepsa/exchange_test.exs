defmodule Tepsa.ExchangeTest do
  use ExUnit.Case, async: true
  doctest Tepsa.Exchange

  import Tepsa.Test.Support

  describe "In set up exchange with registered city" do
    setup [:register_exchange, :register_city]

    test "register/2 registers new number in given city", %{prefix: prefix, city: city} do
      number = Tepsa.Exchange.register_new_number(city)

      prefix_r = Regex.compile!("^" <> prefix)
      assert number =~ prefix_r
    end
  end
end
