----------------------------------------------------------------------------------
-- Company:         UTCN 
-- Engineer: 
-- 
-- Create Date:     02/04/2016 10:12:56 AM
-- Design Name:     displ7seg
-- Module Name:     displ7seg - Behavioral
-- Project Name: 
-- Target Devices:  Nexys4 DDR (xc7a100tcsg324-1)
-- Tool Versions:   Vivado 2015.4, Vivado 2016.4
-- Description:     Multiplexor pentru afisajul cu 7 segmente
--                  Datele de la intrare se interpreteaza ca valori hexazecimale 
--                  si sunt decodificate in configuratia segmentelor afisajului
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity displ7seg is
    Port ( Clk  : in  STD_LOGIC;
           Rst  : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);   -- datele pentru 8 cifre (cifra 1 din stanga: biti 31..28)
           Data1: in std_logic_vector(31 downto 0);
           Data2: in std_logic_vector(31 downto 0);
           Data3: in std_logic_vector(31 downto 0);
           Sel  : in std_logic_vector(2 downto 0);
           Finish : in std_logic;
           An   : out STD_LOGIC_VECTOR (3 downto 0);    -- selectia anodului activ
           Seg  : out STD_LOGIC_VECTOR (7 downto 0));   -- selectia catozilor (segmentelor) cifrei active
end displ7seg;

architecture Behavioral of displ7seg is

constant CNT_100HZ : integer := 2**20;                  -- divizor pentru rata de reimprospatare de ~100 Hz (cu un ceas de 100 MHz)
signal Num         : integer range 0 to CNT_100HZ - 1 := 0;
signal NumV        : STD_LOGIC_VECTOR (19 downto 0) := (others => '0');    
signal LedSel      : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
signal Hex         : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin

-- Proces pentru divizarea ceasului
divclk: process (Clk)
    begin
    if (Clk'event and Clk = '1') then
        if (Rst = '1') then
            Num <= 0;
        elsif (Num = CNT_100HZ - 1) then
            Num <= 0;
        else
            Num <= Num + 1;
        end if;
    end if;
    end process;

    NumV <= CONV_STD_LOGIC_VECTOR (Num, 20);
    LedSel <= NumV (19 downto 18);

-- Selectia anodului activ
    An <= "1110" when LedSel = "00" else
          "1101" when LedSel = "01" else
          "1011" when LedSel = "10" else
          "0111" when LedSel = "11" else
          "1111";

-- Selectia cifrei active
    process(Sel)
    begin 
            if Sel = "001" then 
                case LedSel is
                    when "00" => Hex <= Data (3  downto  0);
                    when "01" => Hex <= Data (7  downto  4);
                    when "10" => Hex <= Data (11 downto  8);
                    when "11" => Hex <= Data (15 downto 12);
                end case;
            elsif Sel = "000" then 
                case LedSel is 
                    when "00" => Hex <= Data (19 downto 16);
                    when "01" => Hex <= Data (23 downto 20);
                    when "10" => Hex <= Data (27 downto 24);
                    when "11" => Hex <= Data (31 downto 28);
                end case;
            elsif Sel = "010" then 
                case LedSel is 
                    when "00" => Hex <= Data1 (3  downto  0);
                    when "01" => Hex <= Data1 (7  downto  4);
                    when "10" => Hex <= Data1 (11 downto  8);
                    when "11" => Hex <= Data1 (15 downto 12);
                 end case;
            elsif Sel = "011" then 
                case LedSel is 
                    when "00" => Hex <= Data1 (19 downto 16);
                    when "01" => Hex <= Data1 (23 downto 20);
                    when "10" => Hex <= Data1 (27 downto 24);
                    when "11" => Hex <= Data1 (31 downto 28);
                end case;
            elsif Sel = "100" then 
                if Finish = '1' then 
                     case LedSel is
                        when "00" => Hex <= Data2 (3  downto  0);
                        when "01" => Hex <= Data2 (7  downto  4);
                        when "10" => Hex <= Data2 (11 downto  8);
                        when "11" => Hex <= Data2 (15 downto 12);
                    end case;
                end if;
            elsif Sel = "101" then   
                if Finish = '1' then 
                     case LedSel is 
                        when "00" => Hex <= Data2 (19 downto 16);
                        when "01" => Hex <= Data2 (23 downto 20);
                        when "10" => Hex <= Data2 (27 downto 24);
                        when "11" => Hex <= Data2 (31 downto 28);
                    end case;
                end if;
            elsif Sel = "110" then 
                case LedSel is 
                    when "00" => Hex <= Data3 (3  downto  0);
                    when "01" => Hex <= Data3 (7  downto  4);
                    when "10" => Hex <= Data3 (11 downto  8);
                    when "11" => Hex <= Data3 (15 downto 12);
                 end case;
             elsif Sel = "111" then 
                case LedSel is 
                    when "00" => Hex <= Data3 (19 downto 16);
                    when "01" => Hex <= Data3 (23 downto 20);
                    when "10" => Hex <= Data3 (27 downto 24);
                    when "11" => Hex <= Data3 (31 downto 28);
                end case;
            end if;
    end process;

-- Activarea/dezactivarea segmentelor cifrei active
    Seg <= "11111001" when Hex = "0001" else            -- 1
           "10100100" when Hex = "0010" else            -- 2
           "10110000" when Hex = "0011" else            -- 3
           "10011001" when Hex = "0100" else            -- 4
           "10010010" when Hex = "0101" else            -- 5
           "10000010" when Hex = "0110" else            -- 6
           "11111000" when Hex = "0111" else            -- 7
           "10000000" when Hex = "1000" else            -- 8
           "10010000" when Hex = "1001" else            -- 9
           "10001000" when Hex = "1010" else            -- A
           "10000011" when Hex = "1011" else            -- b
           "11000110" when Hex = "1100" else            -- C
           "10100001" when Hex = "1101" else            -- d
           "10000110" when Hex = "1110" else            -- E
           "10001110" when Hex = "1111" else            -- F
           "11000000";                                  -- 0

end Behavioral;
