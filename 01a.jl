function firstdigit(line)
    i = findfirst(c -> isdigit(c), line)
    return parse(Int, line[i])
end

function lastdigit(line)
    i = findlast(c -> isdigit(c), line)
    return parse(Int, line[i])
end

function solve()
    sum = 0
    while true
        line = readline()
        if length(line) == 0
            break
        end
        tens, ones = firstdigit(line), lastdigit(line)
        sum += 10*tens + ones
    end
    println(sum)
end

solve()
