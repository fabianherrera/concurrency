# este módulo debería llamarse CalculatorConcurrency
# y el archivo debería llamarse calculator_concurrency
# y debería hacer un módulo Concurrency.Calculator con las operaciones
# es ridículo en este caso pero estamos simulando un caso de negocio real

defmodule Concurrency.CalculatorConcurrency do
  def start, do: spawn(fn -> loop(0) end)
  alias Concurrency.Calculator, as: Cal # Encapsular toda la lógica de negocio en un módulo externo

  #Resumen:
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
          send(client_id, {:ok, current_state}) # aquí no estás devolviéndole el state a new_state, le estás devolviendo un pid
          current_state # aquí lo devuelves <---- aquí
        {:add, value} -> Cal.add(current_state, value) # aquí se supone que llamas a la calculadora
        {:sub, value} -> Cal.sub(current_state, value)
      end

    loop(new_state)
  end
end
