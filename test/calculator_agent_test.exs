defmodule Concurrency.CalculatorAgentTest do
  use ExUnit.Case
  doctest Concurrency.CalculatorAgent

  @module Concurrency.CalculatorAgent

  test "adding a value to current state via add function" do
    @module.start()
    assert @module.add(50) == :ok
    assert @module.value() == 50
  end

  test "substracting a value to current state via sub function" do
    @module.start()
    assert @module.sub(50) == :ok
    assert @module.value() == -50
  end

  test "returns a value of 0, once initializated via value function" do
    @module.start()
    assert @module.value() == 0
  end
end
