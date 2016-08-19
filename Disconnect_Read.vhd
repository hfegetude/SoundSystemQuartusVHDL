library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Create a mono input for a stereo output
entity Disconnect_Read is 
	port( record_t: in std_logic;
			data_in: in std_logic_vector(15 downto 0);
			data_out: out std_logic_vector(15 downto 0)
			
			);
end entity;



architecture rtl of Disconnect_Read is
	
	begin		
		data_out <= data_in when record_t = '1' else (others=>'Z'); 
end architecture;