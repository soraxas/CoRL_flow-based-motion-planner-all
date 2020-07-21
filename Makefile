.PHONY: fix-sub-repo weight-files clean


SUBREPO=GenerateStats normalising-flow-distribution path_dataset_generator
DOT_GIT_TARGET=$(addsuffix /.git, $(SUBREPO))

NETWORK_WEIGHTS=$(addprefix normalising-flow-distribution/trained-weights/, samppt_net-2d_ptrobot_map8x8.tar samppt_net_4d_map32x32.tar samppt_net-6d_tx90.tar)
NETWORK_WEIGHTS_COMPRESS:=trained-weights.7z



all: fix-sub-repo.git
	@# echo $(SUBREPO)
	@# echo $(DOT_GIT_TARGET)

fix-sub-repo.git: $(DOT_GIT_TARGET)

weight-files: $(NETWORK_WEIGHTS)

# link .git to ..git (originally need to rename to ..git because GIT ignores .git)
# this is just a quick and dirty way to track multiple git repositories
%/.git: %/..git
	ln -s ..git $@
	cd "$</.." && git checkout .


$(NETWORK_WEIGHTS): normalising-flow-distribution/$(NETWORK_WEIGHTS_COMPRESS)
	cd normalising-flow-distribution && 7z x $(NETWORK_WEIGHTS_COMPRESS)


normalising-flow-distribution/$(NETWORK_WEIGHTS_COMPRESS):
	@ echo "DOWNLOAD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"


clean:
	rm -rf $(DOT_GIT_TARGET)
	echo $(SUBREPO) | xargs -n1 echo | xargs -I_ find _ -maxdepth 1 -mindepth 1 ! -name u \
		! -name ..git -exec rm -rf {} \;

clean_weights:
	rm -rf $(NETWORK_WEIGHTS)
	rm -rf $(NETWORK_WEIGHTS_COMPRESS)