----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 03:48:18 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
  Port (x_exponent,y_exponent: in std_logic_vector(8 downto 0);
        x_semn, y_semn: in std_logic;
        x_mantisa, y_mantisa: in std_logic_vector(24 downto 0);
        Clk: in std_logic;
        Rst: in std_logic;
        Start: in std_logic;
        Z: out std_logic_vector(31 downto 0);
        Finish: out std_logic;
        Zero_out: out std_logic;
        Infinit_out: out std_logic;
        NaN_out: out std_logic;
        Overflow_out: out std_logic;
        Underflow_out: out std_logic
        );
end main;

architecture Behavioral of main is

signal semn: std_logic :='0';

--control
signal Zero, Infinit, NaN: std_logic :='0';
signal Overflow, Underflow: std_logic:='0';
signal Term, Norm : std_logic:='0';

--control out 
signal Start_Booth, Load,op: std_logic :='0';
signal Selectie_mux1: std_logic;
signal Selectie_mux2 : std_logic_vector(1 downto 0);
signal Load_r, Shift, exc: std_logic :='0';
signal Finish_s: std_logic :='0';

signal Carry : std_logic :='0';
signal iesire_mux1, iesire_mux2,Reg_Out,Sum: std_logic_vector(8 downto 0);
signal z_mantisa: std_logic_vector(23 downto 0) := (others => '0'); 

signal A_OUT, Q_OUT: std_logic_vector(24 downto 0) := (others => '0');
signal Bit_inA, Bit_inQ: std_logic :='0';
signal Bit_outA, Bit_outQ: std_logic :='0';
signal temp: std_logic_vector(23 downto 0) := (others => '0');
signal norm_q : std_logic := '0';

signal ok: std_logic :='1';
begin

semn <= x_semn xor y_semn;

process(Selectie_mux1)
begin 
    if Selectie_mux1 = '0' then 
        iesire_mux1 <= x_exponent;
    else
        iesire_mux1 <= Reg_Out;
    end if;
end process;

process(Selectie_mux2)
begin 
    if Selectie_mux2 = "00" then 
        iesire_mux2 <= y_exponent;
    elsif Selectie_mux2 = "01" then 
        iesire_mux2 <= "001111111";
    elsif Selectie_mux2 = "10" then 
        iesire_mux2 <= "000000001";
    end if;
end process;

sumator: entity work.sumator port map (iesire_mux1,iesire_mux2,op,Sum, Carry);
registru: Entity work.registru port map(Sum,Load,Clk,Rst,Reg_Out);
control: Entity work.Control port map(Clk, Rst, Start, Zero, Infinit, NaN, Overflow,Underflow,Term,Norm,Start_Booth,Load,op,Selectie_mux1,Shift, Load_r,exc, Selectie_mux2,Finish_s);
inmultire: Entity work.Booth generic map (n => 25) 
    port map (Clk => Clk,
                Rst => Rst,
                Start => Start_Booth,
                x => x_mantisa,
                y => y_mantisa,
                A => A_out,
                Q => Q_out,
                Term => Term);
reg_a: entity work.registru_deplasare port map(REG_IN => A_OUT(23 downto 0),
        LD => Load_r,
        Shift => Shift,
        Bit_in => Bit_outQ,
        CLK  => Clk,
        Rst => Rst,
        Norm => Norm,
        Bit_out => Bit_outA,
        REG_OUT => z_mantisa);
reg_q: entity work.registru_deplasare port map(REG_IN => Q_OUT(24 downto 1),
        LD => Load_r,
        Shift => Shift,
        Bit_in => Bit_inQ,
        CLK  => Clk,
        Rst => Rst,
        Norm => norm_q,
        Bit_out => Bit_outQ,
        REG_OUT => temp);
exceptii: entity work.exceptii port map(x_exponent, y_exponent, Reg_Out,exc, Zero, Infinit, NaN, Overflow,Underflow);
    Zero_out <= Zero;
	Infinit_out <= Infinit;
	NaN_out <= NaN;
	Overflow_out <= Overflow;
	Underflow_out <= Underflow;
process(Finish_s)
begin 
    if Finish_s = '1' then 
        z(31) <= semn;
        z(30 downto 23) <= Reg_Out(7 downto 0);
        z(22 downto 0) <= z_mantisa(22 downto 0); 
    else 
        z <= x"00000000";
    end if;
end process;
Finish <= Finish_s;
end Behavioral;
