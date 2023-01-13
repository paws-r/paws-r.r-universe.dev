
update-universe:
	@git submodule init
	@git submodule update --remote
	@Rscript update_universe.R
