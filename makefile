file := "go.lua"
build:
	@lua build.lua>$(file)
	@echo "handle=function(r) tbl.src.log('foo',r) end">>$(file)
