library ieee;
use ieee.std_logic_1164.all;

entity contador is
	port(clk,clr,s: in std_logic;
		 q: inout std_logic_vector(9 downto 0));

end contador;

architecture arqcontador of contador is
	begin
		process(clk,clr,s,q)
				variable j: std_logic_vector(9 downto 0);
				variable n_temp: std_logic;
				variable p_temp: std_logic;
				variable temp: std_logic;
			begin	
				if(clr = '0') then
					q <= "0000000000";
				elsif(clk'event and clk = '1') then
				
					for i in 0 to 9 loop
						if(i = 0) then
							j(0):= '1';
							n_temp := not(s) and not(q(0));
							p_temp := s and q(0);
						else
							j(i):= p_temp or n_temp;
							n_temp := n_temp and not(q(i));
							p_temp := p_temp and q(i);
						end if;

						if(j(i) = '0') then
							q(i) <= q(i);
						else
							temp := not(q(i));
							q(i) <= temp;
						end if;
					end loop;
				end if;
			end process;
	end arqcontador;