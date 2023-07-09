library ieee;
use ieee.std_logic_1164.all;

entity controller is
	port
	(
		opcode_input : in std_logic_vector(1 downto 0); --opcode input
		write_enable : out std_logic; 
		ALU_Opcode : out std_logic_vector(1 downto 0); 
		print_enable : out std_logic
	);
end controller;

architecture behave of controller is
begin 
	process(opcode_input)
	begin
		if(opcode_input = "11") then
			write_enable <= '0';
		elsif(opcode_input ="10") then
			write_enable <= '1';
		else
		    write_enable <= '1';
		end if;
		
		if(opcode_input = "00") then
			ALU_Opcode <= "00"; --adding
		elsif (opcode_input = "01") then
			ALU_Opcode <= "01"; --subtracting
		else 
			ALU_Opcode <= "11"; --nothing?
		end if;
		
		if(opcode_input = "11") then
			print_enable <= '1';
		else
			print_enable <= '0';
		end if;
	end process;
	
end architecture behave;