defmodule Concurrency.CalculatorAgent do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias Concurrency.Calculator, as: Cal

  def start(), do: Agent.start_link(fn -> 0 end, name: __MODULE__)

  def value, do: Agent.get(__MODULE__, &(&1))
  def add(value), do: Agent.update(__MODULE__, &Cal.add(&1, value))
  def sub(value), do: Agent.update(__MODULE__, &Cal.sub(&1, value))
end
