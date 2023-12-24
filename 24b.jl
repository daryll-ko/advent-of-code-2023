using LinearAlgebra

function solve()
    function parsedata(line)
        p, v = split(line, " @ ")
        px, py, pz = split(p, ", ") .|> val -> parse(Int, val)
        vx, vy, vz = split(v, ", ") .|> val -> parse(Int, val)
        return ((px, py, pz), (vx, vy, vz))
    end

    stones = readlines() .|> parsedata

    n = length(stones)

    m = min(n, 10)

    b = [stones[i][1][1] - stones[i%m + 1][1][1] for i in 1:m]
    b[m] = stones[m][1][2] - stones[1][1][2]

    B1 = 500
    B2 = 0

    for vxs in [-B1:B2, B2:B1], vys in [-B1:B2, B2:B1]
        for vx in vxs, vy in vys
            A = zeros(m, m)
            for i in 1:m-1
                A[i, i] = vx - stones[i][2][1]
                A[i, i%m + 1] = stones[i%m + 1][2][1] - vx
            end

            A[m, m] = vy - stones[m][2][2]
            A[m, 1] = stones[1][2][2] - vy

            try
                t = A\b

                vz = (stones[1][1][3] - stones[2][1][3] + t[1] * stones[1][2][3] - t[2] * stones[2][2][3]) / (t[1] - t[2])

                yay = true

                for i in 2:m
                    vz2 = (stones[i][1][3] - stones[i%m + 1][1][3] + t[i] * stones[i][2][3] - t[i%m + 1] * stones[i%m + 1][2][3]) / (t[i] - t[i%m + 1])
                    yay &= vz ≈ vz2
                    if !yay
                        break
                    end
                end

                if yay
                    px = stones[1][1][1] + t[1] * (stones[1][2][1] - vx)
                    py = stones[1][1][2] + t[1] * (stones[1][2][2] - vy)
                    pz = stones[1][1][3] + t[1] * (stones[1][2][3] - vz)

                    println("$px $py $pz | $vx $vy $vz")
                    println("$(px + py + pz)")
                    return
                end
            catch _
            end
        end
    end
end

solve()
