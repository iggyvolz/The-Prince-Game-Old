file := "go.lua"
build:
	@lua build.lua>$(file)
	@echo "handle=function() log('foo') end">>$(file)
