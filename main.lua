assets={}
assets.__index=assets
--[[
  SETTINGS:
    * boolean skipsplashes - Skips splashes if true
    * number volume - Sets volume; see https://www.love2d.org/wiki/love.audio.setVolume
  Specify like: love . setting1=setting2 setting3[=true]
  Not setting at runtime produces the default setting in config.lua
  Specifying without an equals sign makes the setting equal to "true".
  Please set a default value in config.lua if you intend to add a setting.
  If you wish to make changes to the configuration settings without influencing the server default, you may wish to git update-index --assume-unchanged config.lua.
  Please undo this with git update-index --no-assume-unchanged config.lua if you wish to commit changes on this file to the repo - remember to stash your local changes first.
  If config.lua is updated and you are assuming it unchanged, you may want to do: git update-index --no-assume-unchanged config.lua && git stash && git pull origin master && git stash apply && git update-index --assume-unchanged config.lua.
]]
settings={
}
function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end
function love.load(t)
  if love.filesystem.getDirectoryItems then require "assets" else require "assets-websafe" end
  require "config"
  settings=ldconfig()
  for i,v in ipairs(t) do
    if i ~= 1 then
      if v:match("=") then
        key,value=unpack(v:split("="))
        if value == "true" then
          settings[key]=true
        elseif value == "false" then
          settings[key]=false
        elseif value == "nil" then
          settings[key]=nil
        elseif tonumber(volume) ~= nil then
          settings[key]=tonumber(value)
        else
          settings[key]=value
        end
      else
        settings[v]=true
      end
    end
  end
  if settings.volume then
    love.audio.setVolume(settings.volume)
  end
  assets:setup("assets")
  if settings.skipsplashes then
    game=require "game"
  else
    splashes=require "splashes"
  end
end
