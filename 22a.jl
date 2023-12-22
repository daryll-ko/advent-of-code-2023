function solve()
    is_block = [false for _ in 1:10, _ in 1:10, _ in 1:300]
    to_blocks = Dict()
    zs = []
    for (i, line) in enumerate(readlines())
        from, to = split(line, "~")
        x1, y1, z1 = split(from, ",") .|> v -> parse(Int, v)
        x2, y2, z2 = split(to, ",") .|> v -> parse(Int, v)

        x1 += 1
        y1 += 1
        x2 += 1
        y2 += 1

        to_blocks[i] = ((x1, y1, z1), (x2, y2, z2))
        for x in x1:x2, y in y1:y2, z in z1:z2
            is_block[x, y, z] = true
        end
        push!(zs, (i, min(z1, z2)))
    end
    sort!(zs, by = x -> x[2])

    function can_drop(p1, p2)
        x1, y1, z1 = p1
        x2, y2, z2 = p2

        if min(z1, z2) == 1
            return false
        end

        if z1 != z2
            return !is_block[x1, y1, z1-1]
        else
            for x in x1:x2, y in y1:y2
                if is_block[x, y, z1-1]
                    return false
                end
            end
            return true
        end
    end

    function drop(p1, p2)
        x1, y1, z1 = p1
        x2, y2, z2 = p2

        for x in x1:x2, y in y1:y2, z in z1:z2
            is_block[x, y, z] = false
            is_block[x, y, z-1] = true
        end
    end

    # gravity
    for (i, _) in zs
        p1, p2 = to_blocks[i]

        while can_drop(p1, p2)
            drop(p1, p2)

            x1, y1, z1 = p1
            x2, y2, z2 = p2

            p1 = (x1, y1, z1-1)
            p2 = (x2, y2, z2-1)
        end

        to_blocks[i] = (p1, p2)
    end

    function is_dependent_on(i, j)
        p1i, p2i = to_blocks[i]
        p1j, p2j = to_blocks[j]

        x1i, y1i, z1i = p1i
        x2i, y2i, z2i = p2i

        x1j, y1j, z1j = p1j
        x2j, y2j, z2j = p2j

        for xi in x1i:x2i, yi in y1i:y2i, zi in z1i:z2i
            for xj in x1j:x2j, yj in y1j:y2j, zj in z1j:z2j
                if (xi, yi, zi-1) == (xj, yj, zj)
                    return true
                end
            end
        end
        return false
    end

    n = length(to_blocks)
    yeetable = [1 for _ in 1:n]

    for i in 1:n
        depended_on = []
        for j in 1:n
            if i != j && is_dependent_on(i, j)
                push!(depended_on, j)
            end
        end
        if length(depended_on) == 1
            yeetable[depended_on[1]] = 0
        end
    end

    println(sum(yeetable))
end

solve()
