getvalue = Dict(
                "0" => 0,
                "1" => 1,
                "2" => 2,
                "3" => 3,
                "4" => 4,
                "5" => 5,
                "6" => 6,
                "7" => 7,
                "8" => 8,
                "9" => 9,
                "one"   => 1,
                "two"   => 2,
                "three" => 3,
                "four"  => 4,
                "five"  => 5,
                "six"   => 6,
                "seven" => 7,
                "eight" => 8,
                "nine"  => 9,
           )

function firstdigit(line)
    n = length(line)
    for i in 1:n, key in keys(getvalue)
        k = length(key)
        if i+(k-1) <= n && line[i:i+(k-1)] == key
            return getvalue[key]
        end
    end
end

function lastdigit(line)
    n = length(line)
    for i in n:-1:1, key in keys(getvalue)
        k = length(key)
        if i+(k-1) <= n && line[i:i+(k-1)] == key
            return getvalue[key]
        end
    end
end

function solve()
    sum = 0
    while true
        line = readline()
        if length(line) == 0
            break
        end
        tens, ones = firstdigit(line), lastdigit(line)
        sum += 10*tens + ones
    end
    println(sum)
end

solve()
