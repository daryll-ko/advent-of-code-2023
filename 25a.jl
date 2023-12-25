function solve()
    lines = readlines()
    n = length(lines)

    to_int = Dict()
    n = 1

    for line in lines
        u, vs = split(line, ": ")
        vs = split(vs, " ")

        if !haskey(to_int, u)
            to_int[u] = n
            n += 1
        end

        for v in vs
            if !haskey(to_int, v)
                to_int[v] = n
                n += 1
            end
        end
    end

    n -= 1

    graph = [[] for _ in 1:n]

    for line in lines
        u, vs = split(line, ": ")
        vs = split(vs, " ")

        for v in vs
            push!(graph[to_int[u]], to_int[v])
            push!(graph[to_int[v]], to_int[u])
        end
    end
    
    # println(n)
    # for u in 1:n
    #     print("$(length(graph[u])) ")
    #     for v in graph[u]
    #         print("$v ")
    #     end
    #     println()
    # end

    # union-find

    link = collect(1:n)
    size = [1 for _ in 1:n]
    num_components = n

    function get_leader(i)
        if i == link[i]
            return i
        else
            answer = get_leader(link[i])
            link[i] = answer
            return answer
        end
    end

    function same_leader(i, j)
        return get_leader(i) == get_leader(j)
    end

    function unite(i, j)
        if !same_leader(i, j)
            i = get_leader(i)
            j = get_leader(j)
            if size[i] < size[j]
                i, j = j, i
            end
            size[i] += size[j]
            link[j] = i
            num_components -= 1
        end
    end

    blacklist = [(776, 777), (857, 1240), (1000, 892)]

    for i in 1:n
        filter!(j -> (i, j) ∉ blacklist && (j, i) ∉ blacklist, graph[i])
    end

    visited = [false for _ in 1:n]
    cur_size = 0

    function dfs(u)
        visited[u] = true
        cur_size += 1
        for v in graph[u]
            if !visited[v]
                dfs(v)
            end
        end
    end

    ans = 1
    for i in 1:n
        if !visited[i]
            cur_size = 0
            dfs(i)
            println(cur_size)
            ans *= cur_size
        end
    end

    println(ans)
end

solve()
