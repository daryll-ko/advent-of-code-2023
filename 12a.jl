function runs(row)
    res = []
    cur = 0
    for cell in row
        if cell == '#'
            cur += 1
        elseif cur > 0
            push!(res, cur)
            cur = 0
        end
    end
    if cur > 0
        push!(res, cur)
    end
    return res
end

function ways(row, counts)
    marks = findall(c -> c == '?', row)
    n = length(marks)
    res = 0
    for i in 0:(1<<n)-1
        copy = ['x' for _ in 1:length(row)]
        for j in 0:n-1
            copy[marks[j+1]] = (i & (1<<j) > 0) ? '#' : '.'
        end
        for j in 1:length(row)
            if copy[j] == 'x'
                copy[j] = row[j]
            end
        end
        if runs(join(copy)) == counts
            res += 1
        end
    end
    return res
end

function solve()
    total = 0
    for line in readlines()
        row, counts = split(line, ' ')
        counts = parse.(Int, split(counts, ','))
        total += ways(row, counts)
    end
    println(total)
end

solve()
