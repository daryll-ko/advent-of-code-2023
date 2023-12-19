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

    total = 0
    for line in lines
        if length(line) == 0
            checking = true
        else
            if checking
                vals = line[begin+1:end-1] |> (l -> split(l, ',')) .|> (val -> parse(Int, split(val, '=') |> last))
                cur = "in"
                while cur ∉ ["A", "R"]
                    for check in workflows[cur]
                        res = evaluate(vals, check)
                        if res != "X"
                            cur = res
                            break
                        end
                    end
                end
                if cur == "A"
                    total += sum(vals)
                end
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
    end
    println(total)
end

solve()
