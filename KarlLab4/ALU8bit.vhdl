library ieee;
use ieee.std_logic_1164.all;

entity ALU8bit is
	port
	(
		opcode : in std_logic_vector(1 downto 0); --decides which operation the ALU will execute
		a : in std_logic_vector(7 downto 0); --8 bit input 1
		b : in std_logic_vector(7 downto 0); --8 bit input 2
		result : out std_logic_vector(7 downto 0) --8 bit result
	);
end ALU8bit;

architecture behave of ALU8bit is
component full_adder is
	port
	(
		a : in std_logic; --input 1
		b : in std_logic; --input 2
		carry_in : in std_logic; --input carry
		sum : out std_logic; --sum of a and b
		carry_out : out std_logic --output carry
	);
end component;

signal b_twos: std_logic_vector(7 downto 0); --contains two's complement of input 2 (b) if subtraction operation is selected, if addition is selected, b is not changed
signal carry: std_logic_vector(8 downto 0); --contains the carrys used
signal final: std_logic_vector(7 downto 0); --final result of ALU Operation
signal equal_vector : std_logic_vector(7 downto 0) := "00000000";

begin
 
	carry(0) <= opcode(0); --If the operation is subtraction, this represents the +1 needed for coversion to two's complement
	--this section flips all bits in the second input if the subtraction operation is selected, using xor
	b_twos(0) <= b(0) xor opcode(0); 
	b_twos(1) <= b(1) xor opcode(0);
	b_twos(2) <= b(2) xor opcode(0); 
	b_twos(3) <= b(3) xor opcode(0);
	b_twos(4) <= b(4) xor opcode(0);
	b_twos(5) <= b(5) xor opcode(0);
	b_twos(6) <= b(6) xor opcode(0);
	b_twos(7) <= b(7) xor opcode(0);

	full_adder1: full_adder port map(carry_in=>carry(0),a=>a(0),b=>b_twos(0),sum=>final(0),carry_out=>carry(1));
	full_adder2: full_adder port map(carry_in=>carry(1),a=>a(1),b=>b_twos(1),sum=>final(1),carry_out=>carry(2));
	full_adder3: full_adder port map(carry_in=>carry(2),a=>a(2),b=>b_twos(2),sum=>final(2),carry_out=>carry(3));
	full_adder4: full_adder port map(carry_in=>carry(3),a=>a(3),b=>b_twos(3),sum=>final(3),carry_out=>carry(4));
	full_adder5: full_adder port map(carry_in=>carry(4),a=>a(4),b=>b_twos(4),sum=>final(4),carry_out=>carry(5));
	full_adder6: full_adder port map(carry_in=>carry(5),a=>a(5),b=>b_twos(5),sum=>final(5),carry_out=>carry(6));
	full_adder7: full_adder port map(carry_in=>carry(6),a=>a(6),b=>b_twos(6),sum=>final(6),carry_out=>carry(7));
	full_adder8: full_adder port map(carry_in=>carry(7),a=>a(7),b=>b_twos(7),sum=>final(7),carry_out=>carry(8));

	result <= final when (opcode = "00") or (opcode = "01") else a; --Outputs the result of the ALU's Operation if add or subtract is selected, otherwise the output is A

end behave;
