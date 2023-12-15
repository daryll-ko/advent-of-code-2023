function hash(s)
    res = 0
    for c in s
        res += Int(c)
        res *= 17
        res %= 256
    end
    return res
end

function solve()
    steps = split(readline(), ',')
    println(steps .|> hash |> sum)
end

solve()
