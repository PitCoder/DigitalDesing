library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity grey is
	port(clk,clr,control: in std_logic;
			o: out std_logic_vector(3 downto 0));

   	attribute pin_numbers of grey: entity is
		"clk:1 clr:2 control:3"
		& " o(0):14 o(1):15 o(2):16 o(3):17";
end grey;

architecture arq_grey of grey is
	begin
		process(clk,clr,control)
			variable q: std_logic_vector(3 downto 0);
			variable contador: std_logic_vector(3 downto 0):="0000";
			begin
				if(clr='0') then
					contador:= "0000";
					o<=contador;
			
				elsif(clk'event and clk='1') then
					q:= to_stdlogicvector(to_bitvector(contador) srl 1);
							for i in 0 to 3 loop
							q(i):= q(i) xor contador(i);
							end loop;
					o<= q;
					if(control='0') then
						contador:= contador+1;

					else
						contador:= contador-1;
				   	end if;
				end if;
			end process;
	end arq_grey;