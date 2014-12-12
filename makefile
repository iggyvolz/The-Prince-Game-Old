file := "quick.lua"
build:
	@lua build.lua>$(file)
	@echo "tbl.src.go()">>$(file)
