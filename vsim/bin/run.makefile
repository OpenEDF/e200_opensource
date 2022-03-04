RUN_DIR      := ${PWD}

TESTCASE     := ${RUN_DIR}/../../riscv-tools/riscv-tests/isa/generated/rv32ui-p-addi
DUMPWAVE     := 1

VSRC_DIR     := ${RUN_DIR}/../install/rtl
VTB_DIR      := ${RUN_DIR}/../install/tb
TESTNAME     := $(notdir $(patsubst %.dump,%,${TESTCASE}.dump))
TEST_RUNDIR  := ${TESTNAME}

RTL_V_FILES		:= $(wildcard ${VSRC_DIR}/*/*.v)
TB_V_FILES		:= $(wildcard ${VTB_DIR}/*.v)

SIM_TOOL      := vcs
SIM_OPTIONS   := -timescale=1ns/1ns \
                 -fsdb \
                 -full64 \
                 +vc +v2k \
                 -sverilog  \
                 -debug_all \
                 -cpp g++-4.8 \
                 -cc  gcc-4.8 \
				 -LDFLAGS -Wl,--no-as-needed  \
                 -P ${LD_LIBRARY_PATH}/novas.tab ${LD_LIBRARY_PATH}/pli.a -load libnovas.so:FSDBDumpCmd \
                 +incdir+${VSRC_DIR}/core/+${VSRC_DIR}/perips/ \
                 -l vcs.log \

# This is a free solution here to use iverilog to compile the code. Please NOTE!!!!
#
# Note:
#   Here we add a macro "DISABLE_SV_ASSERTION" to disable the system-verilog coded
#     assertion in the RTL code because iverilog cannot support that syntax, if you
#     use other EDA tools which support the systemverilog, you should not add this macro "DISABLE_SV_ASSERTION".
#
#   Here we didnt add macro "ENABLE_TB_FORCE"
#     that macro was used to enable the random interrupt and bus-error insertion to make
#           more intensive test in e200_opensource/tb/tb_top.v.
#           Although the test become more intensive, the drawback is it makes the regression
#           simulation running very slower, so by default now it is turned off.
#           If you want to turn on them without caring the the regression speed,
#           you can just add macro `ENABLE_TB_FORCE` here in command line.

SIM_EXEC      := ../simv
WAV_TOOL      := verdi
WAV_OPTIONS   := -2001 -sv -top tb_top \
                 +incdir+${VSRC_DIR}/core/+${VSRC_DIR}/perips/

all: run

compile.flg: ${RTL_V_FILES} ${TB_V_FILES}
	@-rm -rf compile.flg
	${SIM_TOOL} ${SIM_OPTIONS}  ${RTL_V_FILES} ${TB_V_FILES} ;
	touch compile.flg

compile: compile.flg 

wave: 
	${WAV_TOOL} ${WAV_OPTIONS} ${RTL_V_FILES} ${TB_V_FILES} &

run: compile
	rm -rf ${TEST_RUNDIR}
	mkdir ${TEST_RUNDIR}
	cd ${TEST_RUNDIR}; ${SIM_EXEC} +DUMPWAVE=${DUMPWAVE} +TESTCASE=${TESTCASE} |& tee ${TESTNAME}.log; cd ${RUN_DIR}; 

.PHONY: run clean all 

