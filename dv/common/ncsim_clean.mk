#****************************************************************************
#* questa_target.mk
#*
#* Clean target for Cadence NCSim
#*
#****************************************************************************

COMMON_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
PACKAGES_DIR := $(abspath $(COMMON_DIR)/../../packages)

clean ::
	rm -rf worklib cds.lib hdl.var *.log
