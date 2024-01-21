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

current = "AAA"
steps = 0
while true
  ops.each_char do |op|
    node = hashmap[current]
    if op == "L"
      current = node[0]
    else
      current = node[1]
    end
    steps += 1
    if current == "ZZZ"
      puts steps
      exit
    end
  end
end
