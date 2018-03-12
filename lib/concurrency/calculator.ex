defmodule Concurrency.Calculator do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  # use Application
  @doc """
  Substraction function for CurrencyCalculator, it subs a number to a initial value, handled by ConcurrencyCalculator.loop
  """
  def sub(current_value, value), do: current_value - value

  @doc """
  Add function for CurrencyCalculator, it adds a number to a initial value, handled by ConcurrencyCalculator.loop
  """
  def add(current_value, value), do: current_value + value
end
