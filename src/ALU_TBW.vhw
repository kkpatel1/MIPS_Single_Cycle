--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.2i
--  \   \         Application : ISE
--  /   /         Filename : ALU_TBW.vhw
-- /___/   /\     Timestamp : Thu Oct 02 15:48:27 2014
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ALU_TBW
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY ALU_TBW IS
END ALU_TBW;

ARCHITECTURE testbench_arch OF ALU_TBW IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT ALU
        PORT (
            In1 : In std_logic_vector (31 DownTo 0);
            In2 : In std_logic_vector (31 DownTo 0);
            Output : Out std_logic_vector (31 DownTo 0);
            COMP : Out std_logic;
            SEL : In std_logic_vector (2 DownTo 0)
        );
    END COMPONENT;

    SIGNAL In1 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL In2 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL Output : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL COMP : std_logic := '1';
    SIGNAL SEL : std_logic_vector (2 DownTo 0) := "000";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : ALU
        PORT MAP (
            In1 => In1,
            In2 => In2,
            Output => Output,
            COMP => COMP,
            SEL => SEL
        );

        PROCESS
            PROCEDURE CHECK_COMP(
                next_COMP : std_logic;
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (COMP /= next_COMP) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns COMP="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, COMP);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_COMP);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            PROCEDURE CHECK_Output(
                next_Output : std_logic_vector (31 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (Output /= next_Output) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns Output="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, Output);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_Output);
                    STD.TEXTIO.write(TX_LOC, string'(" "));
                    TX_STR(TX_LOC.all'range) := TX_LOC.all;
                    STD.TEXTIO.writeline(RESULTS, TX_LOC);
                    STD.TEXTIO.Deallocate(TX_LOC);
                    ASSERT (FALSE) REPORT TX_STR SEVERITY ERROR;
                    TX_ERROR := TX_ERROR + 1;
                END IF;
            END;
            BEGIN
                -- -------------  Current Time:  100ns
                WAIT FOR 100 ns;
                In1 <= "00000000000000000000000000000011";
                In2 <= "00000000000000000000000000000110";
                SEL <= "010";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 50 ns;
                CHECK_COMP('0', 150);
                CHECK_Output("00000000000000000000000000001001", 150);
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 150 ns;
                SEL <= "001";
                -- -------------------------------------
                -- -------------  Current Time:  350ns
                WAIT FOR 50 ns;
                CHECK_Output("00000000000000000000000000000111", 350);
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 150 ns;
                SEL <= "111";
                -- -------------------------------------
                -- -------------  Current Time:  550ns
                WAIT FOR 50 ns;
                CHECK_Output("00000000000000000000000000000001", 550);
                -- -------------------------------------
                -- -------------  Current Time:  600ns
                WAIT FOR 50 ns;
                SEL <= "110";
                -- -------------------------------------
                -- -------------  Current Time:  650ns
                WAIT FOR 50 ns;
                CHECK_Output("11111111111111111111111111111101", 650);
                -- -------------------------------------
                -- -------------  Current Time:  800ns
                WAIT FOR 150 ns;
                SEL <= "000";
                -- -------------------------------------
                -- -------------  Current Time:  850ns
                WAIT FOR 50 ns;
                CHECK_Output("00000000000000000000000000000010", 850);
                WAIT FOR 150 ns;

                IF (TX_ERROR = 0) THEN
                    STD.TEXTIO.write(TX_OUT, string'("No errors or warnings"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT
                      "Simulation successful (not a failure).  No problems detected."
                      SEVERITY FAILURE;
                ELSE
                    STD.TEXTIO.write(TX_OUT, TX_ERROR);
                    STD.TEXTIO.write(TX_OUT,
                        string'(" errors found in simulation"));
                    STD.TEXTIO.writeline(RESULTS, TX_OUT);
                    ASSERT (FALSE) REPORT "Errors found during simulation"
                         SEVERITY FAILURE;
                END IF;
            END PROCESS;

    END testbench_arch;

