#****************************************************************************
#* vcs_clean.mk
#*
#* Clean target for Synopsys VCS
#*
#****************************************************************************

COMMON_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
PACKAGES_DIR := $(abspath $(COMMON_DIR)/../../packages)

clean ::
	rm -rf simv simv.* csrc pli.tab ucli.key

