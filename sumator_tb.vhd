----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 02:38:18 PM
-- Design Name: 
-- Module Name: sumator_tb - Behavioral
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

entity sumator_tb is
--  Port ( );
end sumator_tb;

architecture Behavioral of sumator_tb is
constant CLK_PERIOD: time := 10 ns;
signal Clk,Rst,Start: std_logic:='0';

signal x_exponent,y_exponent :std_logic_vector(8 downto 0):=(others => '0');
signal x_semn, y_semn: std_logic:='0';
signal x_mantisa, y_mantisa: std_logic_vector(24 downto 0):=(others => '0');
signal z: std_logic_vector(31 downto 0);
signal Finish: std_logic:='0';
signal Zero_out,Infinit_out, NaN_out, Overflow_out, Underflow_out : std_logic:='0';
begin

Dut: entity work.main port map(x_exponent,y_exponent,x_semn,y_semn,x_mantisa,y_mantisa,Clk,Rst,Start,z, Finish,Zero_out,Infinit_out, NaN_out, Overflow_out, Underflow_out );  
gen_clk: process
        begin
        Clk<='1';
        wait for CLK_PERIOD/2;
        Clk<='0';
        wait for CLK_PERIOD/2;
        end process;
process
begin 
--       x_semn <='0'; --14.0
--       y_semn <='0'; --84.0
--       x_exponent <= '0' & "10000010";
--       y_exponent <= '0' & "10000101";
--       x_mantisa <= "01" & "11000000000000000000000";
--       y_mantisa <= "01" & "01010000000000000000000";
--       Start <= '1';
--       Rst <= '0';
       --1176 "01000100100100110000000000000000"  0x44930000
       x_semn <='0'; -- 102.5
       y_semn <='1'; -- -12.0
       x_exponent <= '0' & "10000101";
       y_exponent <= '0' & "10000010"; 
       x_mantisa <= "01" & "10011010000000000000000";
       y_mantisa <= "01" & "10000000000000000000000";
       Start <= '1';
       Rst <= '0';
       
    wait for CLK_PERIOD *2;
end process;

end Behavioral;
