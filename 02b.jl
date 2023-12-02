function solve()
    total = 0
    while true
        line = readline()
        if length(line) == 0
            break
        end
        i = findfirst(c -> c == ':', line)
        line = line[i+2:end]
        max_r, max_g, max_b = 0, 0, 0
        for set in split(line, "; "), pull in split(set, ", ")
            cubes, color = split(pull)
            cubes = parse(Int, cubes)
            if color == "red"
                max_r = max(max_r, cubes)
            elseif color == "green"
                max_g = max(max_g, cubes)
            else
                max_b = max(max_b, cubes)
            end
        end
        total += max_r * max_g * max_b
    end
    println(total)
end

solve()
