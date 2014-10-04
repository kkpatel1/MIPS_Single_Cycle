----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:07:22 10/02/2014 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Fuct : in  STD_LOGIC_VECTOR (5 downto 0);
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ALUControl : out  STD_LOGIC_VECTOR(2 downto 0);
			  Jump : out STD_LOGIC;
			  CLK : in STD_LOGIC;
			  RegOut : out STD_LOGIC;
			  InstWrite : in STD_LOGIC;
			  RegRead : out STD_LOGIC);
end ControlUnit;

architecture Behavioral of ControlUnit is
shared variable count : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
	Main : process(OpCode, InstWrite)
	begin
		if InstWrite = '1' then
			Branch <= '0';
			Jump <= '0';
	--	RType: process(CLK)
		elsif OpCode = "000000" then
			if Fuct = "000000" then
				ALUControl <= "010";
			elsif Fuct = "000001" then
				ALUControl <= "110";
			elsif Fuct = "000010" then
				ALUControl <= "000";
			elsif Fuct = "000011" then
				ALUControl <= "001";
			elsif Fuct = "000100" then
				ALUControl <= "111";
			end if;
			RegDst <= '1';
			ALUSrc <= '0';
			MemWrite <= '0';
			MemtoReg <= '0';
			Branch <= '0';
			Jump <= '0';
			if count = "00" then
				RegRead <= '1';
				count := count + 1;
			elsif count = "01" then
				RegWrite <= '1';
				count := "00";
			end if;
--			end if;
--		end if;
--	end process;
--	LW: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "100011" then
			MemtoReg <= '1';
			MemWrite <= '0';
			Branch <= '0';
			ALUSrc <= '1';
			RegDst <= '0';
			Jump <= '0';
			ALUControl <= "010";
			if count = "00" then
				RegRead <= '1';
				count := count + 1;
			elsif count = "01" then
				RegWrite <= '1';
				count := "00";
			end if;
--			end if;
--		end if;
--	end process;
--	SW: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "101011" then
			MemWrite <= '1';
			Branch <= '0';
			ALUSrc <= '1';
			RegWrite <= '0';
			Jump <= '0';
			ALUControl <= "010";
			RegRead <= '1';
--			end if;
--		end if;
--	end process;
--	Beq: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "000100" then
			MemWrite <= '0';
			Branch <= '1';
			ALUSrc <= '0';
			RegWrite <= '0';
			Jump <= '0';
			RegRead <= '1';
--			end if;
--		end if;
--	end process;
--	J: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "000101" then 
			MemWrite <= '0';
			RegWrite <= '0';
			Jump <= '1';
			RegRead <= '0';
--			end if;
--		end if;
--	end process;
--	AddImmediate: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "001000" then
			MemtoReg <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUSrc <= '1';
			RegDst <= '0';
			ALUControl <= "010";
			Jump <= '0';
			if count = "00" then
				RegRead <= '1';
				count := count + 1;
			elsif count = "01" then
				RegWrite <= '1';
				count := "00";
			end if;
--			end if;
--		end if;
--	end process;
--	PrintReg: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "111111" then
			ALUSrc <= '0';
			MemWrite <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			Branch <= '0';
			Jump <= '0';
			RegOut <= '1';
			RegRead <= '1';
--			end if;
--		end if;
--	end process;
--	PrintMem: process(CLK)
--	begin
--		if rising_edge(CLK) then
		elsif OpCode = "111110" then
			MemtoReg <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUSrc <= '1';
			RegWrite <= '0';
			Jump <= '0';
			RegOut <= '0';
			RegRead <= '1';
	---LoadImmediate : LDI
	end process;	
end Behavioral;