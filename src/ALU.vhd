----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kartik Patel
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

entity ALU is
    Port ( In1 : in  STD_LOGIC_VECTOR (15 downto 0);
           In2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           COMP : out  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (2 downto 0);
			  CLK : in STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
shared variable count : std_logic_vector(1 downto 0) := "00";
begin
	process(CLK, SEL, In1, In2)
	begin
		if count = "00" then
			if SEL = "000" then
				Output <= In1 and In2;
			elsif SEL = "001" then
				Output <= In1 or In2;
			elsif SEL = "010" then
				Output <= In1 + In2;
			elsif SEL = "110" then
				Output <= In1 + not(In2) + 1;
			elsif SEL = "111" then
				if In1 < In2 then
					Output <= X"0001";
				else
					Output <= X"0000";
				end if;
			end if;
			count := count + 1;
		elsif count = "01" then
			count := "00";
		else 
			count := count + 1;
		end if;
	end process;
	COMP <= '0' when In1 = In2 else
				'1';
end Behavioral;