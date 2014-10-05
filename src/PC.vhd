----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kartik Patel
-- 
-- Create Date:    00:37:57 10/01/2014 
-- Design Name: 
-- Module Name:    REG_32x32 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port ( NextAddr : in  STD_LOGIC_VECTOR (15 downto 0);
           CurrAddr : out  STD_LOGIC_VECTOR (15 downto 0) := x"0000";
			  CLK : in STD_LOGIC;
			  InstWrite : in STD_LOGIC
			);
end PC;

architecture Behavioral of PC is
shared variable count : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
	process(CLK, InstWrite)
	begin
		if falling_edge(InstWrite) then
			CurrAddr <= x"0000";
		elsif rising_edge(CLK) then
			if count = "11" then
				count := "00";
				CurrAddr <= NextAddr;
			end if;
			count := count + 1;			
		end if;
	end process;
end Behavioral;