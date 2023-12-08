function solve()
    open("in.txt", "r") do io
        steps = readline(io)
        to_int, to_str, to_left, to_right = Dict(), Dict(), Dict(), Dict()
        cur = 1
        while !eof(io)
            line = readline(io)
            if length(line) == 0
                continue
            end
            re = r"^([A-Z0-9]{3}) = \(([A-Z0-9]{3}), ([A-Z0-9]{3})\)"
            now, left, right = match(re, line) |> m -> m.captures
            for node in [now, left, right]
                if !haskey(to_int, node)
                    to_int[node] = cur
                    to_str[cur] = node
                    cur += 1
                end
            end
            to_left[to_int[now]] = to_int[left]
            to_right[to_int[now]] = to_int[right]
        end
        from = keys(to_int) |> filter(key -> key[end] == 'A') .|> key -> to_int[key]
        n = length(from)
        num_steps = zeros(Int, n)
        for i in 1:n
            while to_str[from[i]][end] != 'Z'
                j = num_steps[i] % length(steps)
                step = steps[j+1]
                from[i] = step == 'L' ? to_left[from[i]] : to_right[from[i]]
                num_steps[i] += 1
            end
        end
        println(lcm(num_steps))
    end
end

solve()
