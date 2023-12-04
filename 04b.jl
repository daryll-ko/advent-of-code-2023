function get_nums(s)
    return parse.(Int, split(s, ' ') |> filter(ss -> length(ss) > 0))
end

function solve()
    lines = []
    while true
        line = readline()
        if length(line) == 0
            break
        end
        i = findfirst(c -> c == ':', line)
        line = line[i+2:end]
        push!(lines, line)
    end
    n = length(lines)
    counts = ones(Int, n)
    for i in 1:n
        win, have = split(lines[i], " | ")
        winning_nums = Set(get_nums(win))
        nums_on_hand = Set(get_nums(have))
        copies = length(winning_nums ∩ nums_on_hand)
        for j in i+1:i+copies
            counts[j] += counts[i]
        end
    end
    println(sum(counts))
end

solve()
