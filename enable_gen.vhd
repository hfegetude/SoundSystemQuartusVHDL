-- Quartus II VHDL Template
-- Single port RAM with single read/write address 

library ieee;
use ieee.std_logic_1164.all;

entity enable_gen is


	port 
	(
		clk	: in std_logic;
		lrsel : in std_logic;
		enable	: out std_logic
	);

end entity;

architecture rtl of enable_gen is
signal current_value : std_logic;
signal old_value     : std_logic;

begin
	process(clk)
	begin
		if rising_edge(clk) then
			current_value <= lrsel;
			old_value <= current_value;
		end if;
	end process;
	enable <=  (NOT current_value) AND old_value ; 
	
end rtl;