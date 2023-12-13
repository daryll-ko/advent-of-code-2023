function process(grid)
    r, c = length(grid), length(grid[1])
    for i in 1:r-1
        u, d = i, i+1
        possible = true
        while 1 <= u && d <= r
            for j in 1:c
                possible &= grid[u][j] == grid[d][j]
            end
            if !possible
                break
            end
            u -= 1
            d += 1
        end
        if possible
            return 100*i
        end
    end
    for j in 1:c-1
        l, rr = j, j+1
        possible = true
        while 1 <= l && rr <= c
            for i in 1:r
                possible &= grid[i][l] == grid[i][rr]
            end
            if !possible
                break
            end
            l -= 1
            rr += 1
        end
        if possible
            return j
        end
    end
    return -1
end

function solve()
    total = 0
    grid = []
    for line in readlines()
        if length(line) == 0
            total += process(grid)
            grid = []
        else
            push!(grid, line)
        end
    end
    total += process(grid)
    println(total)
end

solve()
