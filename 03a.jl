function is_symbol(grid, r, c, i, j)
    if !(1 <= i && i <= r && 1 <= j && j <= c)
        return false
    end
    return !(isdigit(grid[i][j]) || grid[i][j] == '.') 
end


function connected_to_symbol(grid, r, c, i, j₁, j₂)
    dᵢ = [-1 -1 -1 0 1 1 1 0]
    dⱼ = [1 0 -1 -1 -1 0 1 1]

    for j in j₁:j₂, d in 1:8
        i_to, j_to = i + dᵢ[d], j + dⱼ[d]
        if is_symbol(grid, r, c, i_to, j_to)
            return true
        end
    end

    return false
end

function solve()
    grid = Vector{String}()
    while true
        line = readline()
        if length(line) == 0
            break
        end
        push!(grid, line)
    end
    i, j = 1, 1
    r, c = length(grid), length(grid[1])
    total = 0
    while i <= r
        if isdigit(grid[i][j])
            j₁ = j
            current = parse(Int, grid[i][j])
            while j+1 <= c && isdigit(grid[i][j+1])
                current = 10 * current + parse(Int, grid[i][j+1])
                j += 1
            end
            j₂ = j
            if connected_to_symbol(grid, r, c, i, j₁, j₂)
                total += current
            end
        end
        j += 1
        if j == c+1
            i += 1
            j = 1
        end
    end
    println(total)
end

solve()
