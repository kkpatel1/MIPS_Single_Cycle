--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.2i
--  \   \         Application : ISE
--  /   /         Filename : ADDER_TBW.vhw
-- /___/   /\     Timestamp : Fri Oct 03 14:15:16 2014
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: ADDER_TBW
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE STD.TEXTIO.ALL;

ENTITY ADDER_TBW IS
END ADDER_TBW;

ARCHITECTURE testbench_arch OF ADDER_TBW IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT ADDER
        PORT (
            In1 : In std_logic_vector (31 DownTo 0);
            In2 : In std_logic_vector (31 DownTo 0);
            Out1 : Out std_logic_vector (31 DownTo 0)
        );
    END COMPONENT;

    SIGNAL In1 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL In2 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL Out1 : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    BEGIN
        UUT : ADDER
        PORT MAP (
            In1 => In1,
            In2 => In2,
            Out1 => Out1
        );

        PROCESS
            PROCEDURE CHECK_Out1(
                next_Out1 : std_logic_vector (31 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (Out1 /= next_Out1) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns Out1="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, Out1);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_Out1);
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
                In2 <= "00000000000000000000000000000101";
                -- -------------------------------------
                -- -------------  Current Time:  150ns
                WAIT FOR 50 ns;
                CHECK_Out1("00000000000000000000000000000101", 150);
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 150 ns;
                In1 <= "00000000000000001111111111110100";
                -- -------------------------------------
                -- -------------  Current Time:  350ns
                WAIT FOR 50 ns;
                CHECK_Out1("00000000000000001111111111111001", 350);
                -- -------------------------------------
                -- -------------  Current Time:  500ns
                WAIT FOR 150 ns;
                In1 <= "00000000000000001111111111110101";
                -- -------------------------------------
                -- -------------  Current Time:  550ns
                WAIT FOR 50 ns;
                CHECK_Out1("00000000000000001111111111111010", 550);
                WAIT FOR 450 ns;

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

