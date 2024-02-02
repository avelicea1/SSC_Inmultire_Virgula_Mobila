----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 06:43:17 PM
-- Design Name: 
-- Module Name: ADDN - Behavioral
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDN is
    generic (n: natural);
    Port (x: in std_logic_vector(n-1 downto 0);
          y: in std_logic_vector(n-1 downto 0);
          Tin: in std_logic;
          S: out std_logic_vector(n-1 downto 0);
          Tout: out std_logic;
          OVF: out std_logic);
end ADDN;

architecture Behavioral of ADDN is
signal suma : std_logic_vector(n downto 0):=(others => '0');
signal x_0 : std_logic_vector(n downto 0):=(others => '0');
begin
    x_0<='0'&x;
    suma <= x_0 + y + Tin;
    Tout <= suma(n);
    OVF <= suma(n) xor suma(n-1);
    S<=suma(n-1 downto 0);
end Behavioral;
