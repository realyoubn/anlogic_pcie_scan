----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:21:25 06/27/2012 
-- Design Name: 
-- Module Name:    SYNC_ASYNC_RST - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SYNC_ASYNC_RST is
    Port ( RST,RST_CACHE : in  STD_LOGIC;
           CLK_IN : in  STD_LOGIC;
           RST_N, CACHE_RST : out  STD_LOGIC);
end SYNC_ASYNC_RST;

ARCHITECTURE BEHAVIOR OF SYNC_ASYNC_RST IS
signal REG_RST_N,REG_RST_R                        : STD_LOGIC;
BEGIN
PROCESS(RST,CLK_IN)
BEGIN
	IF RST = '0' THEN
		REG_RST_N <= '0';
	ELSIF CLK_IN'EVENT AND CLK_IN = '1' THEN
		REG_RST_N <= '1';
	END IF;
END PROCESS;
PROCESS(RST_CACHE,CLK_IN)
BEGIN
	IF RST_CACHE = '0' THEN
		REG_RST_R <= '0';
	ELSIF CLK_IN'EVENT AND CLK_IN = '1' THEN
		REG_RST_R <= '1';
	END IF;
END PROCESS;
PROCESS(RST_CACHE,CLK_IN)
BEGIN
	IF RST_CACHE = '0' THEN
		CACHE_RST <= '0';
	ELSIF CLK_IN'EVENT AND CLK_IN = '1' THEN
		CACHE_RST <= REG_RST_R;
	END IF;
END PROCESS;
PROCESS(RST,CLK_IN)
BEGIN
	IF RST = '0' THEN
		RST_N <= '0';
	ELSIF CLK_IN'EVENT AND CLK_IN = '1' THEN
		RST_N <= REG_RST_N;
	END IF;
END PROCESS;

END BEHAVIOR;
