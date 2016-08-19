

library ieee;
use ieee.std_logic_1164.all;

entity keyboard_trans is

	port 
	(
		in_keyboard	: in std_logic_vector(3 downto 0);
		volume_up, volume_down, balance_right, balance_left, mute_eq, record_t, play_t, mute	: out std_logic
		
	);

end entity;

architecture rtl of keyboard_trans is
signal out_aux : std_logic_vector(7 downto 0);

begin
	assignation: with in_keyboard select
	out_aux <= "00000000" when "0000",
				  "00000001" when "0010",
				  "00000010" when "1001",
				  "00000100" when "0101",
				  "00001000" when "0110",
				  "00010000" when "0100",
				  "00100000" when "0111",
				  "01000000" when "1000",
				  "10000000" when "0001",
				  "00000000" when others;


	volume_up<=out_aux(0);
	volume_down<=out_aux(1);
	balance_left<=out_aux(2);
	balance_right<=out_aux(3);
	mute_eq<=out_aux(4);
	mute<=out_aux(5);
	play_t<=out_aux(6);
	record_t<=out_aux(7);

	

end rtl;
