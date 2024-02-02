----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 07:23:40 PM
-- Design Name: 
-- Module Name: Booth - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Booth is
  generic(n:natural);
  Port (Clk: in std_logic;
        Rst: in std_logic;
        Start: in std_logic;
        x: in std_logic_vector(n-1 downto 0);
        y: in std_logic_vector(n-1 downto 0);
        A: out std_logic_vector(n-1 downto 0);
        Q: out std_logic_vector(n-1 downto 0);
        Term: out std_logic);
end Booth;

architecture Behavioral of Booth is
signal Q0Qm1:  std_logic_vector(1 downto 0);
signal RstA:  std_logic;
signal SubB:  std_logic;
signal LoadB:  std_logic;
signal LoadA:  std_logic;
signal SHRAQ: std_logic;
signal RstQm1:  std_logic;
signal LoadQ:  std_logic;
signal FDN_OUT: std_logic_vector(n-1 downto 0);
signal XOR_OUT: std_logic_vector(n-1 downto 0);
signal Q_A: std_logic_vector(n-1 downto 0);
signal S_Q: std_logic_vector(n-1 downto 0);
signal Tout: std_logic;
signal OVF: std_logic;
signal Q_A_Q: std_logic_vector(N-1 downto 0);
signal Q_FD: std_logic;
begin
dut: eNTITY work.uc generic map (n=>n) port map(Start,Q0Qm1,Clk,Rst,RstA,SubB,LoadB, LoadA,SHRAQ,RstQm1,LoadQ,Term);
l1: Entity WORK.FDN GENERIC map (n=>n) port map (x, LoadB,Clk,Rst, FDN_OUT);
l2: for i in 0 to n-1 generate 
        XOR_OUT(i)<= FDN_OUT(i) xor SubB;
    end generate;
l3: Entity WORK.ADDN generic map (n=>n) port map (XOR_OUT,Q_A, SubB,S_Q,Tout, OVF);
l4: Entity WORK.SRRN generic map (n=> n) port map (S_Q, Q_A(n-1),LoadA,SHRAQ,Clk,RstA,Q_A);
L5: Entity WORK.SRRN generic map (n=> n) port map(y, Q_A(0),LoadQ,SHRAQ,Clk,Rst,Q_A_Q);
L6: entity work.FD port map (Q_A_Q(0), SHRAQ, Clk, Rst,Q_FD);

Q0Qm1<= Q_A_Q(0) & Q_FD;
A<=Q_A;
Q<=Q_A_Q;
end Behavioral;
