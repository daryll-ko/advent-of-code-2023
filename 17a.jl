using Random

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    grid = readlines() .|> collect .|> line -> parse.(Int, line)
    r, c = length(grid), length(grid[1])

    function within(i, j)
        return 1 <= i && i <= r && 1 <= j && j <= c
    end

    # dp[i, j, d, s] = minimum heat loss at (i, j) facing in d direction with s forward steps
    dp = [10^10 for _ in 1:r, _ in 1:c, _ in 1:4, _ in 1:3]

    dp[1, 1, 1, 1] = 0
    for runs in 1:50
        for i in 1:r, j in 1:c, d in randperm(4), s in 1:3
            for nd in randperm(4)
                if abs(d - nd) == 2 || (d == nd && s == 3)
                    continue
                end
                ni, nj = i + di[nd], j + dj[nd]
                if within(ni, nj)
                    if d == nd
                        dp[ni, nj, nd, s+1] = min(dp[ni, nj, nd, s+1], grid[ni][nj] + dp[i, j, d, s])
                    else
                        dp[ni, nj, nd, 1] = min(dp[ni, nj, nd, 1], grid[ni][nj] + dp[i, j, d, s])
                    end
                end
            end
        end
    end

    # for i in 1:r, j in 1:c
    #     res = 10^10
    #     for d in 1:4, s in 1:3
    #         res = min(res, dp[i, j, d, s])
    #     end
    #     print(j == c ? "$res\n" : "$res ")
    # end

    ans = 10^10
    for d in 1:4, s in 1:3
        ans = min(ans, dp[r, c, d, s])
    end
    println(ans)
end

solve()
