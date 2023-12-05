function find_location(seed, maps)
    cur = seed
    for map in maps
        for (d_start, s_start, r_length) in map
            if s_start <= cur && cur <= s_start + (r_length-1)
                cur = d_start + (cur - s_start)
                break
            end
        end
    end
    return cur
end

function solve()
    open("in.txt", "r") do io
        line = readline(io)
        i = findfirst(c -> c == ':', line)
        seeds = parse.(Int, split(line[i+2:end], ' '))
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
        for seed in seeds
            res = min(res, find_location(seed, maps))
        end
        println(res)
    end
end

solve()
