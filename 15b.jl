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
    lenses = [[] for _ in 0:255]
    for step in steps
        if occursin('=', step)
            label, focal_len = split(step, '=')
            focal_len = parse(Int, focal_len)
            box_num = hash(label)
            found = false
            for (i, (lab, _)) in enumerate(lenses[box_num+1])
                if label == lab
                    lenses[box_num+1][i] = (label, focal_len)
                    found = true
                    break
                end
            end
            if !found
                push!(lenses[box_num+1], (label, focal_len))
            end
        else
            label = step[begin:end-1]
            box_num = hash(label)
            i = findfirst(((lab, _),) -> label == lab, lenses[box_num+1])
            if !isnothing(i)
                deleteat!(lenses[box_num+1], i)
            end
        end
    end
    total = 0
    for box_num in 1:256
        n = length(lenses[box_num])
        for (i, (_, foc)) in enumerate(lenses[box_num])
            total += box_num * i * foc
        end
    end
    println(total)
end

solve()
