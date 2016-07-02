defmodule Tepsa.Exchange do

  @docmodule """
  Exchange registers telephone numbers and connects them when calling
  """

  defdelegate register_new_number(city), to: Tepsa.CityExchange

  def get_telephone(number) do
    [prefix, _postfix] = String.split(number, "-", parts: 2)
    city_exchange = Tepsa.City.city_exchange(prefix)
    telephone = Tepsa.CityExchange.get_telephone(city_exchange, number)
    {:ok, telephone}
  end
end
