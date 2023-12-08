function solve()
    open("in.txt", "r") do io
        steps = readline(io)
        to_int = Dict()
        to_left = Dict()
        to_right = Dict()
        cur = 1
        while !eof(io)
            line = readline(io)
            if length(line) == 0
                continue
            end
            re = r"^([A-Z]{3}) = \(([A-Z]{3}), ([A-Z]{3})\)"
            now, left, right = match(re, line) |> m -> m.captures
            for node in [now, left, right]
                if !haskey(to_int, node)
                    to_int[node] = cur
                    cur += 1
                end
            end
            to_left[to_int[now]] = to_int[left]
            to_right[to_int[now]] = to_int[right]
        end
        from, to = to_int["AAA"], to_int["ZZZ"]
        num_steps = 0
        while from != to
            i = num_steps % length(steps)
            step = steps[i+1]
            from = step == 'L' ? to_left[from] : to_right[from]
            num_steps += 1
        end
        println(num_steps)
    end
end

solve()
