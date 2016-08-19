library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity deglitcher is 
	port(clk : in std_logic;
			MonoIn: in signed (15 downto 0);
			MonoOut: out signed (15 downto 0)
			);
end entity;

architecture rtl of deglitcher is
	shared variable counter: integer :=6;
	signal prev_in : signed (15 downto 0);
	begin
	process(clk)
	begin
		if rising_edge(clk) then
			if MonoIn/= Prev_in then 
			---The input just changed. reset the timeout.
			counter := 6;
		elsif counter/=0 then
			---Input stable,but timer not yet expired. Keep timing.
			counter := counter - 1;
		else
			---Input stable, and counter has expired. Update the output.
			MonoOut <= prev_in;
		end if;
			---Keep track of the most recent input.
		prev_in <= MonoIn;
		end if;
	end process;
end architecture;