defmodule Tepsa.Connection do

  def init(telephone1, number1, telephone2, number2) do
    spawn_link(__MODULE__, :loop, [telephone1, number1, telephone2, number2])
  end

  def loop(telephone1, number1, telephone2, number2) do
    receive do
      {:message, ^number1, message} ->
        send telephone1, {:message, message}
        loop(telephone1, number1, telephone2, number2)
      {:message, ^number2, message} ->
        send telephone2, {:message, message}
        loop(telephone1, number1, telephone2, number2)
      :hangup -> :ok
    end
  end
end
