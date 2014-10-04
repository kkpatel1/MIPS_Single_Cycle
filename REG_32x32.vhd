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

entity REG_32x32 is
    Port ( RegWrite : in  STD_LOGIC;
			  RegRead : in STD_LOGIC;
           RdAddr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RdAddr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           WAddr : in  STD_LOGIC_VECTOR (4 downto 0);
           Wd : in  STD_LOGIC_VECTOR (15 downto 0);
           RdOut1 : out  STD_LOGIC_VECTOR (15 downto 0);
           RdOut2 : out  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC
			);
end REG_32x32;

architecture Behavioral of REG_32x32 is
type registerFile is array(0 to 31) of STD_LOGIC_VECTOR (15 downto 0);
signal registers : registerFile := (others => (others => '0'));
begin
	read : process(CLK)
	begin
		if rising_edge(CLK) then
				if RegWrite = '1' and RegRead = '1' then
					if WAddr = RdAddr1 then
						RdOut1 <= Wd;
						registers(to_integer(unsigned(WAddr))) <= Wd;
					end if;
					if WAddr = RdAddr2 then
						RdOut2 <= Wd;
						registers(to_integer(unsigned(WAddr))) <= Wd;
					end if;
				elsif RegWrite = '1' then
					registers(to_integer(unsigned(WAddr))) <= Wd;
				elsif RegRead = '1' then
					RdOut1 <= registers(to_integer(unsigned(RdAddr1)));
					RdOut2 <= registers(to_integer(unsigned(RdAddr2)));
				end if;
		end if;
	end process;
end Behavioral;

