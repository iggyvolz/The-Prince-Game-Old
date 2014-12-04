function assets:setup(folder)
  local lfs = love.filesystem
  local filesTable = lfs.getDirectoryItems(folder)
  for i,v in ipairs(filesTable) do
    local file = folder.."/"..v
    if lfs.isFile(file) then
      self:addFile(file)
    elseif lfs.isDirectory(file) then
      self:setup(file)
    end
  end
  _G.filename=nil
end
function assets:addFile(filename)
  _G.filename=filename
  file=filename:split("/")
  table.remove(file,1)
  if #file == 1 then
    self[file[1]:split(".")[1]]=assert(self["get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2)],"ERROR: invalid handle get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2))()
  elseif #file == 2 then
    if not self[file[1]] then
      self[file[1]]={}
    end
    self[file[1]][file[2]:split(".")[1]]=assert(self["get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2)],"ERROR: invalid handle get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2))()
  else
    assert(false,"Maximum depth reached on "..filename.." (depth of "..#file..")")
  end
end
function assets:getPng() -- love.graphics.draw(assets.IMG, x-position, y-position, rotation-in-radians, scale-x, scale-y, offset-x, offset-y, shearing-x, shearing-y)
  return love.graphics.newImage(_G.filename)
end
function assets:getMp3() -- assets.SOUND:play()
  return love.audio.newSource(_G.filename,"static")
end
