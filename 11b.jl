function total_dis(A) # ∑|A[i]-A[j]|
    n = length(A)
    res = 0
    for i in 1:n
        l, r = i-1, n-i
        res += (l-r) * A[i]
    end
    return res
end

function fatten(A)
    n = length(A)
    B = [A[1]]
    for i in 2:n
        if A[i] != A[i-1]
            push!(B, B[end] + 10^6*(A[i] - A[i-1] - 1) + 1)
        else
            push!(B, B[end])
        end
    end
    return B
end

function solve()
    grid = readlines()
    positions = []
    r, c = length(grid), length(grid[1])
    for i in 1:r, j in 1:c
        if grid[i][j] == '#'
            push!(positions, (i, j))
        end
    end
    total = 0
    sort!(positions, by = first)
    total += total_dis(positions .|> first |> fatten)
    sort!(positions, by = last)
    total += total_dis(positions .|> last |> fatten)
    println(total)
end

solve()
