function solve()
    grid = readlines()

    r, c = length(grid), length(grid[1])
    si, sj = 1, 2
    fi, fj = r, c-1

    function within(i, j)
        return 1 <= i && i <= r && 1 <= j && j <= c
    end

    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    opposing = Dict('.' => 0, '>' => 3, '^' => 4, '<' => 1, 'v' => 2)

    ans = 0

    function dfs(i, j, cd, steps)
        if fi == i && fj == j
            ans = max(ans, steps)
            return
        end
        for d in 1:4
            if abs(d - cd) != 2
                ni, nj = i + di[d], j + dj[d]
                if within(ni, nj) && grid[ni][nj] != '#' && d != opposing[grid[ni][nj]]
                    dfs(ni, nj, d, steps+1)
                end
            end
        end
    end

    dfs(si, sj, 4, 0)

    println(ans)
end

solve()
