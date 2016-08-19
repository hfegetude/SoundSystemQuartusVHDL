library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Create a mono input for a stereo output
entity Mux215 is 
	port( sel: in std_logic;
			rin: in std_logic;
			lin: in std_logic;
			sound_out: out std_logic
			);
end entity;



architecture rtl of mux215 is
	
	begin		
		sound_out <= rin when sel = '1' else lin; 
end architecture;