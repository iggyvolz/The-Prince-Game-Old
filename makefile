lua_target := 
GLOBALS := data unpack describe it
build:
	lua build.lua>data.lua
check: build
	luacheck$(lua_target) `find .|grep lua` --globals $(GLOBALS)
	busted .
