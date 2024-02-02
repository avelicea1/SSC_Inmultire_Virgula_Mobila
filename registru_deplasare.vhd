----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2023 07:44:10 PM
-- Design Name: 
-- Module Name: registru_deplasare - Behavioral
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

entity registru_deplasare is
Port (REG_IN  :  in std_logic_vector(23 downto 0);
        LD : in std_logic;
        Shift: in std_logic;
        Bit_in : in std_logic;
        CLK  : in std_logic;
        Rst: in std_logic;
        Norm: out std_logic;
        Bit_out: out std_logic;
        REG_OUT : out std_logic_vector(23 downto 0));
end registru_deplasare;

architecture Behavioral of registru_deplasare is
signal temp: std_logic_vector(23 downto 0):=x"000000" ;
signal temp_out : std_logic := '0';
begin
 process(Clk)
    begin
        if (rising_edge(CLK)) then
            if Rst = '1' then 
                temp <= x"000000" ;
            else 
                if LD = '1' then 
                    temp <= REG_IN;
                elsif Shift = '1' then 
                    temp <= temp(22 downto 0) & Bit_in;
                    temp_out <= temp (23);
                end if;
             end if;
        end if;
    end process;
Norm <= temp (23);
REG_OUT <= temp;
Bit_out <= temp_out;
end Behavioral;
