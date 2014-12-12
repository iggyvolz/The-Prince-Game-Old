build:
	lua build.lua>$(file)
	cat quick.lua>>$(file)
