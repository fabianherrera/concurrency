defmodule Concurrency.CalculatorGenServer do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use GenServer

  alias Concurrency.Calculator, as: Cal

  def start(), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  def init(_), do: {:ok, 0}

  def handle_call(:get_value, _from, state), do: {:reply, state, state}

  def handle_cast({:add, value}, state), do: {:noreply, Cal.add(state, value)}

  def handle_cast({:sub, value}, state), do: {:noreply, Cal.sub(state, value)}

  def value(), do: GenServer.call(__MODULE__, :get_value)
  def add(value), do: GenServer.cast(__MODULE__, {:add, value})
  def sub(value), do: GenServer.cast(__MODULE__, {:sub, value})
end
