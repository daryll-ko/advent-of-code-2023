function diffs(seq)
    return [seq[i+1] - seq[i] for i in 1:length(seq)-1]
end

function get_prev(seq)
    if all(val -> val == 0, seq)
        return 0
    else
        return seq[begin] - get_prev(diffs(seq))
    end
end

function solve()
    total = 0
    while true
        line = readline()
        if length(line) == 0
            break
        end
        nums = parse.(Int, line |> split)
        total += get_prev(nums)
    end
    println(total)
end

solve()
