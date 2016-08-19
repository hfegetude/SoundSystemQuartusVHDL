library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl is
  port(clk , rstn : in std_logic;
		mclk , bclk , men , adclrc , daclrc , lrsel : out std_logic ; 
		SCCnt : out unsigned (1 downto 0);
		BitCnt : out unsigned ( 4 downto 0 ) 
  );
end entity;

architecture rtl of ctrl is
	signal cntr : unsigned (9 downto 0) := ( others => '0' );
	signal cntr_l : std_logic_vector (9 downto 0);
begin
	process (clk , rstn)
	begin
		if rstn = '0' then
			cntr <= ( others => '0' ) ;
		elsif rising_edge (clk ) then
			cntr <= cntr +1;
		end if;
	end process;
	cntr_l <= std_logic_vector ( cntr);
	mclk <= not cntr_l(1);
	bclk <= cntr_l (3); 
	men  <= cntr_l(0) AND cntr_l (1);
	SCCnt <= unsigned (cntr_l (3 downto 2));
	BitCnt <= unsigned (cntr_l (8 downto 4)); 
	adclrc <= not cntr_l (9);
	daclrc <= not cntr_l (9);
	lrsel <= cntr_l (9);
	

end architecture;