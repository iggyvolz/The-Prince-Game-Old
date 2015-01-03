local lfs = require "lfs"
require "io"
local function isnt_ignored(f)
  for v in ipairs(arg) do
    if v == f:sub(-4,-1) then
      return false
    end
  end
  return true
end
local function search (path,excl)
  local toreturn=""
  if path == "." then
    toreturn="local tbl={}\nlocal temp\n"
  else
    toreturn=toreturn.."tbl."..path:gsub("/","."):sub(3):gsub("(%.)(%d)","[%2]").."={}\n"
  end
  for file in lfs.dir(path) do
    if not excl[file] then
      local f = path..'/'..file
      local attr = lfs.attributes (f)
      if type(attr) ~= "table" then break end
      if attr.mode == "directory" then
        toreturn=toreturn..search(f,excl)
      elseif file:sub(-4,-1)==".lua" and isnt_ignored(file) then
        local name=f:gsub("/","."):sub(3,-5)
        toreturn=toreturn.."temp=function() "..assert(io.open(f,"r")):read("*all").." end\ntbl."..name:gsub("(%.)(%d)","[%2]").."=temp()\n"
      end
    end
  end
  return toreturn
end
local thesearch=search(".",{["."]=true,[".."]=true,[".git"]=true,[".gitignore"]=true,["build.lua"]=true,["quick.lua"]=true,["README.md"]=true,["makefile"]=true,["remap.lua"]=true,["go.lua"]=true,["index.html"]=true,["log.php"]=true,["404.lua"]=true,["banlist.php"]=true,["ban.php"]=true,["unban.php"]=true,["isbanned.php"]=true,["help.php"]=true})
thesearch=thesearch.."\n\nhandle=tbl.src.init(tbl)"
print(thesearch)
