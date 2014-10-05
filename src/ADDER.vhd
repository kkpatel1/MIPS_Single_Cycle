----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kartik Patel
-- 
-- Create Date:    15:16:39 10/02/2014 
-- Design Name: 
-- Module Name:    ADDER - Behavioral 
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

entity ADDER is
    Port ( In1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In2 : in STD_LOGIC_VECTOR (15 downto 0);
           Out1 : out  STD_LOGIC_VECTOR (15 downto 0));
end ADDER;

architecture Behavioral of ADDER is

begin
	process(In1, In2)
	begin	
		Out1 <= In1 + In2;
	end process;

end Behavioral;

