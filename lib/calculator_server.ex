defmodule Concurrency.CalculatorServer do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias Concurrency.Calculator, as: Cal
  alias Concurrency.ServerProcess, as: Gserver

  def start(), do: Gserver.start(CalculatorServer)

  def init(), do: {:ok, 0}

  def handle_call(:get_value, state), do: {state, state}

  def handle_cast({:add, value}, state) do
    Cal.add(state, value)
  end
  def handle_cast({:sub, value}, state) do
    Cal.sub(state, value)
  end

  def value(pid) do
    Gserver.call(pid, :get_value)
  end

  # No llamar a value() después de ejecutar el mutator
  def add(pid, value), do: Gserver.cast(pid, {:add, value})
  def sub(pid, value), do: Gserver.cast(pid, {:sub, value})
end
