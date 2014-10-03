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
    Port ( NextAddr : in  STD_LOGIC_VECTOR (31 downto 0);
           CurrAddr : out  STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
			  CLK : in STD_LOGIC;
			  InstWrite : in STD_LOGIC
			);
end PC;

architecture Behavioral of PC is
shared variable count : std_logic_vector(0 to 1) := "00";
signal readPoint : std_logic_vector(31 downto 0) := x"00000000";
signal writePoint: std_logic_vector(31 downto 0) := x"00000000";
signal InstWriteCheck : std_logic_vector(1 downto 0) := "00";-- 0 when constant; 1 for rising; 2 for falling
begin
--	p2: process(InstWrite, CLK)
--	begin
--		if rising_edge(InstWrite) then
--			InstWriteCheck <= "01";
--		elsif falling_edge(InstWrite) then
--			InstWriteCheck <= "10";
--		else 
--			InstWriteCheck <= "00";
--		end if;
--	end process;
	p1: process(CLK)
	begin
		if rising_edge(CLK) then
			if InstWrite = '0' then
				if nextAddr = writePoint then
					if nextAddr = ReadPoint then
						CurrAddr <= (others => 'X');
					else
						CurrAddr <= ReadPoint;
						count := "00";
					end if;
				end if;
				count := count + 1;
				if count = "10" then
					CurrAddr <= NextAddr;
					ReadPoint <= nextAddr;
					count := "00";
				end if;				----Works like a simple DFF Array
			elsif InstWrite = '1' then
				if NextAddr = ReadPoint then
					CurrAddr <= writePoint;
					count := "00";
				else
					count := count + 1;
					if count = "10" then
						CurrAddr <= NextAddr;
						writePoint <= nextAddr;
						count := "00";
					end if;
				end if;
			end if;
		end if;
	end process;







--	p1: process(CLK)
--	begin
--		if rising_edge(CLK) then
--			if InstWrite = '0' then
--				count := count + 1;
--				if count = "11" then
--					CurrAddr <= NextAddr;
----					ReadPoint <= NextAddr;
--					count := "00";
--				end if;				----Works like a simple DFF Array
--			elsif InstWrite = '1' then
----				writePoint <= NextAddr;
--				CurrAddr <= NextAddr;
--			end if;
--		end if;
--	end process;





end Behavioral;

