defmodule Tepsa.CityExchange do

  def init(city, max_numbers \\ 10_000) do
    Agent.start_link(fn -> {max_numbers, %{}} end, name: city_exchange_process_id(city))
  end

  def register_new_number(city) do
    Agent.get_and_update(city_exchange_process_id(city), fn({num, numbers}) -> 
     prefix = to_string(Tepsa.City.prefix(city))
     number = join_prefix(prefix, to_string(num))
     {:ok, telephone_process} = Task.start_link(Tepsa.Telephone, :init, [])
     numbers = Map.put(numbers, number, telephone_process)

     {number, {num - 1 , numbers}}
    end)
  end

  def get_telephone(city_exchange, number) do
    Agent.get(city_exchange, fn({_, numbers}) -> numbers[number] end)
  end

  def city_exchange_process_id(city) do
    {:global, "CityExchange##{city}"}
  end

  defp join_prefix(:error, _), do: :error
  defp join_prefix(prefix, number), do: "#{prefix}-#{number}"
end
