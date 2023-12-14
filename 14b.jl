function solve()
    grid = readlines() .|> collect
    r, c = length(grid), length(grid[1])
    for cycle in 1:10^3 # periodic w/period 13 (eventually)
        for i in 1:r, j in 1:c # North
            if grid[i][j] == 'O'
                ci = i
                while ci > 1 && grid[ci-1][j] == '.'
                    grid[ci-1][j] = 'O'
                    grid[ci][j] = '.'
                    ci -= 1
                end
            end
        end
        for j in 1:c, i in 1:r # West
            if grid[i][j] == 'O'
                cj = j
                while cj > 1 && grid[i][cj-1] == '.'
                    grid[i][cj-1] = 'O'
                    grid[i][cj] = '.'
                    cj -= 1
                end
            end
        end
        for i in r:-1:1, j in 1:c # South
            if grid[i][j] == 'O'
                ci = i
                while ci < r && grid[ci+1][j] == '.'
                    grid[ci+1][j] = 'O'
                    grid[ci][j] = '.'
                    ci += 1
                end
            end
        end
        for j in c:-1:1, i in 1:r # East
            if grid[i][j] == 'O'
                cj = j
                while cj < c && grid[i][cj+1] == '.'
                    grid[i][cj+1] = 'O'
                    grid[i][cj] = '.'
                    cj += 1
                end
            end
        end
        total = 0
        for i in 1:r, j in 1:c
            if grid[i][j] == 'O'
                total += r+1 - i
            end
        end
        println("$cycle: $total")
    end
end

solve()
