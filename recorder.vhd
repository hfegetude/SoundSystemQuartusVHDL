
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity recorder is

	port 
	(
		clk, enable, record_t: in std_logic;
		addr	: out unsigned(17 downto 0);
		srm_in: out signed(15 downto 0);
		right_input, left_input: in signed(15 downto 0);
		top_level : out unsigned(17 downto 0):= (others=>'0');
		sram_ce,sram_oe,sram_we : out std_logic;
      sram_lb,sram_ub         : out std_logic
	);

end entity;

architecture rtl of recorder is
	signal addr_counter : unsigned(17 downto 0):= (others=>'0');
	signal next_flag, full_memory_flag: std_logic := '0';

begin

	process(clk)
	begin
	if(rising_edge(clk)) then
	
		if record_t= '1' then 
		
			if full_memory_flag = '0' then 
			
				if (enable = '1' AND next_flag = '0') then
					srm_in <= right_input;
					next_flag <= '1';
					
					if addr_counter > 262143 then
						addr_counter <= (others => '0');
						full_memory_flag <= '0'; --reset flags
					else
						addr_counter <= addr_counter + 1;
						
					end if;
					
				elsif next_flag = '1' then
					next_flag <= '0';
					srm_in<= left_input;
					
					if addr_counter > 262143 then
						addr_counter <= (others => '0');
						full_memory_flag <= '0'; --reset flags
					else
						addr_counter <= addr_counter + 1;
					end if;
					
				end if;
				
		end if;
		
		end if;
	end if;
	end process;
	addr<=addr_counter;
	--Memory control
	sram_ce <= '0';
	sram_oe <= '1' when (record_t = '1') else '0' ;
	sram_we <= '0' when (record_t = '1') else '1';
	sram_lb <= '0';
	sram_ub <= '0';
	top_level<= addr_counter;
end rtl;
