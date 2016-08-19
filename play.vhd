library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;


entity play is

	port 
	(
		clk, enable, play_t: in std_logic;
		addr	  : out unsigned(17 downto 0);
		sram_out : in signed(15 downto 0);
		right_out, left_out: out signed(15 downto 0);
		top_level : in unsigned(17 downto 0)
		
	);

end entity;

architecture rtl of play is
	signal addr_counter : unsigned(17 downto 0):=(others=>'0');
	signal next_flag : std_logic := '0';

begin

	process(clk)
	begin
	
	if(rising_edge(clk)) then
		if play_t= '1' then 
			if (enable = '1' AND next_flag = '0') then
				right_out<=sram_out;
				next_flag <= '1';
				
				if addr_counter > top_level then
					addr_counter <= (others => '0');
				else
					addr_counter <= addr_counter + 1;
				end if;
				
			elsif next_flag = '1' then
				next_flag <= '0';
				left_out<=sram_out;
				
				if addr_counter > top_level then
					addr_counter <= (others => '0');
				else
					addr_counter <= addr_counter + 1;
				end if;
				
			end if;
		end if;
	end if;

	end process;
	addr<=addr_counter;
	
end rtl;
