using DataStructures

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    to_d = Dict("R" => 1, "U" => 2, "L" => 3, "D" => 4)

    lines = readlines() .|>
        (line -> split(line, ' ')) .|>
        (((d, steps, _),) -> (to_d[d], parse(Int, steps)))
 
    min_i, max_i, min_j, max_j = 0, 0, 0, 0
    ci, cj = 0, 0
    for (d, steps) in lines
        for _ in 1:steps
            ni, nj = ci + di[d], cj + dj[d]
            min_i = min(min_i, ni)
            max_i = max(max_i, ni)
            min_j = min(min_j, nj)
            max_j = max(max_j, nj)
            ci, cj = ni, nj
        end
    end

    R = max_i - min_i + 1
    C = max_j - min_j + 1

    function within(i, j)
        return 1 <= i && i <= R && 1 <= j && j <= C
    end

    grid = ['.' for _ in 1:R, _ in 1:C]

    ci, cj = 1 - min_i, 1 - min_j
    grid[ci, cj] = '#'

    for (d, steps) in lines
        for _ in 1:steps
            ni, nj = ci + di[d], cj + dj[d]
            grid[ni, nj] = '#'
            ci, cj = ni, nj
        end
    end

    queue = Queue{Tuple{Int,Int}}()
    enqueue!(queue, (210, 134))
    grid[210, 134] = '#'

    while length(queue) > 0
        i, j = dequeue!(queue)
        for d in 1:4
            ni, nj = i + di[d], j + dj[d]
            if within(ni, nj) && grid[ni, nj] != '#'
                enqueue!(queue, (ni, nj))
                grid[ni, nj] = '#'
            end
        end
    end

    total = 0
    for i in 1:R, j in 1:C
        if grid[i, j] == '#'
            total += 1
        end
    end
    println(total)
end

solve()
