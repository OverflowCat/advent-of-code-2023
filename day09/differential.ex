defmodule Diff do
  def parse(line) do
    line |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def diff_to_end([elem], acc) do
    elem + acc
  end

  def diff_to_end(list, acc) do
    list
    |> Enum.zip(tl(list))
    |> Enum.map(fn {a, b} -> b - a end)
    |> diff_to_end(List.last(list) + acc)
  end
end

File.stream!("input.txt")
|> Stream.map(&String.trim/1)
|> Stream.map(&Diff.parse/1)
|> Stream.map(&Diff.diff_to_end(&1, 0))
|> Stream.sum()
|> IO.puts()
