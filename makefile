file := "quick.lua"
build:
	@lua build.lua>$(file)
	@echo "quick=tbl.src.go">>$(file)
