----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OutputUnit is
    Port ( RegOut : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           RdOut1 : in  STD_LOGIC_VECTOR (15 downto 0);
           MemOut : in  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC);
end OutputUnit;

architecture Behavioral of OutputUnit is
begin
	Output <= RdOut1 when RegOut = '1' else
				 MemOut when RegOut = '0';
end Behavioral;

