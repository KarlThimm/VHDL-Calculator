library ieee;
use ieee.std_logic_1164.all;

entity reg8n4 is
	port (  
		clk, we : in std_logic;
		rs1, rs2 : in std_logic_vector(1 downto 0);	
		ws : in std_logic_vector (1 downto 0);
		wd : in std_logic_vector(7 downto 0);
		rd1,rd2 : out std_logic_vector (7 downto 0)
	);
end entity reg8n4;

architecture structural of reg8n4 is
 
component reg8 is
	port (  
		clk, we : in std_logic;
		d : in std_logic_vector (7 downto 0);
		q : out std_logic_vector (7 downto 0) := "00000000"
	);
end component;

component demux_1to4 is
	port
	(
		we: in std_logic;
		sel: in std_logic_vector(1 downto 0);
		output_we: out std_logic_vector(3 downto 0) := (others => '0')
	);
end component; 

component mux_4to1 
	port
	(
		input_vector: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(1 downto 0);
		rd: out std_logic_vector(7 downto 0)
	);
end component;

signal we_vector : std_logic_vector(3 downto 0) := (others => '0');
signal output_vector : std_logic_vector(31 downto 0):= (others => '0');

begin
	
	demux : demux_1to4 port map (we => we, sel => ws, output_we => we_vector);
	mux1 : mux_4to1 port map (input_vector => output_vector, sel => rs1, rd => rd1);
	mux2 : mux_4to1 port map (input_vector => output_vector, sel => rs2, rd => rd2);

	reg_1: reg8 port map (d => wd, clk => clk, we => we_vector(0), q => output_vector(7 downto 0));
	reg_2: reg8 port map (d => wd, clk => clk, we => we_vector(1), q => output_vector(15 downto 8));
	reg_3: reg8 port map (d => wd, clk => clk, we => we_vector(2), q => output_vector(23 downto 16));
	reg_4: reg8 port map (d => wd, clk => clk, we => we_vector(3), q => output_vector(31 downto 24));
	
end architecture structural;