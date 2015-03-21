lua_target := 52
build:
	lua build.lua $(build_ignore)>data.lua
check: build
	luac$(lua_target) -p `find .|grep lua`
	luacheck$(lua_target) `find .|grep lua`
