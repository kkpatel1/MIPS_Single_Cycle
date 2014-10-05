--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 8.2i
--  \   \         Application : ISE
--  /   /         Filename : PC_TBW.vhw
-- /___/   /\     Timestamp : Sat Oct 04 12:27:17 2014
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: PC_TBW
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE STD.TEXTIO.ALL;

ENTITY PC_TBW IS
END PC_TBW;

ARCHITECTURE testbench_arch OF PC_TBW IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT PC
        PORT (
            NextAddr : In std_logic_vector (31 DownTo 0);
            CurrAddr : Out std_logic_vector (31 DownTo 0);
            CLK : In std_logic;
            InstWrite : In std_logic
        );
    END COMPONENT;

    SIGNAL NextAddr : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL CurrAddr : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";
    SIGNAL CLK : std_logic := '0';
    SIGNAL InstWrite : std_logic := '0';

    SHARED VARIABLE TX_ERROR : INTEGER := 0;
    SHARED VARIABLE TX_OUT : LINE;

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : PC
        PORT MAP (
            NextAddr => NextAddr,
            CurrAddr => CurrAddr,
            CLK => CLK,
            InstWrite => InstWrite
        );

        PROCESS    -- clock process for CLK
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                CLK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                CLK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            PROCEDURE CHECK_CurrAddr(
                next_CurrAddr : std_logic_vector (31 DownTo 0);
                TX_TIME : INTEGER
            ) IS
                VARIABLE TX_STR : String(1 to 4096);
                VARIABLE TX_LOC : LINE;
                BEGIN
                IF (CurrAddr /= next_CurrAddr) THEN
                    STD.TEXTIO.write(TX_LOC, string'("Error at time="));
                    STD.TEXTIO.write(TX_LOC, TX_TIME);
                    STD.TEXTIO.write(TX_LOC, string'("ns CurrAddr="));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, CurrAddr);
                    STD.TEXTIO.write(TX_LOC, string'(", Expected = "));
                    IEEE.STD_LOGIC_TEXTIO.write(TX_LOC, next_CurrAddr);
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
                NextAddr <= "00000000000000000000000000000001";
                -- -------------------------------------
                -- -------------  Current Time:  300ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000001", 300);
                -- -------------------------------------
                -- -------------  Current Time:  1100ns
                WAIT FOR 800 ns;
                InstWrite <= '1';
                CHECK_CurrAddr("00000000000000000000000000000000", 1100);
                -- -------------------------------------
                -- -------------  Current Time:  1300ns
                WAIT FOR 200 ns;
                NextAddr <= "00000000000000000000000000000010";
                -- -------------------------------------
                -- -------------  Current Time:  1500ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000010", 1500);
                -- -------------------------------------
                -- -------------  Current Time:  2900ns
                WAIT FOR 1400 ns;
                NextAddr <= "00000000000000000000000000000011";
                -- -------------------------------------
                -- -------------  Current Time:  3100ns
                WAIT FOR 200 ns;
                InstWrite <= '0';
                CHECK_CurrAddr("00000000000000000000000000000001", 3100);
                -- -------------------------------------
                -- -------------  Current Time:  3500ns
                WAIT FOR 400 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 3500);
                -- -------------------------------------
                -- -------------  Current Time:  4300ns
                WAIT FOR 800 ns;
                NextAddr <= "00000000000000000000000000000100";
                -- -------------------------------------
                -- -------------  Current Time:  4900ns
                WAIT FOR 600 ns;
                InstWrite <= '1';
                CHECK_CurrAddr("00000000000000000000000000000011", 4900);
                -- -------------------------------------
                -- -------------  Current Time:  5100ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 5100);
                -- -------------------------------------
                -- -------------  Current Time:  7100ns
                WAIT FOR 2000 ns;
                InstWrite <= '0';
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 7100);
                -- -------------------------------------
                -- -------------  Current Time:  7300ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 7300);
                -- -------------------------------------
                -- -------------  Current Time:  7500ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 7500);
                -- -------------------------------------
                -- -------------  Current Time:  7700ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 7700);
                -- -------------------------------------
                -- -------------  Current Time:  7900ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 7900);
                -- -------------------------------------
                -- -------------  Current Time:  8100ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 8100);
                -- -------------------------------------
                -- -------------  Current Time:  8300ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 8300);
                -- -------------------------------------
                -- -------------  Current Time:  8500ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 8500);
                -- -------------------------------------
                -- -------------  Current Time:  8700ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 8700);
                -- -------------------------------------
                -- -------------  Current Time:  8900ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 8900);
                -- -------------------------------------
                -- -------------  Current Time:  9100ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 9100);
                -- -------------------------------------
                -- -------------  Current Time:  9300ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 9300);
                -- -------------------------------------
                -- -------------  Current Time:  9500ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", 9500);
                -- -------------------------------------
                -- -------------  Current Time:  9700ns
                WAIT FOR 200 ns;
                CHECK_CurrAddr("00000000000000000000000000000100", 9700);
                -- -------------------------------------
                WAIT FOR 500 ns;

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

