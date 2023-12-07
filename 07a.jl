function get_type(hand)
    counter = Dict()
    for c in collect(hand)
        counter[c] = get(counter, c, 0) + 1
    end
    counts = values(counter) |> collect |> sort
    if counts == [5] # five of a kind
        return 0
    elseif counts == [1, 4] # four of a kind
        return 1
    elseif counts == [2, 3] # full house
        return 2
    elseif counts == [1, 1, 3] # three of a kind
        return 3
    elseif counts == [1, 2, 2] # two pair
        return 4
    elseif counts == [1, 1, 1, 2] # one pair
        return 5
    else
        return 6
    end
end

function to_value(hand)
    order = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']
    return collect(hand) .|> (c -> findfirst(cc -> cc == c, order))
end

function my_isless(pair_1, pair_2)
    hand_1, hand_2 = first.([pair_1, pair_2])
    type_1, type_2 = get_type.([hand_1, hand_2])
    if type_1 != type_2
        return isless(type_1, type_2)
    else
        value_1, value_2 = to_value.([hand_1, hand_2])
        return isless(value_1, value_2)
    end
end

function solve()
    hands = []
    while true
        line = readline()
        if length(line) == 0
            break
        end
        hand, bid = split(line)
        bid = parse(Int, bid)
        push!(hands, (hand, bid))
    end
    sort!(hands, lt=my_isless, rev=true)
    winnings = 0
    for (i, (hand, bid)) in enumerate(hands)
        winnings += i * bid
    end
    println(winnings)
end

solve()
