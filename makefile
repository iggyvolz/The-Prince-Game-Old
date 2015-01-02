file := "dev.lua"
build:
	@lua build.lua>$(file)
	@echo "handle=tbl.src.init(tbl)">>$(file)
