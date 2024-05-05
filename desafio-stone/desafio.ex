defmodule Desafio do
  @moduledoc """
  Este é o módulo que deverá ser preenchido
  com a sua solução.

  É permitido criar quantas funções privadas for necessário,
  mas a única função pública deverá ser a função `split/2`
  que está definida como placeholder abaixo.
  """

  @spec split(
          lista_de_compras :: [
            {item :: String.t(), quantidade :: pos_integer(),
             preco_unitario_centavos :: pos_integer()}
          ],
          emails :: [String.t()]
        ) :: [%{String.t() => non_neg_integer()}]
  def split(lista_de_compras, emails) do
    unique_emails = Enum.uniq(emails)
    valor_total = calculate_total_values(lista_de_compras)
    qty_emails = length(unique_emails)

    valor_por_pessoa, resto = split_per_person(qty_emails, valor_total)

    unique_emails
    |> Enum.with_index(fn email, idx ->
      if idx < resto do
        { email, valor_por_pessoa + 1}
      else
        { email, valor_por_pessoa }
      end
      { email, valor_por_pessoa }
    end)
    |> Map.new()
  end

  defp calculate_total_values(lista) do
    Enum.reduce(lista, 0, fn {_nome, qty, valor_unit}, acc ->
      acc + qty * valor_unit
    end)

    # for {_nome, qty, valor_unit} <- lista, reduce: 0 do
    #   acc ->
    #     acc + qty * valor_unit
    # end

    # lista
    # |> Enum.map(fn {_nome, qty, valor_unit} -> qty * valor_unit end)
    # |> Enum.sum()
  end

  defp split_per_person(person_qty, total_value) do
    value = div(total_value, person_qty)
    value_left = rem(total_value, person_qty)

    { value, value_left }
  end

  # defp distribute_rem(map, _emails, 0), do: map
  # defp distribute_rem(map, [ email | t ], resto), do
  #   valor = map[email | t ]
  #   Map.put(map, email, valor + 1)
  #   distribute_rem(novo_map, t ++ [email], resto - 1)
  end
end
