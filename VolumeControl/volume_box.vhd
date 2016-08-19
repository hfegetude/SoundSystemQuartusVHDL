library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--In this block we will convert the left and right inputs, that come 1 by 1 into a parallel output


entity volume_box is 
	port( 
			clk, enable : in std_logic; 
			MonoIn: in signed (15 downto 0);
			MonoOut: out signed (15 downto 0);
			Volume_level: in unsigned(3 downto 0)
			);
end entity;

architecture rtl of volume_box is
	type pipe_11 is array (11 downto 0) of signed(15 downto 0);
	signal Volume_tap : pipe_11; --tap containing all x(n) coeffs
	shared variable j :integer;
	begin 		

	process (clk)
	begin
      if rising_edge (clk) then
			if enable = '1' then
			j := to_integer(Volume_level);
			MonoOut <= Volume_tap(j);
			end if;
		end if;
	end process;
	Volume_tap(0) <= MonoIn;
	Volume_tap(1)<= shift_right(Volume_tap(0), 1) + shift_right(Volume_tap(0), 2) + shift_right(Volume_tap(0), 3);
	Volume_tap(2)<= shift_right(Volume_tap(1), 1) + shift_right(Volume_tap(1), 2) + shift_right(Volume_tap(1), 3);
	Volume_tap(3)<= shift_right(Volume_tap(2), 1) + shift_right(Volume_tap(2), 2) + shift_right(Volume_tap(2), 3);
	Volume_tap(4)<= shift_right(Volume_tap(3), 1) + shift_right(Volume_tap(3), 2) + shift_right(Volume_tap(3), 3);
	Volume_tap(5)<= shift_right(Volume_tap(4), 1) + shift_right(Volume_tap(4), 2) + shift_right(Volume_tap(4), 3);
	Volume_tap(6)<= shift_right(Volume_tap(5), 1) + shift_right(Volume_tap(5), 2) + shift_right(Volume_tap(5), 3);
	Volume_tap(7)<= shift_right(Volume_tap(6), 1) + shift_right(Volume_tap(6), 2) + shift_right(Volume_tap(6), 3);
	Volume_tap(8)<= shift_right(Volume_tap(7), 1) + shift_right(Volume_tap(7), 2) + shift_right(Volume_tap(7), 3);
	Volume_tap(9)<= shift_right(Volume_tap(8), 1) + shift_right(Volume_tap(8), 2) + shift_right(Volume_tap(8), 3);
	Volume_tap(10)<= shift_right(Volume_tap(9), 1) + shift_right(Volume_tap(9), 2) + shift_right(Volume_tap(9), 3);
	Volume_tap(11)<= shift_right(Volume_tap(10), 1) + shift_right(Volume_tap(10), 2) + shift_right(Volume_tap(10), 3);
end architecture;
		