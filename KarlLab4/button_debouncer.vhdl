----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2022 12:30:56 PM
-- Design Name: 
-- Module Name: button_debounce - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_debouncer is
    Port ( btn_data : in STD_LOGIC;
           clk : in STD_LOGIC;
           db_data : out STD_LOGIC);
end button_debouncer;

architecture Behavioral of button_debouncer is

constant period : std_logic_vector := "00000000000000110001011000010101"; -- around 164 Hz

Signal sig1, sig2, sig3: std_logic;

signal one_sixty_four_hz : std_logic;
signal timer_ctrl : std_logic_vector(31 downto 0);
 
begin
 
process(clk)
begin
    if(rising_edge(clk)) then
        case timer_ctrl is
            when period =>
                timer_ctrl <= (others => '0');
                one_sixty_four_hz <= not one_sixty_four_hz;
             
            when others => timer_ctrl <= timer_ctrl + "1";
        end case;
     end if;
end process;
        
 
Process(one_sixty_four_hz)
begin
    If rising_edge(one_sixty_four_hz) then
        sig1 <= btn_data;
        sig2 <= sig1;
        sig3 <= sig2;
    end if;
end process;
 
db_data <= sig1 and sig2 and (not sig3);
 
end Behavioral;
