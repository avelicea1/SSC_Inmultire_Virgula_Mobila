library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FourBitRegister is
Port (REG_IN  :  in std_logic_vector(31 downto 0);
        LD : in std_logic;
        Shift: in std_logic;
        Bit_in : in std_logic_vector(3 downto 0);
        CLK  : in std_logic;
        Rst: in std_logic;
        REG_OUT : out std_logic_vector(31 downto 0));
end FourBitRegister;

architecture Behavioral of FourBitRegister is
signal temp: std_logic_vector(31 downto 0):=x"00000000";
begin
 process(Clk)
    begin
        if (rising_edge(CLK)) then
            if Rst = '1' then 
                temp <= x"00000000";
            else 
                if LD = '1' then 
                    temp <= REG_IN;
                elsif Shift = '1' then 
                    temp <= temp(27 downto 0) & Bit_in;
                end if;
             end if;
        end if;
    end process;
REG_OUT <= temp;
end Behavioral;