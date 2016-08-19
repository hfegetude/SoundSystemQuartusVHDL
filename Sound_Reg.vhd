library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sound_Reg is 
	port( clk, enable	: in std_logic;
			Lin: in signed (15 downto 0);
			Rin: in signed (15 downto 0);
			Rout: out signed (15 downto 0);
			Lout: out signed (15 downto 0)
			);
end entity;



architecture rtl of Sound_Reg is
	
	begin		
		del :process(clk)
		begin
			if rising_edge (clk) then
				if enable =  '1' then 
					Lout <= Lin ;
					Rout <= Rin;
				end if;
			end if;
		end process;
		
end architecture;