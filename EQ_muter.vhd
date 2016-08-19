library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EQ_muter is 
	port( Mute_EQ: in std_logic;
			Lin1: in signed (15 downto 0);
			Rin1: in signed (15 downto 0);
			Lin2: in signed (15 downto 0);
			Rin2: in signed (15 downto 0);
			RoutAfterMut: out signed (15 downto 0);
			LoutAfterMut: out signed (15 downto 0);
			clk, enable: in std_logic
			);
end entity;



architecture rtl of EQ_muter is
	
	begin		
	process (clk)
	begin
	if rising_edge(clk) then
		if enable='1' then
			if Mute_EQ = '0' then 
				RoutAfterMut <= Rin1 ;
				LoutAfterMut <= Lin1 ;
			else
				RoutAfterMut <= Rin2 ;
				LoutAfterMut <= Lin2 ;
			end if;
		end if;
	end if;
	end process;
end architecture;