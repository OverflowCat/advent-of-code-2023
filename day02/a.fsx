let parsePart (part: string) =
    let colors = part.Trim().Split([| ' ' |], 2)
    let count, color = int colors.[0], colors.[1].Trim()
    color, count

let parseSet (set: string) =
    let parts = set.Split(',')
    // parse all parts and get count
    // assume each item has unique color
    // return a map of color -> count
    parts |> Array.map parsePart |> Map.ofArray

let testSet (set: string) =
    let parsed = parseSet set
    // determine that: red \leq 12, green \leq 13, blue \leq 14
    (parsed.TryFind("red") |> Option.defaultValue 0) <= 12
    && (parsed.TryFind("green") |> Option.defaultValue 0) <= 13
    && (parsed.TryFind("blue") |> Option.defaultValue 0) <= 14

let parseLine (line: string) =
    let parts = line.Split([| ':' |], 2)
    let gameId = int (parts.[0].Trim().Split(' ')[1])
    let sets = parts.[1].Trim().Split(';')
    if sets |> Array.forall testSet then Some(gameId) else None

let input: string array = System.IO.File.ReadAllText("./input.txt").Split('\n')
let sum = input |> Array.choose parseLine |> Array.sum

printfn "%A" sum
