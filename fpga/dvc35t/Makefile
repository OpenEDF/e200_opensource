VIVADO ?= vivado
VIVADOFLAGS := \
	-nojournal -mode batch \
	-source script/board.tcl \
	-source script/prologue.tcl

VIVADOFLAGS_SETUP := \
	-nojournal -mode gui \
	-source script/board.tcl \
	-source script/prologue_setup.tcl

# Path to a program in raw binary format to be flashed into the address that the
# bootrom jumps to.
FLASHED_PROGRAM ?=
BIT_FILE := obj/system.bit
BIT_TCL := script/init.tcl script/impl.tcl
MCS_TCL := script/buildfile.tcl

.PHONY: clean bit mcs setup
bit: $(BIT_TCL)
	VSRCS="$(VSRCS)" EXTRA_VSRCS="$(EXTRA_VSRCS)" $(VIVADO) $(VIVADOFLAGS) -source $(BIT_TCL)

mcs: $(BIT_FILE)
	$(VIVADO) -mode batch -source $(MCS_TCL) -tclargs $@ $^ $(FLASHED_PROGRAM)

setup:
	VSRCS="$(VSRCS)" EXTRA_VSRCS="$(EXTRA_VSRCS)" $(VIVADO) $(VIVADOFLAGS_SETUP) -source script/init_setup.tcl 

clean:
	rm -rf -- .Xil .ip_user_files *.os obj src/generated usage_statistics_webtalk.xml usage_statistics_webtalk.html *.log *.jou build
