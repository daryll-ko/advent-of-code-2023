using DataStructures

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    grid = readlines()
    r, c = length(grid), length(grid[1])
    energized = [false for _ in 1:r, _ in 1:c]
    done = [false for _ in 1:r, _ in 1:c, _ in 1:4]

    function within(i, j)
        return 1 <= i && i <= r && 1 <= j && j <= c
    end

    q = Queue{Tuple{Tuple{Int,Int},Int}}()
    enqueue!(q, ((1, 1), 4))

    slash = Dict(1 => 2, 2 => 1, 3 => 4, 4 => 3)
    backslash = Dict(1 => 4, 2 => 3, 3 => 2, 4 => 1)

    while length(q) > 0
        ((i, j), d) = dequeue!(q)
        if done[i, j, d]
            continue
        end
        energized[i, j] = true
        done[i, j, d] = true
        ni, nj = i + di[d], j + dj[d]
        if within(ni, nj)
            if grid[ni][nj] == '.'
                enqueue!(q, ((ni, nj), d))
            elseif grid[ni][nj] == '\\'
                enqueue!(q, ((ni, nj), backslash[d]))
            elseif grid[ni][nj] == '/'
                enqueue!(q, ((ni, nj), slash[d]))
            elseif grid[ni][nj] == '-'
                if d % 2 == 1
                    enqueue!(q, ((ni, nj), d))
                else
                    enqueue!(q, ((ni, nj), 1))
                    enqueue!(q, ((ni, nj), 3))
                end
            else # '|'
                if d % 2 == 0
                    enqueue!(q, ((ni, nj), d))
                else
                    enqueue!(q, ((ni, nj), 2))
                    enqueue!(q, ((ni, nj), 4))
                end
            end
        end
    end

    res = 0
    for i in 1:r, j in 1:c
        if energized[i, j]
            res += 1
        end
    end
    println(res)
end

solve()
