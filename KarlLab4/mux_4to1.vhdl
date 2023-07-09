library ieee;
use ieee.std_logic_1164.all;

entity mux_4to1 is
	port
	(
		input_vector: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(1 downto 0); 
		rd: out std_logic_vector(7 downto 0)
	);
end mux_4to1;

architecture behave of mux_4to1 is
begin 
	with sel select
		rd <= input_vector(7 downto 0) when "00",
			 input_vector(15 downto 8) when "01",
			 input_vector(23 downto 16) when "10",
			 input_vector(31 downto 24) when "11",
			 input_vector(7 downto 0) when others;
end architecture behave;