LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY ADConfig IS
PORT
(
	RST,CLK_SYSTEM								:	IN		STD_LOGIC;
    EN_ADC_CFG  								:	IN		STD_LOGIC;
    ADC_CFG_DATA                                :   IN      STD_LOGIC_VECTOR(31 DOWNTO 0);
	SCK,SEN,SDI									:	OUT	STD_LOGIC
);
END ADConfig;

ARCHITECTURE ADConfig OF ADConfig IS
SIGNAL		CNT_SCK							:	STD_LOGIC_VECTOR(7 DOWNTO 0) := X"00";
SIGNAL		CNT_SEN							:	STD_LOGIC_VECTOR(7 DOWNTO 0) := X"00";
SIGNAL		CNT_REG_BIT,CNT_REG_BYTE	    :	STD_LOGIC_VECTOR(7 DOWNTO 0) := X"00";
SIGNAL		REG_SCK,REG_SEN          		:	STD_LOGIC := '0';
SIGNAL      REG_SDI                         :   STD_LOGIC_VECTOR(14 DOWNTO 0);

SIGNAL		DELAY						    :	STD_LOGIC_VECTOR(23 DOWNTO 0):= X"000000";

SIGNAL		REG_DATA					    :	STD_LOGIC_VECTOR(14 DOWNTO 0):= "000010000000000";--SOFTRESET
SIGNAL		RGB								:	STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

SIGNAL		CASE_MAIN						:	STD_LOGIC_VECTOR(7 DOWNTO 0) := X"00";

BEGIN

PROCESS(RST,CLK_SYSTEM)
BEGIN
	IF RST = '0' THEN
		CNT_SCK <= X"00";
		CNT_SEN <= X"00";
		CNT_REG_BIT <= X"00";
		CNT_REG_BYTE <= X"00";
		REG_SCK <= '0';
		REG_SEN <= '0';
		DELAY <= X"000000";
		REG_DATA <= "000010000000000";--SOFTRESET
		CASE_MAIN <= X"00";
	ELSIF CLK_SYSTEM'EVENT AND CLK_SYSTEM = '1' THEN
		CASE CASE_MAIN IS
			WHEN X"00" =>
				--IF DELAY = X"0249F000" THEN--??200ms,??AD????????????
				IF DELAY = X"1F000" THEN--??200ms,??AD????????????
					DELAY <= X"000000";
					REG_DATA <= "000010000000000";--SOFTRESET
					REG_SCK <= '0';
					REG_SEN <= '0';
					CNT_SCK <= X"00";
					CNT_REG_BIT	<= X"00";
					CNT_REG_BYTE <= X"00";
					CASE_MAIN <= X"01";
				ELSE
					DELAY <= DELAY + 1;
					CASE_MAIN <= X"00";
				END IF;
			WHEN X"01" =>
				IF CNT_SCK = X"23" THEN
					IF CNT_REG_BIT = 14 THEN
						IF CNT_SEN = X"3B" THEN
							CASE CNT_REG_BYTE IS
								WHEN X"00" =>
									REG_DATA <= "000000100110001";--REG1
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"01";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"01" =>
									REG_DATA <= "000001000110001";--REG2(8bit-parallel,ADC input range = 1.2V )
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"02";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"02" =>
									REG_DATA <= "000001100010001";--REG3 (V(RLC)) 0.8V
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"03";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"03" =>
									REG_DATA <= "000011000000000";--REG4
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"04";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"04" =>
									REG_DATA <= "000011100000000";--REG5(Vref,in or out)
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"05";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"05" =>
									REG_DATA <= "000100000000000";--REG6
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"06";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"06" =>
									REG_DATA <= "010001100000000";--DAC RGB 44mV
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"07";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"07" =>
									REG_DATA <= "010101100000001";--PGA_MSB RGB A = 1
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"08";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"08" =>
									REG_DATA <= "010011100000000";--PGA_LSB RGB
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"0C";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
                               
                               WHEN X"0B" =>
									REG_DATA <= '0' & ADC_CFG_DATA(27 downto 14);--CFG_FROM SW
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"0C";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"01";
								WHEN X"0C" =>
									REG_SCK <= '0';
									CNT_SCK <= X"00";
									CNT_REG_BIT <= X"00";
									CNT_REG_BYTE <= X"0D";
									CNT_SEN <= X"00";
									CASE_MAIN <= X"02";
								WHEN OTHERS => NULL;
							END CASE;
						ELSIF CNT_SEN = X"27" THEN
							REG_SEN <= '0';
							CNT_SEN <= CNT_SEN + 1;
							CASE_MAIN <= X"01";
						ELSIF CNT_SEN = X"13" THEN
							REG_SEN <= '1';
							CNT_SEN <= CNT_SEN + 1;
							CASE_MAIN <= X"01";
						ELSE
							CNT_SEN <= CNT_SEN + 1;
							CASE_MAIN <= X"01";
						END IF;
					ELSE
						REG_SCK <= '1';
						CNT_REG_BIT <= CNT_REG_BIT + 1;
						CNT_SCK <= X"00";
						CASE_MAIN <= X"01";
					END IF;
				ELSIF CNT_SCK = X"11" THEN
					REG_DATA <= REG_DATA(13 downto 0) & '0';
					REG_SCK <= '0';
					CNT_SCK <= CNT_SCK + 1;
					CASE_MAIN <= X"01";
				ELSE
					CNT_SCK <= CNT_SCK + 1;
					CASE_MAIN <= X"01";
				END IF;
			WHEN X"02" =>
                IF EN_ADC_CFG = '1' THEN
					CNT_REG_BYTE <= X"0B";
   	                REG_DATA <= '0' &  ADC_CFG_DATA(13 downto 0);--CFG_FROM SW
				    CNT_SCK <= X"00";
				    CNT_REG_BIT <= X"00";
				    CNT_SEN <= X"00";
				    CASE_MAIN <= X"01";
                ELSE
				    CASE_MAIN <= X"02";

                END IF;
			WHEN OTHERS => NULL;
		END CASE;
	END IF;
END PROCESS;




SCK <= REG_SCK;
SEN <= REG_SEN;
SDI <= REG_DATA(14);

END ADConfig;
