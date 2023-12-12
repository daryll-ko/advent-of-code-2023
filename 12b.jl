function ways(row, counts)
    n, m = length(row), length(counts)
    # dp[i, j] -> # of ways for row[1:i-1], counts[1:j-1]
    dp = [0 for _ in 1:n+1, _ in 1:m+1]
    for i in 1:n+1
        if i > 1 && row[i-1] == '#'
            break
        end
        dp[i, 1] = 1
    end
    for i in 2:n+1, j in 2:m+1
        last_run = counts[j-1]
        start = i-1 - last_run + 1 # start of # run (as `row` index)
        if row[i-1] == '?'
            if start >= 1 && all(c -> c ∈ ['#', '?'], collect(row[start:(i-1)])) && (start == 1 || row[start-1] ∈ ['.', '?'])
                dp[i, j] = start == 1 ? dp[start, j-1] : dp[start-1, j-1]
            end
            dp[i, j] += dp[i-1, j] # if '.'
        elseif row[i-1] == '#'
            if start >= 1 && all(c -> c ∈ ['#', '?'], collect(row[start:(i-1)])) && (start == 1 || row[start-1] ∈ ['.', '?'])
                dp[i, j] = start == 1 ? dp[start, j-1] : dp[start-1, j-1]
            end
        else
            dp[i, j] = dp[i-1, j]
        end
    end
    return dp[n+1, m+1]
end

function solve()
    total = 0
    for line in readlines()
        row, counts = split(line, ' ')

        # unfolding
        row = join([row for _ in 1:5], '?')
        counts = join([counts for _ in 1:5], ',')

        counts = parse.(Int, split(counts, ','))
        res = ways(row, counts)
        total += res
    end
    println(total)
end

solve()
