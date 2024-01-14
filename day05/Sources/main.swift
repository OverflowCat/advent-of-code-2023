// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

func bisect(arr: [(Int, Int, Int)], val: Int) -> Int {
    for i in 0..<arr.count {
        if val >= arr[i].1 {
            continue
        } else {
            return i
        }
    }
    return arr.count
}

func findImage(arr: [(Int, Int, Int)], val: Int) -> Int {
    var idx = bisect(arr: arr, val: val)
    if idx == 0 {
        return val
    }
    idx -= 1
    let r = arr[idx]
    if val >= r.1 && val < r.1 + r.2 {
        return arr[idx].0 + (val - arr[idx].1)
    }
    return val
}

let input = try String(contentsOfFile: "input.txt", encoding: .utf8)
let lines = input.split(separator: "\n")
let seeds = lines.first!.split(separator: " ").dropFirst().map { Int($0)! }
print(seeds)

var source = seeds

var lineIdx = 3
while lineIdx < lines.count {
    var mapping = [(Int, Int, Int)]()
    let info = lines[lineIdx - 1]
    for line in lines[lineIdx...] {
        lineIdx += 1
        if line.firstIndex(of: "m") != nil {
            break
        }
        let parts = line.split(separator: " ").map { Int($0)! }
        let (dest, src, len) = (parts[0], parts[1], parts[2])
        mapping.append((dest, src, len))
    }
    print("Mapping built,", info, mapping)

    mapping.sort(by: { $0.1 < $1.1 })
    let target = source.map {
        findImage(arr: mapping, val: $0)
    }
    print(source)
    print(target)

    source = target
}

let minLocation = source.min()!
print(minLocation)
