library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Volume_decider is
	port 
	(  pan_level : in unsigned(3 downto 0);
		R_vol, L_vol : out unsigned (3 downto 0)
	);

end entity;

architecture rtl of Volume_decider is
	signal Vr_temp, Vl_temp : integer;
	
begin
	Vr_temp <= 10-to_integer( pan_level )*2  when pan_level < 5 else 0 ;
	Vl_temp <= (to_integer(pan_level )-5 )*2 when pan_level > 5 else 0;
	R_vol <= to_unsigned(Vr_temp, 4) ;
	L_vol <= to_unsigned(Vl_temp, 4) ;
	
	
	
end rtl;