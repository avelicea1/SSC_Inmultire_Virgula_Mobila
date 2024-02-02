----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 02:59:12 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
    Port (Clk: in std_logic;
        Rst: in std_logic;
        Start: in std_logic;
        Zero: in std_logic;
        Infinit: in std_logic;
        Nan : in std_logic;
        Overflow: in std_logic;
        Underflow: in std_logic;
        Term: in std_logic;
        Norm: in std_logic;
        Start_Booth: out std_logic;
        Load : out std_logic;
        op: out std_logic;
        selectie_mux1: out std_logic;
        Shift: out std_logic;
        Load_r: out std_logic;
        exc: out std_logic;
        selectie_mux2: out std_logic_vector(1 downto 0);
        Finish: out std_logic);
end Control;

architecture Behavioral of Control is

type TIP_STARE is (START_Stare, VERIFICARE1, ADUNA_EXP, SCADE_DEPLS, VERIFICARE2, INMULTIRE_MAN, ASTEPTARE,INIT, VERIFICARE3, NORMALIZARE,VERIFICARE4,ROTUNJIRE, SEMN, STOP, EXCEPTIE);
signal STARE: TIP_STARE;

begin

process(Clk)
begin
    if rising_edge(Clk) then 
            if Rst = '1' then
                STARE<=START_Stare;
            else
                case STARE is
                    when START_Stare => if Start = '1' then 
                                            STARE <= VERIFICARE1;
                                        end if;
                    when VERIFICARE1 => if Zero = '1' or Infinit = '1' or NaN = '1' then 
                                            STARE <= EXCEPTIE;
                                        else STARE <= ADUNA_EXP;                                                                                       
                                        end if;
                    when ADUNA_EXP => STARE <= SCADE_DEPLS; 
                    when SCADE_DEPLS => STARE <= VERIFICARE2;
                    when VERIFICARE2 => if Overflow = '1' or Underflow = '1' then 
                                            STARE <= EXCEPTIE;
                                        else STARE <= INMULTIRE_MAN;
                                        end if;
                    when INMULTIRE_MAN => STARE <= ASTEPTARE;
                    when ASTEPTARE => if Term = '1' then 
                                            STARE <= INIT;
                                      else 
                                            STARE <= ASTEPTARE;
                                      end if;
                    when INIT => STARE <= VERIFICARE3;
                    when VERIFICARE3 =>if Norm = '0' then 
                                            STARE <= NORMALIZARE;
                                        else STARE <= ROTUNJIRE;
                                        end if;
                    when NORMALIZARE => STARE <= VERIFICARE4;
                    when VERIFICARE4 => if Underflow = '1' and Overflow = '1' then 
                                            STARE <= EXCEPTIE;
                                        else STARE <= VERIFICARE3;
                                        end if;
                    when EXCEPTIE => STARE <= STOP;
                    when ROTUNJIRE => STARE <= SEMN;
                    when SEMN => STARE <= STOP;
                    when STOP => STARE <= STOP;
                end case;
             end if;
         end if;
end process;
process(STARE)
begin
    Finish <='0';
    case STARE is
        when START_Stare => Start_Booth <= '0'; Load <= '0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';
        when VERIFICARE1 => Start_Booth <= '0'; Load <= '0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='1';
        when ADUNA_EXP => Start_Booth <= '0'; Load <= '1';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';
        when SCADE_DEPLS => Start_Booth <= '0'; Load<='1';op<='1';selectie_mux1 <= '1'; selectie_mux2 <="01";exc<='0';
        when VERIFICARE2 => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='1';
        when INMULTIRE_MAN =>Start_Booth <= '1'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';
        when ASTEPTARE => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';
        when VERIFICARE3 => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";Shift <= '0';Load_r <='0';exc<='0';
        when INIT => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";Shift <= '0'; Load_r <='1';exc<='0';
        when NORMALIZARE => Start_Booth <= '0'; Load<='1';op<='0';selectie_mux1 <='1';selectie_mux2<="10";Shift <= '1';Load_r <='0';exc<='0';
        when VERIFICARE4 =>Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";Shift <= '0';Load_r <='0';exc<='0';
        when ROTUNJIRE => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';
        when SEMN => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';
        when STOP => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='0';Finish <='1';
        when EXCEPTIE => Start_Booth <= '0'; Load<='0';op<='0';selectie_mux1 <='0';selectie_mux2<="00";exc<='1';
    end case;
end process;

end Behavioral;
