file := "go.lua"
build:
	@lua build.lua>$(file)
	@echo "handle=function() tbl.src.log('foo') end">>$(file)
