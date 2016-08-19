library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--In this block we will convert the left and right inputs, that come 1 by 1 into a parallel output


entity ParallelLeftRight is 
	port( catch : in std_logic; --catch left or right dependinf on lrsel
			clk, enable, lrsel : in std_logic; 
			Lin: in signed (15 downto 0);
			Rin: in signed (15 downto 0);
			Lout: out signed (15 downto 0);
			Rout: out signed (15 downto 0)
			);
end entity;

architecture rtl of ParallelLeftRight is
	signal Lreg : signed(15 downto 0) := (others => '0') ; 
	signal Rreg : signed(15 downto 0) := (others => '0');
	begin 
	process (clk)
	begin
		if rising_edge (clk) then
			--In bitcount #16, catch will go 1, (~the middle of each lrsel clock pulse, just to make sure the 2 bytes are in) we will each input (selected by lrsel ) in each reg
			if  catch = '1' then
				if(lrsel= '0') then
					Rreg <= Rin;
				else
					Lreg <= Lin;
				end if;
			end if;
		
		-- We will use enable (both inputs already in reg) to output the regs.
			if enable = '1' then
				Lout <= Lreg;
				Rout <= Rreg;
			end if;
		end if;
		end process;
		
end architecture;
		
	