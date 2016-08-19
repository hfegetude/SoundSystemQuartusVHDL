library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Channel_Mod is
	port(clk, rstn, sel, men, adcdat : in std_logic;
		  SCCnt  : in unsigned(1 downto 0);
		  BitCnt : in unsigned(4 downto 0);
		  DAC : in signed(15 downto 0);
		  dacdat : out std_logic;
		  ADC : out signed(15 downto 0));
end entity;

architecture rtl of Channel_Mod is
	signal RXreg, TXreg : signed(15 downto 0);
	begin
	rx : process(clk, rstn)
		begin
			if(rstn = '0') then
				ADC <= (others => '0');
				RXreg <= (others => '0');
			elsif (rising_edge(clk)) then
				if (sel = '0' and BitCnt < 16 and men = '1' and SCCnt = "01") then
					RXReg(0) <= adcdat;
					RXReg(15 downto 1) <= RXReg(14 downto 0);
				end if;
			ADC <= RXReg;
			end if;
	end process;
	
	tx : process(clk, rstn)
		begin
			if(rstn = '0') then
				TXreg <= (others => '0');
			elsif (rising_edge(clk)) then
				if (sel = '0'and men = '1' and SCCnt = "11") then
					TXReg(15 downto 1) <= TXReg(14 downto 0);
				end if;
				
				if(sel = '1') then
					TXreg <= DAC;
				end if;
			end if;
	end process;
	dacdat <= TXReg(15);
end rtl;