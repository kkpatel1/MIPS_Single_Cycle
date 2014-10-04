----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:20:56 10/02/2014 
-- Design Name: 
-- Module Name:    IR - Behavioral 
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
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IR is
    Port ( Addr : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst : out  STD_LOGIC_VECTOR (31 downto 0);
			  CLK : in STD_LOGIC;
			  Wd : in  STD_LOGIC_VECTOR (31 downto 0);
			  InstWrite : in  STD_LOGIC);
end IR;

architecture Behavioral of IR is
type registerFile is array(0 to 65535) of STD_LOGIC_VECTOR (31 downto 0);
signal registers : registerFile;
begin
	process(InstWrite, Wd, Addr)
	begin
		if InstWrite = '1' then
			registers(to_integer(unsigned(Addr(15 downto 0)))) <= Wd;
		elsif InstWrite = '0' then
			Inst <= registers(to_integer(unsigned(Addr(15 downto 0))));
		end if;
	end process;
end Behavioral;