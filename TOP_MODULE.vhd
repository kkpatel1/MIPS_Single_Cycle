----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:12:17 10/02/2014 
-- Design Name: 
-- Module Name:    TOP_MODULE - Behavioral 
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

entity TOP_MODULE is
	port ( CLK : in STD_LOGIC;
			  Output : out STD_LOGIC_VECTOR(15 downto 0);
			  InstWrite : in STD_LOGIC;
			  InstIn : in STD_LOGIC_VECTOR(31 downto 0));
end TOP_MODULE;

architecture Structural of TOP_MODULE is
component ControlUnit
	Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Fuct : in  STD_LOGIC_VECTOR (5 downto 0);
           MemtoReg : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           ALUSrc : out  STD_LOGIC;
           RegDst : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           ALUControl : out  STD_LOGIC_VECTOR(2 downto 0);
			  CLK : in STD_LOGIC;
			  Jump : out STD_LOGIC;
			  RegOut : out STD_LOGIC;
			  InstWrite : in STD_LOGIC;
			  RegRead : out STD_LOGIC);
end component;
component ADDER
	Port ( In1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  In2 : in STD_LOGIC_VECTOR (15 downto 0);
           Out1 : out  STD_LOGIC_VECTOR (15 downto 0));
end component;
component ALU
	Port ( In1 : in  STD_LOGIC_VECTOR (15 downto 0);
           In2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           COMP : out  STD_LOGIC;
           SEL : in  STD_LOGIC_VECTOR (2 downto 0);
			  CLK: in STD_LOGIC);
end component;
component IR
	Port ( Addr : in  STD_LOGIC_VECTOR (15 downto 0);
           Inst : out  STD_LOGIC_VECTOR (31 downto 0);
			  CLK : in STD_LOGIC;
		     Wd : in  STD_LOGIC_VECTOR (31 downto 0);
		     InstWrite : in  STD_LOGIC);
end component;
component Memory
	Port ( MemWrite : in  STD_LOGIC;
			  MemRead : in STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (15 downto 0);
           Wd : in  STD_LOGIC_VECTOR (15 downto 0);
           RdOut : out  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC
			);
end component;
component PC
	Port ( NextAddr : in  STD_LOGIC_VECTOR (15 downto 0);
           CurrAddr : out  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC;
			  InstWrite : in STD_LOGIC
		  );
end component;
component REG_32x32
	Port ( RegWrite : in  STD_LOGIC;
           RdAddr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           RdAddr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           WAddr : in  STD_LOGIC_VECTOR (4 downto 0);
           Wd : in  STD_LOGIC_VECTOR (15 downto 0);
           RdOut1 : out  STD_LOGIC_VECTOR (15 downto 0);
           RdOut2 : out  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC;
			  RegRead : in STD_LOGIC
			);
end component;
component SX
	Port ( Input : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0)
			);
end component;
component OutputUnit
	Port ( Output : out STD_LOGIC_VECTOR(15 downto 0);
				RegOut : in STD_LOGIC;
				CLK : in STD_LOGIC;
				RdOut1 : in STD_LOGIC_VECTOR(15 downto 0);
				MemOut : in STD_LOGIC_VECTOR(15 downto 0));
