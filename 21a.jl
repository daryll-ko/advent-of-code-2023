using DataStructures

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    grid = readlines()
    r, c = length(grid), length(grid[1])
    si, sj = 0, 0
    for i in 1:r, j in 1:c
        if grid[i][j] == 'S'
            si, sj = i, j
            break
        end
    end

    function within(i, j)
        return 1 <= i && i <= r && 1 <= j && j <= c
    end

    STEPS = 64
    taken = [false for _ in 1:r, _ in 1:c, _ in 1:STEPS+1]

    q = Queue{Tuple{Int,Int,Int}}()
    enqueue!(q, (si, sj, 0))

    total = 0
    while length(q) > 0
        i, j, s = dequeue!(q)
        if s > STEPS
            break
        elseif s == STEPS
            total += 1
        end
        for d in 1:4
            ni, nj = i + di[d], j + dj[d]
            if within(ni, nj) && grid[ni][nj] != '#' && !taken[ni, nj, s+1]
                enqueue!(q, (ni, nj, s+1))
                taken[ni, nj, s+1] = true
            end
        end
    end
    println(total)
end

solve()
