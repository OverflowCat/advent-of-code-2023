defmodule LeftDiff do
  def parse(line) do
    line |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  def diff_to_end([_]) do
    0
  end

  def diff_to_end(list) do
    diff = Enum.zip(list, tl(list)) |> Enum.map(fn {a, b} -> b - a end)
    List.first(list) - diff_to_end(diff)
  end
end

# assert "10 13 16 21 30 45" |> parse() |> diff_to_end() == 5

File.stream!("input.txt")
|> Enum.map(&String.trim/1)
|> Enum.map(&LeftDiff.parse/1)
|> Enum.map(&LeftDiff.diff_to_end/1)
|> Enum.sum()
|> IO.puts()
