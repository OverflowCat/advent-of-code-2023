defmodule Diff do
  def diff(list) do
    list |> Enum.zip(tl(list)) |> Enum.map(fn {a, b} -> b - a end)
  end

  def parse(line) do
    line |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def diff_to_end([elem], acc) do
    {elem, elem + acc}
  end

  def diff_to_end([elem | rest], acc) do
    diff_to_end(diff([elem | rest]), List.last(rest) + acc)
  end
end

File.stream!("input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&Diff.parse/1)
|> Enum.map(&Diff.diff_to_end(&1, 0))
|> Enum.map(fn {_, n} -> n end)
|> Enum.sum()
|> IO.puts()
