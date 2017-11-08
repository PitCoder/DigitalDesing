library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity sum_serie is
	port(clk,clr,control: in std_logic;
			carry: out std_logic;
			a,b: in std_logic_vector(3 downto 0);
			output: out std_logic_vector(3 downto 0));
end sum_serie;

architecture arqsum_serie of sum_serie is
	begin
		process(clk,clr,a,b,control)
			variable Qt: std_logic:='0';
			variable S: std_logic:='0';
			variable counter: integer range 0 to 5:=0;
			begin
					if(clr ='0') then
						carry<='0';
						Qt:='0';
						counter:=0;
						--reg_A:="0000";
						--reg_B:="0000";
						--reg_S:="0000";
						output<="0000";
					
					elsif(clk'event and clk='1') then
							if(control='1' and counter<4) then
							S:=Qt xor a(counter) xor b(counter);
							Qt:=(a(counter) and b(counter)) or (Qt and(a(counter) or b(counter)));
							carry<=Qt;
							output(counter)<=S;
							counter:= counter + 1;
						end if;
					end if;
			end process;
	end arqsum_serie;