end component;
signal NextAddr : STD_LOGIC_VECTOR(15 downto 0);
signal CurrAddr : STD_LOGIC_VECTOR(15 downto 0);
signal Inst : STD_LOGIC_VECTOR (31 downto 0);
Signal MemWrite : STD_LOGIC;
signal MemtoReg : STD_LOGIC;
signal Branch : STD_LOGIC;
signal ALUSrc : STD_LOGIC;
signal RegDst : STD_LOGIC;
signal RegWrite : STD_LOGIC;
Signal ALUControl : STD_LOGIC_VECTOR(2 downto 0);
signal Jump : STD_LOGIC;
signal RegDstOut : STD_LOGIC_VECTOR(4 downto 0);
signal RdOut1 : STD_LOGIC_VECTOR(15 downto 0);
signal RdOut2 : STD_LOGIC_VECTOR(15 downto 0);
signal ALUIn : STD_LOGIC_VECTOR(15 downto 0);
signal SXOut : STD_LOGIC_VECTOR(15 downto 0);
signal ALUOut : STD_LOGIC_VECTOR(15 downto 0);
signal COMP : STD_LOGIC;
signal MemOut : STD_LOGIC_VECTOR(15 downto 0);
signal MemtoRegOut : STD_LOGIC_VECTOR(15 downto 0);
signal PCad4 : STD_LOGIC_VECTOR(15 downto 0);
signal PCad4ad16bit : STD_LOGIC_VECTOR(15 downto 0);
signal RegOut : STD_LOGIC;
signal RegRead : STD_LOGIC;
begin
	RegDstProcess: process(CLK)
	begin
		if RegDst = '1' then
			RegDstOut <= Inst(15 downto 11);
		elsif RegDst = '0' then
			RegDstOut <= Inst(20 downto 16);
		end if;
	end process;
	ALUIn2: process(CLK)
	begin
		if ALUSrc = '0' then
			ALUIn <= RdOut2;
		elsif ALUSrc = '1' then
			ALUIn <= SXOut;
		end if;
	end process;
	Mem2Reg: process(CLK)
	begin
		if MemtoReg = '1' then
			MemtoRegOut <= MemOut;
		elsif MemtoReg = '0' then
			MemtoRegOut <= ALUOut;
		end if;
	end process;
	NextAddrCalc: process(CLK)
	begin
		if Jump = '1' then
			NextAddr <= PCAd4Ad16bit;
		elsif Branch = '1' and COMP = '1' then
			NextAddr <= PCAd4Ad16bit;
		elsif Branch ='0' or COMP = '0' then
			NextAddr <= PCad4;
		end if;
	end process;
	---Execution---
	PC1: PC port map ( NextAddr => NextAddr, CurrAddr => CurrAddr, CLK => CLK, InstWrite => InstWrite);
	IR1: IR port map ( Addr => CurrAddr, Inst => Inst, CLK => CLK, InstWrite => InstWrite, Wd => InstIn );
	CU1: ControlUnit port map ( MemtoReg => MemtoReg,
										 MemWrite => MemWrite,
										 Branch => Branch,
										 ALUSrc => ALUSrc,
										 RegDst => RegDst,
										 RegWrite => RegWrite,
										 ALUControl => ALUControl,
										 CLK => CLK,
										 Jump => Jump,
										 RegOut => RegOut,
										 OpCode => Inst(31 downto 26),
										 Fuct => Inst(5 downto 0),
										 InstWrite => InstWrite,
										 RegRead => RegRead);
	RegFile : REG_32x32 port map ( RegWrite => RegWrite,
											  RdAddr1 => Inst(25 downto 21),
											  RdAddr2 => Inst(20 downto 16),
											  WAddr => RegDstOut,
											  Wd => MemtoRegOut,
											  RdOut1 => RdOut1,
											  RdOut2 => RdOut2,
											  CLK => CLK,
											  RegRead => RegRead);
	SX1 : SX port map ( Input => Inst(15 downto 0),
								Output => SXOut);
	ALU1 : ALU port map ( In1 => RdOut1,
								  In2 => ALUIn,
								  Output => ALUOut,
								  COMP => COMP,
								  SEL => ALUControl,
								  CLK => CLK);
	MEM: Memory port map ( MemWrite => MemWrite,
								  MemRead => '1',
								  Addr => ALUOut,
								  Wd => RdOut2,
								  RdOut => MemOut,
								  CLK => CLK);
	Output1: OutputUnit port map (RegOut => RegOut, MemOut => MemOut, RdOut1 => RdOut1, Output => Output, CLK => CLK);
	---Fetch---
	PCadd4: Adder port map ( In1 => CurrAddr, In2 => x"0001", Out1 => PCad4 );
	PCadd4add16bit: Adder port map (In1 => PCad4, In2 => Inst(15 downto 0), Out1 => PCad4ad16bit);
end Structural;

