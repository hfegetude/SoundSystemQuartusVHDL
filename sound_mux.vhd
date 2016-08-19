library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sound_mux is 
	port( play_t, clk, enable: in std_logic;
			mute: in std_logic;
			play_left:  in unsigned(15 downto 0);
			play_right : in unsigned(15 downto 0);
			left_input, right_input: in unsigned (15 downto 0);
			out_right, out_left : out unsigned (15 downto 0)
			
			);
end entity;



architecture rtl of sound_mux is
	
	begin		
	process(clk)
	begin
	if rising_edge(clk) then
		if enable = '1' then
			if play_t = '1' then
				out_left <=play_left;
				out_right<= play_right;
			elsif mute = '1' then
				out_left <= (others=>'0');
				out_right <= (others=>'0');
			else
				out_left <= left_input;
				out_right <= right_input;
			end if;
		end if;
	end if;
	end process;
end architecture;