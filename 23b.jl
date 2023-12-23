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

    is_intersection = [false for _ in 1:r, _ in 1:c]

    is_intersection[si, sj] = true
    is_intersection[fi, fj] = true

    for i in 1:r, j in 1:c
        if grid[i][j] != '#'
            adj = 0
            for d in 1:4
                ni, nj = i + di[d], j + dj[d]
                if within(ni, nj) && grid[ni][nj] != '#'
                    adj += 1
                end
            end
            if adj >= 3
                is_intersection[i, j] = true
            end
        end
    end

    intersection_graph = Dict()

    function dfs2(i, j, cd, ii, jj, dd, dsteps)
        if (i, j) != (ii, jj) && is_intersection[i, j]
            intersection_graph[(ii, jj, dd)] = (i, j, dsteps)
            return
        end
        for d in 1:4
            if abs(d - cd) != 2
                ni, nj = i + di[d], j + dj[d]
                if within(ni, nj) && grid[ni][nj] != '#'
                    dfs2(ni, nj, d, ii, jj, dd, dsteps+1)
                end
            end
        end
    end

    for i in 1:r, j in 1:c
        if is_intersection[i, j]
            for d in 1:4
                ni, nj = i + di[d], j + dj[d]
                if within(ni, nj) && grid[ni][nj] != '#'
                    dfs2(ni, nj, d, i, j, d, 1)
                end
            end
        end
    end

    visited = [false for _ in 1:r, _ in 1:c]
    
    ans = 0

    function dfs(i, j, steps)
        visited[i, j] = true
        if fi == i && fj == j
            ans = max(ans, steps)
            visited[i, j] = false
            return
        end
        for d in 1:4
            ni, nj = i + di[d], j + dj[d]
            if within(ni, nj) && grid[ni][nj] != '#' && !visited[ni, nj]
                if haskey(intersection_graph, (i, j, d))
                    ii, jj, dsteps = intersection_graph[(i, j, d)]
                    if visited[ii, jj]
                        continue
                    else
                        dfs(ii, jj, steps + dsteps)
                    end
                else
                    dfs(ni, nj, steps+1)
                end
            end
        end
        visited[i, j] = false
    end

    dfs(si, sj, 0)

    println(ans)
end

solve()
