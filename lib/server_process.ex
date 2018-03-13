defmodule Concurrency.ServerProcess do # abc
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  # @name :Server_process

  def start(module) do
    {:ok, initial_value} = module.init()
    spawn(fn -> loop(module, initial_value) end) # xyz
  end

  def call(server_pid, request) do # query
    send(server_pid, {:call, request, self()}) # abc

    receive do
      {:response, response} -> response
    end
  end

  def cast(server_pid, request) do # mutator
    send(server_pid, {:cast, request})
  end

  defp loop(module, current_state) do
    new_state =
      receive do
        {:call, request, caller} ->
          {response, new_state} = module.handle_call(request, current_state)
          send(caller, {:response, response})
          new_state

        {:cast, request} ->
          module.handle_cast(request, current_state)
      end

    loop(module, new_state)
  end
end
