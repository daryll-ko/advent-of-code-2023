using DataStructures

function solve()
    di = [0, -1, 0, 1]
    dj = [1, 0, -1, 0]

    to_d = Dict('0' => 1, '3' => 2, '2' => 3, '1' => 4)

    lines = readlines() .|>
        (line -> split(line, ' ')) .|>
        (((d, _, hex),) -> (to_d[hex[end-1]], parse(Int, hex[begin+2:end-2], base = 16)))

    n = length(lines)

    function is_ccw(d, nd)
        return nd == d%4 + 1
    end

    pts = []
    ci, cj = 0, 0
    push!(pts, (ci, cj))
    for (i, (d, steps)) in enumerate(lines)
        j = i%n + 1
        k = (i%n + n-2) % n + 1
        nd, _ = lines[j]
        pd, _ = lines[k]
        if is_ccw(pd, d) && is_ccw(d, nd)
            ci, cj = ci + di[d] * (steps-1), cj + dj[d] * (steps-1)
        elseif !(is_ccw(pd, d) || is_ccw(d, nd))
            ci, cj = ci + di[d] * (steps+1), cj + dj[d] * (steps+1)
        else
            ci, cj = ci + di[d] * steps, cj + dj[d] * steps
        end
        push!(pts, (ci, cj))
    end

    pts = pts[begin:end-1]

    n = length(pts)
    area = 0
    for i in 1:n
        j = i%n + 1
        x1, y1 = pts[i]
        x2, y2 = pts[j]
        area += (y1+y2) * (x1-x2)
    end
    println(abs(area) ÷ 2)
end

solve()
