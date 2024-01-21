lines = File.readlines('input.txt')
$hashmap = {}
i = 0
$ops = ""
lines.each do |line|
  line = line.chomp
  if i == 0
    $ops = line
  elsif i == 1
    # do nothing
  else
    node, children = line.split(" = ")
    $hashmap[node] = children.tr('()', '').split(", ")
  end
  i += 1
end

def f(node)
  current = node
  steps = 0
  while true
    $ops.each_char do |op|
      node = $hashmap[current]
      if op == "L"
        current = node[0]
      else
        current = node[1]
      end
      steps += 1
      if current.end_with?("Z")
        return steps
      end
    end
  end
end

nodes_ending_with_A = $hashmap.keys.select { |k| k.end_with?("A") }
results = nodes_ending_with_A.map { |node| f(node) }
print results
puts
lcm = results.reduce(:lcm)
puts lcm
