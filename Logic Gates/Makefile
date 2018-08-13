
DEVICE= $(wildcard source/*.sv)
TESTBENCH= $(wildcard tests/*.sv)
CC=iverilog

all:
	mkdir -p build
	$(CC) $(DEVICE) $(TESTBENCH) -o build/dut