library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level_tb is
end top_level_tb;

architecture behave of top_level_tb is
--  Declaration of the component that will be instantiated.
component top_level
	port
	(
		input : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		output : out std_logic_vector(7 downto 0)
	);
end component;

signal clk: std_logic;
signal input : std_logic_vector(7 downto 0); 
signal output : std_logic_vector(7 downto 0); 

begin

	top_levell: top_level port map (input => input, 
									clk => clk, 
									output => output);
	
process
	type pattern_type is record
	--  The inputs of the reg.
	clk: std_logic;
	input : std_logic_vector(7 downto 0);
	--  The expected outputs of the reg.
	output : std_logic_vector(7 downto 0);
end record; 

type pattern_array is array (natural range <>) of pattern_type;
constant patterns : pattern_array := 
--Instruction Structure:
--OP|rs1|rs2|ws (add(00)/sub(01))
--OP|int|ws (lw)
--OP|rs1|null (print)

--All inputs are done twice to simulate button presses on the FPGA board
(
--clk    Input       Output
('0', "00000000", "00000000"), --add r0 r0 r0
('1', "00000000", "00000000"), 
('0', "10000100", "00000000"), --lw 0001 r0
('1', "10000100", "00000000"), 
('0', "11000000", "00000001"), --pr r0, outputs 1
('1', "11000000", "00000001"), 
('0', "10111101", "00000000"), --lw 1111 r1
('1', "10111101", "00000000"), 
('0', "11010000", "11111111"), --pr r1, outputs -1
('1', "11010000", "11111111"), 
('0', "00000010", "00000000"), --add r0 r0 r2, result 2
('1', "00000010", "00000000"), 
('0', "11100000", "00000010"), --pr r2, outputs 2
('1', "11100000", "00000010"),
('0', "01100011", "00000000"), --sub r2 r0 r3, result 1
('1', "01100011", "00000000"), 
('0', "11110000", "00000001"), --pr r3, outputs 1
('1', "11110000", "00000001"), 
('0', "00010111", "00000000"), --add r1 r1 r4, result -2
('1', "00010111", "00000000"),
('0', "11110000", "11111110"), --pr r3, outputs -2
('1', "11110000", "11111110"), 
('0', "01100111", "00000000"), --sub r2 r1, result 3
('1', "01100111", "00000000"), 
('0', "11110011", "00000011"), --pr r3, outputs 3
('1', "11110011", "00000011"), 
('0', "00000000", "00000000") --empty
); --end of test vectors

begin 
	--  Check each pattern.
	for n in patterns'range loop
		--  Set the inputs.
		clk <= patterns(n).clk;
		input <= patterns(n).input;
		--  Wait for the results.
		wait for 5 ns;
		--  Check the outputs.
		assert output = patterns(n).output
		report "incorrect output" severity error;
		
	end loop;
	assert false report "end of test" severity note;
	--  Wait forever; this will finish the simulation.
	wait;
	end process;
end behave;