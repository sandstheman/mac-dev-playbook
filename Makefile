.DEFAULT_GOAL := help

## Install pre-requisites
install:
	./pre-req-install.sh	
   
## See all the Makefile targets
help:
		@awk -v skip=1 \
			'/^##/ { sub(/^[#[:blank:]]*/, "", $$0); doc_h=$$0; doc=""; skip=0; next } \
			 skip  { next } \
			 /^#/  { doc=doc "\n" substr($$0, 2); next } \
			 /:/   { sub(/:.*/, "", $$0); printf "\033[34m%-30s\033[0m\033[1m%s\033[0m %s\n", $$0, doc_h, doc; skip=1 }' \
			$(MAKEFILE_LIST)

.PHONY: help
