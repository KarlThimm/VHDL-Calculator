GHDL=ghdl
GHDLFLAGS=
MODULES=\
	mux_2to1.o \
	mux_4to1.o \
	demux_1to4.o \
	full_adder.o \
	controller.o \
	ALU8bit.o \
	reg8.o \
	reg8n4.o \
	calculator.o \
	top_level.o \
	top_level_tb


test: $(MODULES)
		$(GHDL) -r top_level_tb --vcd=top_level.vcd
		
%: %.o
		$(GHDL) -e $(GHDLFLAGS) $@

%.o: %.vhdl
		$(GHDL) -a $(GHDLFLAGS) $<
		