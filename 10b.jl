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

    # [CW, CCW]
    to_mark = Dict(
                   ('|', 2) => [[1], [3]],
                   ('|', 4) => [[3], [1]],
                   ('-', 1) => [[4], [2]],
                   ('-', 3) => [[2], [4]],
                   ('L', 3) => [[], [3, 4]],
                   ('L', 4) => [[3, 4], []],
                   ('J', 1) => [[1, 4],[]],
                   ('J', 4) => [[],[1, 4]],
                   ('7', 1) => [[],[1, 2]],
                   ('7', 2) => [[1, 2],[]],
                   ('F', 2) => [[],[2, 3]],
                   ('F', 3) => [[2, 3],[]],
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

    # trace loop
    distances = [INF for _ in 1:r, _ in 1:c]
    distances[si, sj] = 0
    is_in_loop = [false for _ in 1:r, _ in 1:c]
    q = Queue{Tuple{Int,Int}}()
    enqueue!(q, (si, sj))
    while length(q) > 0
        ci, cj = dequeue!(q)
        dis = distances[ci, cj]
        is_in_loop[ci, cj] = true
        for d in to_consider[grid[ci][cj]]
            ni, nj = ci + di[d], cj + dj[d]
            if distances[ni, nj] > dis + 1
                distances[ni, nj] = dis + 1
                enqueue!(q, (ni, nj))
            end
        end
    end

    # trace loop
    visited = [false for _ in 1:r, _ in 1:c]
    marked = [false for _ in 1:r, _ in 1:c]
    ci, cj, cd = si, sj, 4
    while !visited[ci, cj]
        visited[ci, cj] = true
        if haskey(to_mark, (grid[ci][cj], cd))
            for d in to_mark[(grid[ci][cj], cd)][2] # 1 for CW, 2 for CCW
                mi, mj = ci + di[d], cj + dj[d]
                if 1 <= mi && mi <= r && 1 <= mj && mj <= c && !is_in_loop[mi, mj]
                    marked[mi, mj] = true
                end
            end
        end
        for d in to_consider[grid[ci][cj]]
            ni, nj = ci + di[d], cj + dj[d]
            if !visited[ni, nj]
                ci, cj, cd = ni, nj, d
                break
            end
        end
    end


    # flood fill
    q = Queue{Tuple{Int,Int}}()
    queued = [false for _ in 1:r, _ in 1:c]
    for i in 1:r, j in 1:c
        if marked[i, j]
            enqueue!(q, (i, j))
            queued[i, j] = true
        end
    end
    while length(q) > 0
        ci, cj = dequeue!(q)
        marked[ci, cj] = true
        for d in 1:4
            ni, nj = ci + di[d], cj + dj[d]
            if 1 <= ni && ni <= r && 1 <= nj && nj <= c && !is_in_loop[ni, nj] && !queued[ni, nj]
                queued[ni, nj] = true
                enqueue!(q, (ni, nj))
            end
        end
    end

    to_symbol = Dict(
                     '-' => '-',
                     'S' => '|',
                     '|' => '|',
                     '7' => '┐',
                     'F' => '┌',
                     'L' => '└',
                     'J' => '┘',
                )

    # print grid nicely
    # for i in 1:r
    #     for j in 1:c
    #         if is_in_loop[i, j]
    #             print(to_symbol[grid[i][j]])
    #         elseif marked[i, j]
    #             print('$')
    #         else
    #             print('.')
    #         end
    #     end
    #     println()
    # end

    inside = 0
    for i in 1:r, j in 1:c
        if marked[i, j]
            inside += 1
        end
    end
    println("inside: $inside")
end

solve()
