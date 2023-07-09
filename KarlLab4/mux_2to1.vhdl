library ieee;
use ieee.std_logic_1164.all;

entity mux_2to1 is
	port
	(
		load_int: in std_logic_vector(7 downto 0);
		ALU_Output: in std_logic_vector(7 downto 0);
		sel: in std_logic_vector(1 downto 0); 
		wd: out std_logic_vector(7 downto 0)
	);
end mux_2to1;

architecture behave of mux_2to1 is
begin 
	with sel select
		wd <= ALU_Output when "00",
			  ALU_Output when "01",
			  load_int when "10",
			  ALU_Output when "11",
			  ALU_Output when others;
end architecture behave;