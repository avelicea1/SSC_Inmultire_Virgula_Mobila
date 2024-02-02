----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2023 01:45:32 PM
-- Design Name: 
-- Module Name: PmodKYPD - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PmodKYPD is
 Port ( 
	Clk : in  STD_LOGIC;
	Rst : in std_logic;
	
	Start: in std_logic; --start operatie
	LoadX: in std_logic; --incarca X
	LoadY: in std_logic; --incarca Y
	Shift : in std_logic; --incarca val PMODKYPD
	
	Sel: in std_logic_vector(2 downto 0);
	
	JA : inout  STD_LOGIC_VECTOR (7 downto 0); 
	
 	An : out  STD_LOGIC_VECTOR (3 downto 0);   
    Seg : out  STD_LOGIC_VECTOR (7 downto 0);
    
	Zero: out std_logic;
    Infinit: out std_logic;
    NaN: out std_logic;
    Overflow: out std_logic;
    Underflow: out std_logic;
	
	Decode: out std_logic_vector(3 downto 0);
    Finish: out std_logic
	);
end PmodKYPD;

architecture Behavioral of PmodKYPD is

signal Decode_out: STD_LOGIC_VECTOR (3 downto 0) := "0000"; 

signal X : std_logic_vector(31 downto 0) := (others => '0');
signal Y : std_logic_vector(31 downto 0) := (others => '0');
signal Z : std_logic_vector(31 downto 0) := (others => '0');

signal Result : std_logic_vector(31 downto 0) := (others => '0');
signal LoadX_Out: std_logic;
signal LoadY_Out: std_logic;
signal Start_Out: std_logic;
signal Shift_Out: std_logic;
signal Finish_temp: std_logic:='0';
signal Zero_s, Infinit_s, NaN_s : std_logic :='0';
signal Overflow_s, Underflow_s: std_logic:='0';

begin
    dec : entity WORK.keypad_decoder
	port map(
		Clk => Clk,
		Row => JA(7 downto 4),
		Col => JA(3 downto 0),
		DecodeOut => Decode_out
	);
	
	Decode <= Decode_out;
	
	Start_debounce :entity WORK.debouncer
	port map(
		Clk => Clk,
		Rst => Rst,
		D_IN => Start,
		Q_OUT => Start_Out
	);
	LoadX_debounce :entity WORK.debouncer
	port map(
		Clk => Clk,
		Rst => Rst,
		D_IN => LoadX,
		Q_OUT => LoadX_Out
	);
	LoadY_debounce :entity WORK.debouncer
	port map(
		Clk => Clk,
		Rst => Rst,
		D_IN => LoadY,
		Q_OUT => LoadY_Out
	);
	Shift_debounce :entity WORK.debouncer
	port map(
		Clk => Clk,
		Rst => Rst,
		D_IN => Shift,
		Q_OUT => Shift_Out
	);
	reg:entity work.FourBitRegister port map(
	    REG_IN => x"00000000",
        LD => '0',
        Shift => Shift_Out,
        Bit_in => Decode_out,
        CLK  => Clk,
        Rst=> Rst,
        REG_OUT => Result
        );
    reg_x:entity work.FourBitRegister port map(
	    REG_IN => Result,
        LD => LoadX_Out,
        Shift => '0',
        Bit_in => "0000",
        CLK  => Clk,
        Rst=> '0',
        REG_OUT => X
        );
    reg_y:entity work.FourBitRegister port map(
	    REG_IN => Result,
        LD => LoadY_Out,
        Shift => '0',
        Bit_in => "0000",
        CLK  => Clk,
        Rst=> '0',
        REG_OUT => Y
        );
    mul : entity WORK.main
	port map(
		x_exponent => '0' & X(30 downto 23),
		y_exponent => '0' & Y(30 downto 23),
        x_semn => X(31),
        y_semn => Y(31),
        x_mantisa => "01" &  X(22 downto 0),
        y_mantisa => "01" & Y(22 downto 0),
        Clk => Clk,
        Rst => Rst,
        Start => Start_Out,
        Z => Z,
        Finish => Finish_temp,
        Zero_out => Zero_s,
        Infinit_out => Infinit_s,
        NaN_out => NaN_s,
        Overflow_out => Overflow_s,
        Underflow_out => Underflow_s
	);
	
	Finish <= Finish_temp;
	Zero <= Zero_s;
	Infinit <= Infinit_s;
	NaN <= NaN_s;
	Overflow <= Overflow_s;
	Underflow <= Underflow_s;
	
	dsp : entity WORK.displ7seg
	port map(
		Clk => Clk,
		Rst => Rst,
		Data => X,
		Data1 => Y,
		Data2 => Z,
		Data3 => Result,
		Sel => Sel,
		Finish => Finish_temp,
		An => An,
		Seg => Seg
	);

end Behavioral;
