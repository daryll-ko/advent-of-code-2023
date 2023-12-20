using DataStructures

function solve()
    ff = Dict()
    conj = Dict()
    graph = Dict()

    lines = readlines() .|> (l -> split(l, " -> ")) .|> (((f, t),) -> (f, split(t, ", ")))
    
    for (from, to) in lines
        if startswith(from, "%")
            from = from[begin+1:end]
            ff[from] = false
        elseif startswith(from, "&")
            from = from[begin+1:end]
            conj[from] = Dict()
        end
        graph[from] = to
    end

    for (from, to) in lines
        from = startswith(from, "%") || startswith(from, "&") ? from[begin+1:end] : from
        for t in to
            if haskey(conj, t)
                conj[t][from] = false
            end
        end
    end

    low, high = 0, 0
    pulses = Queue{Tuple{String,Bool,String}}()

    for _ in 1:1000
        # low pulse = false, high pulse = true
        enqueue!(pulses, ("button", false, "broadcaster"))

        while length(pulses) > 0
            from, pulse, mod = dequeue!(pulses)
            # println("$from -$(pulse ? "high" : "low")-> $mod")
            if !pulse
                low += 1
            else
                high += 1
            end
            if !haskey(graph, mod)
                continue
            end
            next_pulse = false
            if haskey(ff, mod)
                if pulse
                    continue
                else
                    ff[mod] = !ff[mod]
                    next_pulse = ff[mod]
                end
            elseif haskey(conj, mod)
                conj[mod][from] = pulse
                next_pulse = !all(values(conj[mod]))
            end
            for next in graph[mod]
                enqueue!(pulses, (mod, next_pulse, next))
            end
        end
    end

    println("$low $high $(low*high)")
end

solve()
