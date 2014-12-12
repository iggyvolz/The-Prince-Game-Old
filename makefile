file := "quick.lua"
build:
	@lua build.lua>$(file)
	@echo "src.go()">>$(file)
