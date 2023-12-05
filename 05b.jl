function cross_ranges(ranges_1, ranges_2)
    res = []
    for (l_1, r_1) in ranges_1
        for (l_2, r_2) in ranges_2
            # println("hi: ($l_1, $r_1), ($l_2, $r_2)")
            if l_1 > r_1
                break
            elseif r_1 < l_2
                if r_1 < ranges_2[1][1]
                    push!(res, (l_1, r_1))
                end
                break
            elseif r_2 < l_1
                if ranges_2[end][2] < l_1
                    push!(res, (l_1, r_1))
                    break
                end
                continue
            elseif l_2 <= l_1
                r = min(r_1, r_2)
                push!(res, (l_1, r))
                l_1 = r+1
            else
                push!(res, (l_1, l_2-1))
                l_1 = l_2
                r = min(r_1, r_2)
                push!(res, (l_1, r))
                l_1 = r+1
            end
        end
    end
    return res
end

function find_location(seed_ranges, maps)
    cur = seed_ranges
    for map in maps
        map_ranges = []
        for (d_start, s_start, r_length) in map
            push!(map_ranges, (s_start, s_start + (r_length-1)))
        end
        sort!(cur)
        sort!(map_ranges)
        all_ranges = cross_ranges(cur, map_ranges)
        # each range in all_ranges should be fully contained in some range in map

        # println("cur:\t\t $cur")
        # println("map:\t\t $map_ranges")
        # println("all:\t\t $all_ranges")

        next = []
        for (l, r) in all_ranges
            mapped = false
            for (d_start, s_start, r_length) in map
                s_end = s_start + (r_length-1)
                if s_start <= l && r <= s_end
                    push!(next, (d_start + (l - s_start), d_start + (r - s_start)))
                    mapped = true
                    break
                end
            end
            if !mapped
                push!(next, (l, r))
            end
        end
        # println("next:\t\t $next")
        # println()
        cur = next
    end
    return cur
end

function solve()
    open("in.txt", "r") do io
        line = readline(io)
        i = findfirst(c -> c == ':', line)
        seeds_raw = parse.(Int, split(line[i+2:end], ' '))
        seed_ranges = []
        for j in 1:2:length(seeds_raw)
            start, length = seeds_raw[j:j+1]
            push!(seed_ranges, (start, start + (length-1)))
        end
        maps = []
        while !eof(io)
            line = readline(io)
            if occursin("map", line)
                push!(maps, [])
            elseif length(line) > 0
                d_start, s_start, r_length = parse.(Int, split(line, ' '))
                push!(maps[end], (d_start, s_start, r_length))
            end
        end
        res = 10^10
        for (l, r) in find_location(seed_ranges, maps)
            res = min(res, l)
        end
        println(res)
    end
end

solve()
