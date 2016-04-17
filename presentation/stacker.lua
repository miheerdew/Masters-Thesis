#!/usr/bin/env lua

mylib=require("mylib")

function removeRep(stack, index)
    if index then
        for j = index+1, #stack do
            stack[j]=nil
        end
    end
end

function animateStack(items)
    local stack, list, st={}, {}
    local v, found, l

    local count=0
    local function printNextLine(stack, list, token, last)
        local f=""
        if last then
            f="-"
        end

        local fmt="\\only<.(%d)"..f..">{\\settok{%s}}\\only<.(%d)"..f..">{%s\\\\\\bigskip Stack = %s}"
        tex.sprint(string.format(fmt, count, token, count + 1,
                table.concat(list," \\enskip "),
                table.concat(stack, " \\enskip ")))
        count = count + 1
    end

    for i, tok in ipairs(items) do
        v = string.sub(tok, 1, 1)
        assert(v)

        found = index(stack, v)
        table.insert(stack,v)
        table.insert(list,v)

        if found then
              st = map(function (x) if x == v then
                                    return string.format("\\alert{%s}",x)
                                  else return x
                                  end
                     end, stack)
              printNextLine(st, list, tok, false)
              removeRep(stack, found)
        end
        printNextLine(stack, list, tok, i==#items)
    end
    tex.sprint(string.format("\\addtocounter{beamerpauses}{%d}", count))
end
