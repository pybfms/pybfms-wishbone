TEST_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

TOP_MODULE = initiator_smoke_tb
SRCS += $(TEST_DIR)/initiator_smoke_tb.sv

include $(TEST_DIR)/../common/defs_rules.mk

#********************************************************************
#* cocotb testbench setup
#********************************************************************
PYTHONPATH := $(TEST_DIR):$(PYTHONPATH)
export PYTHONPATH

MODULE=pybfms_wishbone_tests.initiator_smoke
export MODULE

VLSIM_OPTIONS += -Wno-fatal --autoflush

RULES := 1

all : run

include $(TEST_DIR)/../common/defs_rules.mk

