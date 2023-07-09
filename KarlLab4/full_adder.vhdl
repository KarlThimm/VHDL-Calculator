library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port
	(
		a : in std_logic; --input 1
		b : in std_logic; --input 2
		carry_in : in std_logic; --input carry
		sum : out std_logic; --sum of a and b
		carry_out : out std_logic --output carry
	);
end full_adder;

architecture behave of full_adder is

begin

	sum <= a xor b xor carry_in; --0 + 1 = 1, 1 + 0 = 1, 1 + 1 = 0 with a carry out, 0 + 0 with a carry = 1
	carry_out <= (a and b) or (carry_in and a) or (carry_in and b); --carry occurs when: a and b are both 1, there is carry and a OR b are 1
	
end behave;