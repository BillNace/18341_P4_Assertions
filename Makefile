# 18-341 Assertion Project

# ========================================================
#
#    ADD YOUR FILES HERE
#
#    For example:
#      STUDENT_FILES=top.sv assertions.sv inputs.sv
#
# ========================================================

STUDENT_FILES=top.sv
TARGET=simv
# ========================================================
#
#    DON'T CHANGE ANYTHING BELOW HERE
#
# ========================================================

# Set the number of threads to use for parallel compilation (2 * cores)
CORES = $(shell getconf _NPROCESSORS_ONLN)
THREADS = $(shell echo $$((2 * $(CORES))))

VCSFLAGS= -full64 -sverilog -debug_all +warn=all -j$(THREADS) \
					-timescale=1ns/1ps +v2k
VCSFLAGS_GUI= -full64 -sverilog -debug_all +warn=all -j$(THREADS) \
					-timescale=1ns/1ps +v2k-gui

default: broken

golden: $(STUDENT_FILES) TA_calc_golden.svp
		vcs $(VCSFLAGS) $^

broken: $(STUDENT_FILES) TA_calc_broken.svp
		vcs $(VCSFLAGS) $^

goldengui: $(STUDENT_FILES) TA_calc_golden.svp
		vcs $(VCSFLAGS_GUI) $^

brokengui: $(STUDENT_FILES) TA_calc_broken.svp
		vcs $(VCSFLAGS_GUI) $^

clean:
	-rm -r csrc
	-rm -r DVEfiles
	-rm $(TARGET)
	-rm -r $(TARGET).vdb
	-rm -r $(TARGET).daidir
	-rm ucli.key
