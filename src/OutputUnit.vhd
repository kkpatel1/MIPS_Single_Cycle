----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kartik Patel
-- 
-- Create Date:    16:04:01 10/04/2014 
-- Design Name: 
-- Module Name:    OutputUnit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OutputUnit is
    Port ( RegOut : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           RdOut1 : in  STD_LOGIC_VECTOR (15 downto 0);
           MemOut : in  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC);
end OutputUnit;

architecture Behavioral of OutputUnit is
begin
	process(CLK)
	begin
		if rising_edge(CLK) then
			if RegOut = '0' then
				Output <= MemOut;
			elsif RegOut = '1' then
				Output <= RdOut1;
			end if;
		end if;
	end process;
end Behavioral;

