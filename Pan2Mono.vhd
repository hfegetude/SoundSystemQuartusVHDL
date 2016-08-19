library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity Pan2Mono is 
	port(
			clk, enable: in std_logic; 
			Lin: in signed (15 downto 0);
			Rin: in signed (15 downto 0);
			MonoOut: out signed (15 downto 0)
		
			);
end entity;

architecture rtl of Pan2Mono is
	signal aux : signed(15 downto 0) := (others => '0') ; 
	
	begin 
	process (clk)
	begin
		if rising_edge (clk) then
			MonoOut <= aux;
		end if;	
	end process;
	
	aux <= shift_right(Lin, 1)+ shift_right(Rin, 1);
		
end architecture;
