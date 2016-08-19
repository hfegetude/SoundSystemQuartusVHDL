library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity CatchGen is 
	port( BitCnt : in unsigned (4 downto 0);
			catch : out std_logic
			
			);
end entity;

architecture rtl of CatchGen is
begin
	catch <= '1' when BitCnt = "10000" else '0'; 
end architecture;