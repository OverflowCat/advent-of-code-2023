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

let testGame (sets: string) =
    let sets = sets.Trim().Split(';')
    sets |> Array.forall testSet

let parseLine (line: string) =
    let parts = line.Split([| ':' |], 2)
    let gameId = int (parts.[0].Trim().Split(' ')[1])
    if testGame parts.[1] then Some gameId else None

let input: string array = System.IO.File.ReadAllText("./input.txt").Split('\n')
let sum = input |> Array.choose parseLine |> Array.sum

// assert (sum = 2776)
printfn "%A" sum

let getRequirement (set: string) =
    let parsed = parseSet set
    let red = parsed.TryFind("red") |> Option.defaultValue 0
    let green = parsed.TryFind("green") |> Option.defaultValue 0
    let blue = parsed.TryFind("blue") |> Option.defaultValue 0
    red, green, blue

let getMinPower (sets: string) =
    let sets = sets.Trim().Split(';')
    // get maximum value of red, green, blue
    let red, green, blue = sets |> Array.map getRequirement |> Array.reduce (fun (r1, g1, b1) (r2, g2, b2) -> max r1 r2, max g1 g2, max b1 b2)
    red * green * blue

let parseLine' (line: string) =
    let parts = line.Split([| ':' |], 2)
    getMinPower parts.[1]

let sum' = input |> Array.map parseLine' |> Array.sum

printfn "%A" sum'
