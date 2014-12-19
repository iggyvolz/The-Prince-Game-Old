local lfs = require "lfs"
require "io"
local function search (path,excl)
    local toreturn=""
    if path == "." then
        toreturn="local temp,tbl=nil,{}\n"
    else
        toreturn=toreturn.."tbl."..path:gsub("/","."):sub(3).."={}\n"
    end
    for file in lfs.dir(path) do
        if not excl[file] then
            local f = path..'/'..file
            local attr = lfs.attributes (f)
            if type(attr) ~= "table" then break end
            if attr.mode == "directory" then
                toreturn=toreturn..search(f,excl)
            else
                local name=f:gsub("/","."):sub(3,-5)
                toreturn=toreturn.."temp=function() "..assert(io.open(f,"r")):read("*all").." end\ntbl."..name.."=temp()\n"
            end
        end
    end
    toreturn=toreturn
    return toreturn
end
local thesearch=search(".",{["."]=true,[".."]=true,[".git"]=true,[".gitignore"]=true,["build.lua"]=true,["quick.lua"]=true,["README.md"]=true,["makefile"]=true,["remap.lua"]=true,["go.lua"]=true,["index.html"]=true})

print(thesearch)
