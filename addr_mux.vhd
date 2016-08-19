library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addr_mux is 
	port( record_t: in std_logic;
			addr_record: in std_logic_vector (17 downto 0);
			addr_play: in std_logic_vector (17 downto 0);
			addr_out : out std_logic_vector(17 downto 0)
			);
end entity;



architecture rtl of addr_mux is
	
	begin		
	addr_out <= addr_record when record_t='1' else addr_play;
end architecture;