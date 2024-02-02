----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 06:36:22 PM
-- Design Name: 
-- Module Name: SRRN - Behavioral
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

entity SRRN is
  generic (n: natural);
  Port (D: in std_logic_vector(n-1 downto 0);
        SRI: in std_logic;
        Load: in std_logic;
        CE: in std_logic;
        Clk: in std_logic;
        Rst: in std_logic;
        Q: out std_logic_vector(n-1 downto 0));
end SRRN;

architecture Behavioral of SRRN is
signal Q_temp: std_logic_vector(n-1 downto 0):=(others =>'0');
begin
    process(Clk, Rst, CE,Load)
    begin
        if rising_edge(Clk) then 
            if Rst = '1' then
                Q_temp<= (others => '0');
            elsif Load = '1' then 
                Q_temp<=D;
            elsif CE = '1' then 
                Q_temp<=SRI & Q_temp(n-1 downto 1);
            end if;
        end if; 
    end process;
    Q <= Q_temp;
end Behavioral;
