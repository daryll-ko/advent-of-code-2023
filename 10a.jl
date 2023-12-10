using DataStructures

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    to_consider = Dict(
                       '|' => [2, 4],
                       'S' => [2, 4],
                       '-' => [1, 3],
                       'L' => [1, 2],
                       'J' => [2, 3],
                       '7' => [3, 4],
                       'F' => [4, 1],
                  )

    INF = 10^10

    grid = readlines()
    r, c = length(grid), length(grid[1])
    si, sj = 0, 0
    for i in 1:r, j in 1:c
        if grid[i][j] == 'S'
            si, sj = i, j
            break
        end
    end

    distances = [INF for _ in 1:r, _ in 1:c]
    distances[si, sj] = 0
    q = Queue{Tuple{Int,Int}}()
    enqueue!(q, (si, sj))
    while length(q) > 0
        ci, cj = dequeue!(q)
        dis = distances[ci, cj]
        for d in to_consider[grid[ci][cj]]
            ni, nj = ci + di[d], cj + dj[d]
            if distances[ni, nj] > dis + 1
                distances[ni, nj] = dis + 1
                enqueue!(q, (ni, nj))
            end
        end
    end

    farthest = distances |> filter(val -> val != INF) |> maximum
    println(farthest)
end

solve()
