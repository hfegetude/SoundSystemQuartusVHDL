library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity FilterLOWpass is
generic(
        Nb : integer := 16;
        WordLenght : integer := 32
        );

port (
        clk   : in  std_logic;
        enable  : in  std_logic;
        MonoIn  : in  signed(Nb-1 downto 0);
        MonoOut : out signed(Nb-1 downto 0)
 ) ;

 end entity ;

architecture arch of FilterLOWpass is
type D_array is array (1 downto 0) of signed(WordLenght-1 downto 0);
signal X_tap : D_array := ((others => '0'),  (others => '0'));
signal Y_tap : D_array := ((others => '0'),  (others => '0'));
signal X_reg : signed(Nb-1 downto 0);
signal Aux_MonoOut : signed (WordLenght-1 downto 0);
begin
process(clk)
begin
if rising_edge(clk) then
        if enable='1' then
                --Update all the inputs/outputs
                X_reg<=MonoIn;
                Y_tap(0)<=Aux_MonoOut;
					 X_tap(0)<=resize(X_reg, WordLenght);
                --Update all the taps
                X_tap(1)<=X_tap(0);
                Y_tap(1)<=Y_tap(0);
        end if;
end if;
end process;

Aux_MonoOut <=
resize(shift_right(X_reg*signed'("010110001"),16), WordLenght)    --X * 0.0027
+resize(shift_right(X_tap(0)*signed'("0101011011"),16), WordLenght) --X * 0.0053
+resize(shift_right(X_tap(1)*signed'("010110001"),16), WordLenght)  --X * 0.0027
--Minus
+resize(shift_right(Y_tap(0)*signed'("01110110010110011"),15), WordLenght)  --  -X * 1.8492
-resize(shift_right(Y_tap(1)*signed'("0110111000001110"),15), WordLenght) ; -- X * 0.8598

MonoOut<=resize(Y_tap(0), Nb);

end architecture ; 
