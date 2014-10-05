----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kartik Patel
-- 
-- Create Date:    09:22:06 10/02/2014 
-- Design Nae: 
-- Module Name:    SX - Behavioral 
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
use IEEE.NUMERIC_STD.all;

-- Just a single bus : No use in 16-bit MIPS.

entity SX is
    Port ( Input : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0)
			);
end SX;

architecture Behavioral of SX is
begin
	Output <= Input;
end Behavioral;