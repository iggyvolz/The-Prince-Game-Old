branch := dev
build_target := $(branch).lua
build_ignore := build quick remap dev
deploy_target := /usr/local/The-Prince-Game/$(branch).lua
globals := apache2 remap handle quick parent
site_deploy_files := quick.lua remap.lua index.html log.php banlist.php ban.php unban.php isbanned.php help.php
site_deploy_target := /usr/local/The-Prince-Game/
build:
	@lua build.lua $(build_ignore)>$(build_target)
check: build
	@luacheck `find .|grep lua` --globals $(globals)
deploy:
	@cp $(build_target) $(deploy_target)
deploy-site:
	@cp $(site_deploy_files) $(site_deploy_target)
