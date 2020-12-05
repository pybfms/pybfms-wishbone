
COMMON_DIR    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

ifneq (1,$(RULES))
PROJECT_DIR  := $(abspath $(COMMON_DIR)/../..)
PACKAGES_DIR := $(abspath $(PROJECT_DIR)/packages)
SIM ?= icarus
SIMTYPE ?= functional
TIMEOUT ?= 1ms


PYBFMS_MODULES += wishbone_bfms
VLSIM_CLKSPEC += -clkspec clk=10ns

TOP_MODULE ?= unset

PYTHONPATH := $(COMMON_DIR)/python:$(PROJECT_DIR)/src:$(PYTHONPATH)
export PYTHONPATH

PATH := $(PACKAGES_DIR)/python/bin:$(PATH)
export PATH

#********************************************************************
#* Source setup
#********************************************************************
FWRISC_SRCS = $(wildcard $(PACKAGES_DIR)/fwrisc/rtl/*.sv)
INCDIRS += $(PACKAGES_DIR)/fwprotocol-defs/src/sv

include $(COMMON_DIR)/$(SIM).mk

else # Rules

clean ::
	rm -f results.xml

include $(COMMON_DIR)/$(SIM).mk
include $(wildcard $(COMMON_DIR)/*_clean.mk)

endif
