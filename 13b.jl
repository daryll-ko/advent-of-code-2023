function process(grid)
    r, c = length(grid), length(grid[1])
    for i in 1:r-1
        u, d = i, i+1
        diffs = 0
        while 1 <= u && d <= r
            for j in 1:c
                if grid[u][j] != grid[d][j]
                    diffs += 1
                end
            end
            u -= 1
            d += 1
        end
        if diffs == 1
            return 100*i
        end
    end
    for j in 1:c-1
        l, rr = j, j+1
        diffs = 0
        while 1 <= l && rr <= c
            for i in 1:r
                if grid[i][l] != grid[i][rr]
                    diffs += 1
                end
            end
            l -= 1
            rr += 1
        end
        if diffs == 1
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
