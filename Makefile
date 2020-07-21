.PHONY: populate-sub-repo weight-files clean


SUBREPO=GenerateStats normalising-flow-distribution path_dataset_generator
DOT_GIT_TARGET=$(addsuffix /.git, $(SUBREPO))

NETWORK_WEIGHTS=normalising-flow-distribution/trained-weights/
NETWORK_WEIGHTS_COMPRESS:=trained-weights.7z



all: populate-sub-repo

populate-sub-repo: $(DOT_GIT_TARGET)

weight-files: $(NETWORK_WEIGHTS)

# link .git to ..git (originally need to rename to ..git because GIT ignores .git)
# this is just a quick and dirty way to track multiple git repositories
%/.git: %/..git
	ln -s ..git $@
	cd "$</.." && git checkout .


$(NETWORK_WEIGHTS): normalising-flow-distribution/$(NETWORK_WEIGHTS_COMPRESS)
	cd normalising-flow-distribution && 7z x $(NETWORK_WEIGHTS_COMPRESS)
	touch "$@"


normalising-flow-distribution/$(NETWORK_WEIGHTS_COMPRESS):
	curl https://ndownloader.figshare.com/files/24008462?private_link=3dc49260d459462c5ecf --output "$@"


clean:
	rm -rf $(DOT_GIT_TARGET)
	echo $(SUBREPO) | xargs -n1 echo | xargs -I_ find _ -maxdepth 1 -mindepth 1 ! -name u \
		! -name ..git ! -name $(NETWORK_WEIGHTS_COMPRESS) -exec rm -rf {} \;


clean_weights:
	rm -rf $(NETWORK_WEIGHTS_COMPRESS)