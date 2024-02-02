----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 02:36:24 PM
-- Design Name: 
-- Module Name: sumator - Behavioral
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

entity sumator is
Port (   A : in std_logic_vector (8 downto 0);
         B : in std_logic_vector (8 downto 0);
         op: in std_logic;
         Sum: out std_logic_vector (8 downto 0);
         Carry: out std_logic);
end sumator;

architecture Behavioral of sumator is

signal temp_sum: std_logic_vector(8 downto 0) := "000000000";
signal temp_carry : std_logic_vector(9 downto 0) := "0000000000";
signal temp_B: std_logic_vector(8 downto 0) := "000000000";




begin

    g1: for i in 0 to 8 generate
        temp_B(i) <= B(i) xor op;
    end generate g1;
    temp_carry(0) <= op;
    g2: for i in 0 to 8 generate
        temp_sum(i) <= A(i) xor temp_B(i) xor temp_carry(i);
        temp_carry(i+1) <= (A(i) and temp_B(i)) or ((A(i) xor temp_B(i)) and temp_carry(i));
    end generate g2;   

    Sum <= temp_sum;
    Carry <= temp_carry(9);
    
end Behavioral;
