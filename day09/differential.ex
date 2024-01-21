defmodule Diff do
  def parse(line) do
    line |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def diff_to_end([elem], acc) do
    {elem, elem + acc}
  end

  def diff_to_end(list, acc) do
    diff_to_end(
      Enum.zip(list, tl(list)) |> Enum.map(fn {a, b} -> b - a end),
      List.last(list) + acc
    )
  end
end

File.stream!("input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&Diff.parse/1)
|> Enum.map(&Diff.diff_to_end(&1, 0))
|> Enum.map(fn {_, n} -> n end)
|> Enum.sum()
|> IO.puts()
