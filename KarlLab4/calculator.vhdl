library STD;                       
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity calculator is
	port
	(
		clk : in std_logic;
		instruction : in std_logic_vector(7 downto 0); --opcode input
		print : out std_logic_vector(7 downto 0) --printing output
	);
end calculator;

architecture behave of calculator is

component controller is
port
	(
		opcode_input : in std_logic_vector(1 downto 0); --opcode input
		write_enable : out std_logic; 
		ALU_Opcode : out std_logic_vector(1 downto 0); 
		print_enable : out std_logic
	);
end component;

component ALU8bit is
	port
	(
		opcode : in std_logic_vector(1 downto 0); --decides which operation the ALU will execute
		a : in std_logic_vector(7 downto 0); --8 bit input 1
		b : in std_logic_vector(7 downto 0); --8 bit input 2
		result : out std_logic_vector(7 downto 0) --8 bit result
	);
end component;

component reg8n4 is
	port (  
		clk, we : in std_logic;
		rs1, rs2 : in std_logic_vector(1 downto 0);	
		ws : in std_logic_vector (1 downto 0);
		wd : in std_logic_vector(7 downto 0);
		rd1,rd2 : out std_logic_vector (7 downto 0)
	);
end component;

component mux_2to1 is
	port
	(
		load_int: in std_logic_vector(7 downto 0);
		ALU_Output: in std_logic_vector(7 downto 0);
		sel: in std_logic_vector(1 downto 0); 
		wd: out std_logic_vector(7 downto 0)
	);
end component;

signal write_enable : std_logic := '0';
signal ALU_Opcode : std_logic_vector(1 downto 0);
signal print_enable : std_logic := '0';

signal rd11 : std_logic_vector(7 downto 0);
signal rd22 : std_logic_vector(7 downto 0);

signal ALU_Output : std_logic_vector(7 downto 0);
signal load_or_ALU : std_logic_vector(7 downto 0);

signal sign_extender: std_logic_vector(7 downto 0);


begin
	
	sign_extender <= std_logic_vector(resize(signed(instruction(5 downto 2)), sign_extender'length));

	mux_2to11 : mux_2to1 port map (load_int=>sign_extender,
								   ALU_Output=>ALU_Output,
								   sel=>instruction(7 downto 6),
								   wd=>load_or_ALU);
	
	controller1: controller port map (opcode_input => instruction(7 downto 6), 
									  write_enable => write_enable, 
									  ALU_Opcode => ALU_Opcode, 
									  print_enable => print_enable);
									  
	reg8n41: reg8n4 port map (clk=>clk, 
								 we=>write_enable, 
								 rs1=>instruction(5 downto 4), 
								 rs2=>instruction(3 downto 2),
								 ws=>instruction(1 downto 0),
								 wd=>load_or_ALU,
								 rd1=> rd11,
								 rd2=> rd22);
								 
	ALU8bit1 : ALU8bit port map (opcode=>ALU_Opcode,
								 a=>rd11,
								 b=>rd22,
								 result=>ALU_Output);
								 
	with print_enable select
		print <= ALU_Output when '1', 
				 "00000000" when '0',
			     "00000000" when others;
	
	
	process(instruction)
	begin
		if(print_enable = '1') then
			report integer'image(to_integer(signed(ALU_Output)));
		end if;
	end process;
end behave;