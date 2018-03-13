# este módulo debería llamarse CalculatorConcurrency
# y el archivo debería llamarse calculator_concurrency
# y debería hacer un módulo Concurrency.Calculator con las operaciones
# es ridículo en este caso pero estamos simulando un caso de negocio real

defmodule Concurrency.CalculatorConcurrency do
  @spec value(pid :: pid) :: integer()

  # Servidor
  def start, do: spawn(fn -> loop(0) end)
  # Encapsular toda la lógica de negocio en un módulo externo
  alias Concurrency.Calculator, as: Cal

  # Resumen:
  # llamar pid a los process_id
  def value(pid) do
    send(pid, {:get_value, self()})

    receive do
      {:ok, value} -> value
    end
  end

  # No llamar a value() después de ejecutar el mutator
  def add(pid, value), do: send(pid, {:add, value})
  def sub(pid, value), do: send(pid, {:sub, value})

  defp loop(current_state) do
    new_state =
      receive do
        {:get_value, client_id} ->
          # devolver el valor del current_state en el query
          # aquí no estás devolviéndole el state a new_state, le estás devolviendo un pid
          send(client_id, {:ok, current_state})
          # aquí lo devuelves <---- aquí
          current_state

        # aquí se supone que llamas a la calculadora
        {:add, value} ->
          Cal.add(current_state, value)

        {:sub, value} ->
          Cal.sub(current_state, value)
      end

    loop(new_state)
  end
end
