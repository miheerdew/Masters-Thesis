--std=require("std")

function test()
    if not tex then
        tex={}
        tex.sprint=print
    end
end

function index(array, item)
   for j,u in ipairs(array) do
       if u == item then
           return j
       end
   end
   return nil
end

function map(func, tbl)
    local newtbl = {}
    for i,v in pairs(tbl) do
        newtbl[i] = func(v)
    end
    return newtbl
end

function splitCommas(str)
    local list={}
    for w in string.gmatch(str, "[^,]+") do
        w = string.match(w, "^%s*(.*%S)%s*$")
        if w then
            table.insert(list, w)
        end
    end
    return list
end

function tsf(...)
    tex.sprint(string.format(...))
end

function tsi(str,args,delim)
    tex.sprint(interp(str,args,delim))
end

function interp(s, tab, delim)
    --http://lua-users.org/wiki/StringInterpolation
    local retval
    if delim then
        retval = s:gsub('($%b'..delim..')', function(w) return tab[w:sub(3, -2)] or w end)
    else
        retval = s:gsub('$(%w+)', tab)
    end
    return retval
end
