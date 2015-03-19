branch := dev
build_target := $(branch).lua
build_ignore := 404 build quick remap dev
deploy_target := /usr/local/The-Prince-Game/$(branch).lua
globals := apache2 remap handle quick parent
lua_target := 52
site_deploy_files := quick.lua remap.lua index.html log.php banlist.php ban.php unban.php isbanned.php help.php zohoverify/verifyforzoho.html
site_deploy_target := /usr/local/The-Prince-Game/
build:
	lua build.lua $(build_ignore)>$(build_target)
check: build
	luac$(lua_target) -p `find .|grep lua`
	luacheck$(lua_target) `find .|grep lua` --globals $(globals)
deploy:
	cp $(build_target) $(deploy_target)
deploy-site:
	cp $(site_deploy_files) $(site_deploy_target)
