----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 06:50:26 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
  generic (n: natural);
  Port (Start: in std_logic;
        Q0Qm1: in std_logic_vector(1 downto 0);
        Clk: in std_logic;
        Rst: in std_logic;
        RstA: out std_logic;
        SubB: out std_logic;
        LoadB: out std_logic;
        LoadA: out std_logic;
        SHRAQ: out std_logic;
        RstQm1: out std_logic;
        LoadQ: out std_logic;
        Term: out std_logic
         );
end UC;

architecture Behavioral of UC is
type TIP_STARE is (START1, INIT, CONDITIE, SUB, ADD, SHIFT, DECC, COND2, STOP);
signal STARE: TIP_STARE;
signal c : natural := n;
begin
    process (Clk,Rst,STARE)
    begin
        if rising_edge(Clk) then 
            if Rst = '1' then
                STARE<=START1;
            else
                case STARE is
                    when START1 => if Start = '1' then STARE<=INIT;
                                   end if;
                    when INIT => STARE<= CONDITIE;
                                 c<=n;
                    when CONDITIE =>if Q0Qm1 = "01" then 
                                       STARE<=ADD;
                                    elsif Q0Qm1 = "10" then 
                                        STARE<=SUB;
                                    else STARE<= SHIFT;
                                    end if;
                    when SUB => STARE <= SHIFT;
                    when ADD => STARE <= SHIFT;
                    when SHIFT => STARE <= DECC;
                    when DECC => STARE <= COND2; 
                                 c <= c - 1;
                    when COND2 => if c = 0 then 
                                     STARE<= STOP;
                                  else STARE<=CONDITIE;
                                  end if;
                    when STOP =>STARE <= STOP;
                end case;
            end if;
         end if;
    end process;
    process (STARE)
    begin
        case STARE is 
            when START1 => RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='0'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='0';
            when INIT => RstA <='1'; SubB<='0'; LoadB <='1'; LoadA <='0'; SHRAQ<='0'; RstQm1<='1';LoadQ<='1';Term<='0';
            when CONDITIE =>RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='0'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='0';
            when SUB => RstA <='0'; SubB<='1'; LoadB <='0'; LoadA <='1'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='0';
            when ADD => RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='1'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='0';
            when SHIFT => RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='0'; SHRAQ<='1'; RstQm1<='0';LoadQ<='0';Term<='0';
            when DECC => RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='0'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='0';
            when COND2 => RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='0'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='0';
            when STOP =>RstA <='0'; SubB<='0'; LoadB <='0'; LoadA <='0'; SHRAQ<='0'; RstQm1<='0';LoadQ<='0';Term<='1';
        end case;
    end process;
   
end Behavioral;
