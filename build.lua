local lfs = require "lfs"
require "io"
local function search (path,excl)
  local toreturn=""
  if path == "./data" then
    toreturn="local data,temp={}\n"
  else
    toreturn=toreturn..path:gsub("/","."):sub(3):gsub("(%.)(%d)","[%2]").."={}\n"
  end
  for file in lfs.dir(path) do
    if file:sub(1,1) ~= "." then
      local f = path..'/'..file
      local attr = lfs.attributes (f)
      if type(attr) ~= "table" then break end
      if attr.mode == "directory" then
        toreturn=toreturn..search(f,excl)
      elseif file:sub(-4,-1)==".lua" then
        local name=f:gsub("/","."):sub(3,-5)
        toreturn=toreturn.."temp=function() "..assert(io.open(f,"r")):read("*all").." end\n"..name:gsub("(%.)(%d)","[%2]").."=temp()\n"
      end
    end
  end
  return toreturn
end
local thesearch=search("./data")
print(thesearch.."\nreturn data")
