----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:24:38 10/02/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( In1 : in  STD_LOGIC_VECTOR (31 downto 0);
           In2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           COMP : out  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (2 downto 0));
end ALU;

architecture Behavioral of ALU is

begin
	process(SEL, In1, In2)
	begin
		if SEL = "000" then
			Output <= In1 and In2;
		elsif SEL = "001" then
			Output <= In1 or In2;
		elsif SEL = "010" then
			Output <= In1 + In2;
		elsif SEL = "110" then
			Output <= In1 + not(In2) + 1;
		--TODO -- SLT?
		elsif SEL = "111" then
			if In1 < In2 then
				Output <= X"00000001";
			else
				Output <= X"00000000";
			end if;
		end if;
	end process;
	COMP <= '1' when In1 = In2 else
				'0';
end Behavioral;

