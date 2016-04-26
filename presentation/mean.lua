require("mylib")

function animateMeanPath(items, lim)
    local x
    local nodes, weights, l={}, {}
    local s1, num, den={}, {}, {}
    for i,item in ipairs(items) do
        table.insert(nodes, item.node)
        x=interp([[\only<.($i)>{\SetMyToken{$token}}\onslide<.($i)->{$arrow$node}]],
                            {i=i, token=item.token, node=item.node,
                             arrow=i>1 and string.format("$\\xrightarrow{%s}$", weights[i-1]) or "",
                             })
        table.insert(s1,x)
        if i > 1 then
            x=interp([[\onslide<.($i)->{$weight}]], {i=i, weight=weights[i-1]})
            table.insert(num,x)
            x=interp([[\only<.($i)$range>{$count}]], {i=i, count=i-1, range= i==#items and "-" or ""})
            table.insert(den,x)
        end
        table.insert(weights, item.weight)
    end
    tsi([[$path \onslide<.($count)->{$\ldots$} \begin{align*}\onslide<.(2)->{\frac{$num}{$den} \onslide<.($count)->{$lim}} \end{align*}]],
            {path=table.concat(s1,""), num=table.concat(num,""), den=table.concat(den,""), count=#items+1, lim=lim})
    tsi([[\addtocounter{beamerpauses}{$count}]],{count=#items+1})
end

function CmdAnimateMeanPath(input, lim)
    local splitted=splitCommas(input)
    local items, l, r, n = {}
    for _, s in ipairs(splitted) do
        l,r = string.match(s, "(.*)/(.*)")
        n = string.sub(l,1,1)
        table.insert(items, {node=n, token=l, weight=r})
    end
    animateMeanPath(items, lim)
end
