----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2023 02:33:05 PM
-- Design Name: 
-- Module Name: exceptii - Behavioral
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

entity exceptii is
  Port (x_exponent: in std_logic_vector(8 downto 0);
        y_exponent : in std_logic_vector(8 downto 0);
        suma_exp: in std_logic_vector(8 downto 0);
        exc: in std_logic;
        Zero: out std_logic;
        Infinit: out std_logic;
        NaN: out std_logic;
        Overflow: out std_logic;
        Underflow: out std_logic
         );
end exceptii;

architecture Behavioral of exceptii is

begin
process(x_exponent,y_exponent, suma_exp)
begin
    NaN <='0';
    Zero<='0';
    Infinit<='0';
    Overflow <='0';
    Underflow <='0';
    if exc = '1' then 
        if x_exponent = "011111111" and  y_exponent = "000000000" then 
            NaN <= '1';
        elsif x_exponent = "000000000" and y_exponent = "011111111" then 
            NaN <= '1';
        elsif x_exponent = "011111111" or y_exponent = "011111111" then 
            Infinit <= '1';
        elsif x_exponent = "000000000" or y_exponent = "000000000" then 
            Zero <= '1';
        elsif suma_exp(8) = '1' then 
            if suma_exp(7) = '0' then 
                Overflow <= '1';
            else 
                Underflow <= '1';
            end if;
        end if;    
      end if;
end process;

end Behavioral;
