defmodule Tepsa.Telephone do
  require Logger

  def init do
    listen([])
  end

  def listen(messages) do
    receive do
      {:messages, from} ->
        send from, {:messages, messages}
        listen(messages)
      {:message, message} -> 
        listen([message | messages])
      other ->
        listen(messages)
    end
  end

  def message(connection, number, message) do
    send connection, {:message, number, message}
  end

  def messages(number) do
    {:ok, telephone} =  Tepsa.Exchange.get_telephone(number)
    send telephone, {:messages, self}
    receive do
      {:messages, messages} -> messages
    end
  end

  def call_number(caller, number) when is_bitstring(number) do
    {:ok, caller_telephone} =  Tepsa.Exchange.get_telephone(caller)
    {:ok, telephone} =  Tepsa.Exchange.get_telephone(number)

    {:ok, Tepsa.Connection.init(caller_telephone, caller, telephone, number)}
  end
end
