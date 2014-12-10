local lfs = require "lfs"

function attrdir (path,excl)
    local toreturn={}
    for file in lfs.dir(path) do
        if not excl[file] then
            local f = path..'/'..file
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                local ad=attrdir(f,excl)
                for i=1,#ad do
                    table.insert(toreturn,ad[i])
                end
            else
                table.insert(toreturn,f)
            end
        end
    end
    return toreturn
end
