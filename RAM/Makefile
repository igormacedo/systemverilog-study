
DEVICE= $(wildcard source/*.sv)
TESTBENCH= $(wildcard tests/*.sv)
CC=iverilog

build:
	mkdir -p build
	$(CC) $(DEVICE) $(TESTBENCH) -o build/dut

run:
	./build/dut

wave:
	gtkwave ./build/wave.vcd

clean:
	rm -rf build