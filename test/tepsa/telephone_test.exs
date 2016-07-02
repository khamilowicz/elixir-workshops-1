defmodule Tepsa.TelephoneTest do
  use ExUnit.Case, async: true

  import Tepsa.Test.Support

  describe "When number is registered" do
    setup [:register_exchange, :register_city, :register_number]

    test "call/1 connects to given number", %{number: number, city: city} do
      my_number = Tepsa.Exchange.register_new_number(city)
      {:ok, connection} = Tepsa.Telephone.call_number(my_number, number)

      assert [] == Tepsa.Telephone.messages(number)
      assert [] == Tepsa.Telephone.messages(my_number)

      Tepsa.Telephone.message(connection, number, "Hello")

      assert ["Hello"] == Tepsa.Telephone.messages(number)
      assert [] == Tepsa.Telephone.messages(my_number)

      Tepsa.Telephone.message(connection, my_number, "Hello back")

      assert ["Hello"] == Tepsa.Telephone.messages(number)
      assert ["Hello back"] == Tepsa.Telephone.messages(my_number)
    end
  end
end
