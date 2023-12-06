function get_nums(line)
    i = findfirst(c -> c == ':', line)
    return parse.(Int, line[i+1:end] |> filter(c -> !isspace(c)))
end

function solve()
    times = get_nums(readline())
    distances = get_nums(readline())
    res = 1
    for i in eachindex(times)
        # charge for x seconds -> distances of x(t-x)
        # num of x for which x(t-x) > d <-> x^2 - tx + d < 0
        # (x - t/2)^2 < t^2/4 - d
        t, d = times[i], distances[i]
        root = √(t^2/4 - d)
        l, r = ceil(Int, -root + t/2 + 1e-5), floor(Int, root + t/2 - 1e-5)
        ways = r - l + 1
        res *= ways
    end
    println(res)
end

solve()
