function solve()
    lines = readlines()
    workflows = Dict()

    checking = false

    to_index = Dict("x" => 1, "m" => 2, "a" => 3, "s" => 4)

    function evaluate(vals, check)
        comp, res = check[1], check[2]
        if length(comp) == 0
            return res
        else
            if occursin("<", comp)
                val, bound = split(comp, "<")
                bound = parse(Int, bound)
                return vals[to_index[val]] < bound ? res : "X"
            else
                val, bound = split(comp, ">")
                bound = parse(Int, bound)
                return vals[to_index[val]] > bound ? res : "X"
            end
        end
    end

    for line in lines
        if length(line) == 0
            break
        else
            i = findfirst('{', line)
            name, checks = line[begin:i-1], line[i+1:end-1]
            workflows[name] = []
            for check in split(checks, ',')
                if occursin(":", check)
                    push!(workflows[name], split(check, ':'))
                else
                    push!(workflows[name], ("", check))
                end
            end
        end
    end

    graph = Dict()
    sources = []

    for (name, rules) in workflows
        for (i, (cond, dest)) in enumerate(rules)
            if dest == "A"
                push!(sources, (name, i))
            elseif dest != "R"
                if !haskey(graph, dest)
                    graph[dest] = []
                end
                push!(graph[dest], (name, i))
            end
        end
    end

    limit = 4000

    function get_range(cond, just_jumped)
        if cond == ""
            return 1, [1, limit]
        end
        if occursin("<", cond)
            val, bound = split(cond, "<")
            bound = parse(Int, bound)
            range = just_jumped ? [1, bound-1] : [bound, limit]
            return to_index[val], range
        else
            val, bound = split(cond, ">")
            bound = parse(Int, bound)
            range = just_jumped ? [bound+1, limit] : [1, bound]
            return to_index[val], range
        end
    end

    function intersect_ranges(range1, range2)
        l1, r1 = range1
        l2, r2 = range2

        if l1 <= l2 && l2 <= r1
            return [l2, min(r1, r2)]
        elseif l1 <= r2 && r2 <= r1
            return [max(l1, l2), r2]
        elseif l2 <= l1 && l1 <= r2
            return [l1, min(r1, r2)]
        elseif l2 <= r1 && r1 <= r2
            return [max(l1, l2), r1]
        else
            return [0, -1]
        end
    end

    total = 0
    for source in sources
        ranges = [[1, limit] for _ in 1:4]
        cname, cindex = source
        just_jumped = true
        while !(cname == "in" && cindex == 0)
            cond, _ = workflows[cname][cindex]
            i, range = get_range(cond, just_jumped)
            ranges[i] = intersect_ranges(ranges[i], range)
            if cindex == 1 && cname != "in"
                cname, cindex = graph[cname][1]
                just_jumped = true
            else
                cindex -= 1
                just_jumped = false
            end
        end
        res = 1
        for (l, r) in ranges
            res *= r - l + 1
        end
        total += res
    end
    println(total)
end

solve()
