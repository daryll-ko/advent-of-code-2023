function solve()
    function parsedata(line)
        p, v = split(line, " @ ")
        px, py, pz = split(p, ", ") .|> val -> parse(Int, val)
        vx, vy, vz = split(v, ", ") .|> val -> parse(Int, val)
        return ((px, py, pz), (vx, vy, vz))
    end

    stones = readlines() .|> parsedata

    n = length(stones)

    MIN = 2*10^14
    MAX = 4*10^14

    function within(x, y)
        return MIN <= x && x <= MAX && MIN <= y && y <= MAX
    end

    ans = 0
    for i in 1:n, j in i+1:n
        ((pxi, pyi, pzi), (vxi, vyi, vzi)) = stones[i]
        ((pxj, pyj, pzj), (vxj, vyj, vzj)) = stones[j]

        # if vxi == vxj
        #     if pxi == pxj
        #         t = (pyi - pyj) / (vyj - vyi)
        #         println("$i $j $t")
        #         if t > 0
        #             pxif, pyif = pxi + t * vxi, pyi + t * vyi
        #             pxjf, pyjf = pxj + t * vxj, pyj + t * vyj
        #             if within(pxif, pyif) && within(pxjf, pyjf)
        #                 ans += 1
        #             end
        #         end
        #     end
        # else
        #     t = (pxi - pxj) / (vxj - vxi)
        #     println("$i $j $t")
        #     if t > 0 && t * (vyj - vyi) ≈ pyi - pyj
        #         pxif, pyif = pxi + t * vxi, pyi + t * vyi
        #         pxjf, pyjf = pxj + t * vxj, pyj + t * vyj
        #         if within(pxif, pyif) && within(pxjf, pyjf)
        #             ans += 1
        #         end
        #     end
        # end

        # ^ assumes realtime movement whoops
        # pxi + t * vxi = pxj + t * vxj
        # pxi - pxj = t * (vxj - vxi)

        mi = vyi / vxi
        mj = vyj / vxj

        bi = pyi - mi * pxi
        bj = pyj - mj * pxj

        # y = mi * x + bi
        # y = mj * x + bj
        # 0 = (mi-mj) * x + (bi-bj)
        # x = bj-bi / mi-mj

        if mi != mj
            x = (bj-bi) / (mi-mj)
            y = mi * x + bi

            ti = (x-pxi) / vxi
            tj = (x-pxj) / vxj

            if within(x, y) && ti > 0 && tj > 0
                ans += 1
            end
        elseif bi == bj
            ans += 1
        end
    end
    println(ans)
end

solve()
