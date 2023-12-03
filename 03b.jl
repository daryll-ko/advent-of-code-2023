function is_gear(grid, r, c, i, j)
    if !(1 <= i && i <= r && 1 <= j && j <= c)
        return false
    end
    return grid[i][j] == '*'
end


function update_surrounding_gears(grid, r, c, i, j₁, j₂, current, gear_st)
    dᵢ = [-1 -1 -1 0 1 1 1 0]
    dⱼ = [1 0 -1 -1 -1 0 1 1]

    done = Set()
    for j in j₁:j₂, d in 1:8
        i_to, j_to = i + dᵢ[d], j + dⱼ[d]
        if is_gear(grid, r, c, i_to, j_to) && (i_to, j_to) ∉ done
            cur_gear_ratio, cur_num_adj = gear_st[i_to][j_to]
            gear_st[i_to][j_to] = (cur_gear_ratio * current, cur_num_adj + 1)
            push!(done, (i_to, j_to))
        end
    end
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
    gear_st = [[(1, 0) for _ in 1:c] for _ in 1:r] # (gear_ratio, num_adj)
    while i <= r
        if isdigit(grid[i][j])
            j₁ = j
            current = parse(Int, grid[i][j])
            while j+1 <= c && isdigit(grid[i][j+1])
                current = 10 * current + parse(Int, grid[i][j+1])
                j += 1
            end
            j₂ = j
            update_surrounding_gears(grid, r, c, i, j₁, j₂, current, gear_st)
        end
        j += 1
        if j == c+1
            i += 1
            j = 1
        end
    end
    total = 0
    for i in 1:r, j in 1:c
        gear_ratio, num_adj = gear_st[i][j]
        if num_adj == 2
            total += gear_ratio
        end
    end
    println(total)
end

solve()
