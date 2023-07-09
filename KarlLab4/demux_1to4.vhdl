library ieee;
use ieee.std_logic_1164.all;

entity demux_1to4 is
	port
	(
		we: in std_logic;
		sel: in std_logic_vector(1 downto 0);
		output_we: out std_logic_vector(3 downto 0) := (others => '0')
	);
end demux_1to4;

architecture behave of demux_1to4 is
begin
	process(sel, we)
	begin
	output_we <= "0000";
		case sel is
			when "00" => output_we(0) <= we;
			when "01" => output_we(1) <= we;
			when "10" => output_we(2) <= we;
			when "11" => output_we(3) <= we;
			when others => output_we(0) <= we;
		end case;
end process;
end architecture behave;