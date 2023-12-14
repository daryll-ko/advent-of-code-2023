function solve()
    grid = readlines() .|> collect
    r, c = length(grid), length(grid[1])
    for i in 1:r, j in 1:c
        if grid[i][j] == 'O'
            ci = i
            while ci > 1 && grid[ci-1][j] == '.'
                grid[ci-1][j] = 'O'
                grid[ci][j] = '.'
                ci -= 1
            end
        end
    end
    total = 0
    for i in 1:r, j in 1:c
        if grid[i][j] == 'O'
            total += r+1 - i
        end
    end
    println(total)
end

solve()
