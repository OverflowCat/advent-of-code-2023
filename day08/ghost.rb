lines = File.readlines('input.txt')
hashmap = {}
i = 0
ops = ""
lines.each do |line|
  line = line.chomp
  if i == 0
    ops = line
  elsif i == 1
    # do nothing
  else
    node, children = line.split(" = ")
    hashmap[node] = children.tr('()', '').split(", ")
  end
  i += 1
end

nodes_ending_in_A = hashmap.keys.select { |node| node.end_with?("A") }
print nodes_ending_in_A

current = nodes_ending_in_A
steps = 0
while true
  ops.each_char do |op|
    current.map! do |currentitem|
      node = hashmap[currentitem]
      if op == "L"
        currentitem = node[0]
      else
        currentitem = node[1]
      end
      steps += 1
      currentitem
    end
    print current
    if current.all? { |item| item.end_with?("Z") }
      puts steps
      exit
    end
    puts steps
  end
end
