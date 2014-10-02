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
-- use IEEE.STD_LOGIC_ARITH.ALL;
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( RdAddr : in  STD_LOGIC_VECTOR (4 downto 0);
           WAddr : in  STD_LOGIC_VECTOR (4 downto 0);
           Wd : in  STD_LOGIC_VECTOR (31 downto 0);
			  PCWrite : in STD_LOGIC_VECTOR (4 downto 0);
           RdOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  CLK : in STD_LOGIC
			);
end PC;

architecture Behavioral of PC is
type registerFile is array(0 to 4) of STD_LOGIC_VECTOR (4 downto 0);
signal registers : registerFile;
begin
	p1: process(CLK)
	begin
		if rising_edge(CLK) then
			RdOut <= registers(to_integer(unsigned(RdAddr)));
		end if;
	end process;
	Write: process(CLK)
	begin
		if rising_edge(CLK) then
			if PCWrite = '1' then
				registers(to_integer(unsigned(WAddr))) <= Wd;
			end if;
		end if;
	end process;
end Behavioral;

