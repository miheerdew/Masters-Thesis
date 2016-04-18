require("mylib")

--function removeRep(stack, index)
    --if index then
        --for j = index+1, #stack do
            --stack[j]=nil
        --end
    --end
--end

local count = 0

local function printNextLine(token, nodes, weights, lim)
    local last, math=false
    if lim then
        lim = "\\to "..lim
        last=true
    else
        lim = ""
    end

    local math_fmt="\\[\\frac{%s}{%d} %s \\]"
    if #weights == 0 then
        math=""
    else
        math=string.format(math_fmt, table.concat(weights, ""), #weights, lim)
    end

    if last then -- This is last
        tsf("\\only<.(%d)>{\\settok{%s}}\\only<.(%d)->{%s \\enskip $\\ldots$ \\\\ %s }",
                count, token, count + 1,
                table.concat(nodes," \\enskip "),
                math)
        tsf("\\addtocounter{beamerpauses}{%d}", count+1)
    else
        tsf("\\only<.(%d)>{\\settok{%s}}\\only<.(%d)>{%s \\\\ %s }",
                    count, token, count + 1,
                    table.concat(nodes," \\enskip "),
                    math)
        count = count + 1
    end
end

function animateMeanPath(items, lim)
    count=0
    local nodes, weights, l={}, {}
    for i,item in ipairs(items) do
        table.insert(nodes, item.node)
        if i == #items then
            l = lim
        end
        printNextLine(item.token, nodes, weights, l)
        table.insert(weights, item.weight)
    end
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
