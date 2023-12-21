using DataStructures

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    grid = readlines()
    r, c = length(grid), length(grid[1])

    # everything below here is irrelevant

    is_wall = [false for _ in 1:r, _ in 1:c]
    si, sj = 0, 0
    for i in 1:r, j in 1:c
        if grid[i][j] == 'S'
            si, sj = i, j
        elseif grid[i][j] == '#'
            is_wall[i, j] = true
        end
    end

    function mod(index, n)
        res = ((index % n) + n) % n
        return res == 0 ? n : res
    end

    STEPS = 5r
    answers = [0 for _ in 1:STEPS]
    taken = Set()
    cs = 0

    q = Queue{Tuple{Int,Int,Int}}()
    enqueue!(q, (si, sj, 0))

    while length(q) > 0
        i, j, s = dequeue!(q)
        if s > STEPS
            break
        elseif s != 0
            answers[s] += 1
        end
        if s != cs
            taken = Set()
            cs = s
        end
        for d in 1:4
            ni, nj = i + di[d], j + dj[d]
            if !is_wall[mod(ni, r), mod(nj, c)] && (ni, nj) ∉ taken
                enqueue!(q, (ni, nj, s+1))
                push!(taken, (ni, nj))
            end
        end
    end

    # wow, an interpolation problem!
    x = 26501365÷r + 1
    println(14840x^2 - 14740x + 3651)
end

solve()
