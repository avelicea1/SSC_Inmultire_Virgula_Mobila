------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 12/13/2023 07:43:17 PM
---- Design Name: 
---- Module Name: Normalizare - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
----use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity Normalizare is
----  Port ( );
--end Normalizare;

--architecture Behavioral of Normalizare is

--begin
--z_mantisa <= A_OUT(23 downto 0) when Term = '1' else z_mantisa; 
           
--normalizare: process(z_mantisa, Term)
--    begin  
--        if z_mantisa(23) = '1' then 
--             Norm <='0';
--        else 
--             Norm <='1';
--            z_mantisa <= z_mantisa(22 downto 0) & Q_OUT(23);
--            Q_OUT <= Q_OUT(22 downto 0) & '0';
--        end if; 
--    end process;

--end Behavioral;
