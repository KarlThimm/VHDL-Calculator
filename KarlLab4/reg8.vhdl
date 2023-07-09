library ieee;
use ieee.std_logic_1164.all;

entity reg8 is
	port (  
		clk, we : in std_logic;
		d : in std_logic_vector (7 downto 0);
		q : out std_logic_vector (7 downto 0) := "00000000"
	);
end entity reg8;

architecture behave of reg8 is

begin
reg8_process: process (clk, we, d)
	begin
		if rising_edge(clk) then
			if we = '1' then
				q <= d;
			end if;
		end if;
	end process reg8_process;
end architecture behave;