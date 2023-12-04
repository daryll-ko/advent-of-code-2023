function get_nums(s)
    return parse.(Int, split(s, ' ') |> filter(ss -> length(ss) > 0))
end

function score(n)
    return n > 0 ? 2^(n-1) : 0
end

function solve()
    total = 0
    while true
        line = readline()
        if length(line) == 0
            break
        end
        i = findfirst(c -> c == ':', line)
        line = line[i+2:end]
        win, have = split(line, " | ")
        winning_nums = Set(get_nums(win))
        nums_on_hand = Set(get_nums(have))
        total += score(length(winning_nums ∩ nums_on_hand))
    end
    println(total)
end

solve()
