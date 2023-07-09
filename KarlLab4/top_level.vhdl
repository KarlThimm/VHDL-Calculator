library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
    Port ( input : in std_logic_vector(7 downto 0);
		   clk : in std_logic;
		   output : out std_logic_vector(7 downto 0)
		   );
end top_level;

architecture Behavioral of top_level is

component calculator is
port
	(
		clk : in std_logic;
		instruction : in std_logic_vector(7 downto 0); --opcode input
		print : out std_logic_vector(7 downto 0) --printing output
	);
end component;

signal btn : std_logic;

signal inputt : std_logic_vector(7 downto 0);
signal outputt : std_logic_vector(7 downto 0);

begin

inputt <= input; 
calc : calculator port map (clk => clk, instruction => inputt, print => outputt);
output <= outputt;


end Behavioral;