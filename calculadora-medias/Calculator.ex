defmodule Calculator do
  def start do
    nomes_alunos = ["Douglas Expedito Alves", "Expedito Douglas", "Alves Expedito"]

    alunos_com_notas = nomes_alunos
    |> Enum.map(&(%Student{
      name: &1,
      results: build_subjects([2.0, 0.1, 0.0, 8.8, 10.0, 3.0, 1.5, 7.0, 2.3, 1.4, 3.6])
    }))

    resultado = calculate(alunos_com_notas)
    melhor = best_result(resultado)

    { resultado, melhor }
  end

  defp calculate(students) do
    students
    |> Enum.map(&(%{
      first_name: Student.first_name(&1),
      last_name: Student.last_name(&1),
      average: average(&1)
    }))
  end

  defp average(student) do
    total = Enum.count(student.results)

    soma_de_notas = student.results
    |>  Enum.map(&(&1.result))
    |>  Enum.reduce(&(&1 + &2))

    Float.ceil(soma_de_notas / total, 2)
  end

  defp best_result(students) do
    melhor_nota = students
    |> Enum.map(&(&1.average))
    |> Enum.max

    students
    |> Enum.filter(&(&1.average === melhor_nota))
  end

  defp build_subjects(results)do
    materias = ["Lingua Portuguesa", "História", "Geografia", "Artes", "Música"]

    materias
    |> Enum.map(&(%Subject{ name: &1, result: Enum.random(results) }))
  end

end
