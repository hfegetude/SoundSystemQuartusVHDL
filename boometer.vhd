library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ; 


entity Boometer is
        port (
                clk, enable : in std_logic;
                MonoInput: in signed (15 downto 0);
                LedOut: out std_logic_vector (8 downto 0)
                );

 end entity ;

 architecture arch of Boometer is
        signal MonoInputSquare: signed (31 downto 0);
        signal sout: unsigned (31 downto 0);
		  signal MonoInputSquareUnsig: unsigned (31 downto 0);

 begin
 process(clk)
 begin
        if rising_edge(clk) then
                if enable='1' then
                        sout <= MonoInputSquareUnsig  + sout - shift_right(sout, 10);
                end if ;
        end if;
end process;
MonoInputSquare<= MonoInput*MonoInput;
MonoInputSquareUnsig <= unsigned(MonoInputSquare);
LedOut <=
"000000000" when sout = 0 else
"000000001" when sout <53900000 else
"000000011" when sout <85500000 else
"000000111" when sout <135500000 else
"000001111" when sout <214700000 else
"000011111" when sout <340400000 else
"000111111" when sout <539400000 else
"001111111" when sout <854900000 else
"011111111" when sout <1355000000 else
"111111111";
end architecture;