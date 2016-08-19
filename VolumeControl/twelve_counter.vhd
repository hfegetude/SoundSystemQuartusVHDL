library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity twelve_counter is 
	port( clk, enable : in std_logic; 
			count_up : in std_logic;
			count_down: in std_logic;
			signal_level: out unsigned(3 downto 0)
			);
end entity;

architecture rtl2 of twelve_counter is
	signal current_value_up, current_value_down, old_value_up, old_value_down, enable_down, enable_up: std_logic ;
	signal signal_level_aux : unsigned(3 downto 0):= x"5" ;
	begin 		

	process (clk)
	begin
      if rising_edge (clk) then
			if enable='1' then
			--find rising edges on keyboard data
			current_value_up <= count_up;
			old_value_up <= current_value_up;
			
			current_value_down <= count_down;
			old_value_down <= current_value_down;
			
			if enable_up = '1' then
				if signal_level_aux > 0 then
					signal_level_aux <= signal_level_aux-"0001"; --lESS ATENUATION	
				end if;
			end if;
			if enable_down = '1' then
				if signal_level_aux < 10 then
					signal_level_aux <= signal_level_aux+"0001";
				end if;
			end  if;
		end if;
		end if;
	end process;
	enable_up <=  ( current_value_up) AND (NOT old_value_up) ; 
	enable_down <=  ( current_value_down) AND (NOT old_value_down) ; 
	signal_level <= signal_level_aux;
end architecture;
		