----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 02:42:27 PM
-- Design Name: 
-- Module Name: registru - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registru is
  Port (REG_IN  :  in std_logic_vector(8 downto 0);
        LD : in std_logic;
        CLK  : in std_logic;
        Rst: in std_logic;
        REG_OUT : out std_logic_vector(8 downto 0));
end registru;

architecture Behavioral of registru is

begin

    process(Clk)
    begin
        if (rising_edge(CLK)) then
            if (LD = '1') then
                REG_OUT <= REG_IN;
            elsif Rst = '1' then 
                REG_OUT <= "000000000";
            end if;
        end if;
    end process;

end Behavioral;
