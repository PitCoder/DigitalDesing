library ieee;
use ieee.std_logic_1164.all;

entity ffd is
	port(d,clk,clr,pre: in std_logic;
		q,qn: out std_logic);
		
	attribute pin_numbers of ffd: entity is
		"clk:1 clr:2 pre:3 d:4"
		& " q:19 qn:18";
end ffd;

architecture arqffd of ffd is
	begin
		process(clk,clr,pre,d)
			begin
			if(clr='0') then
					q<='0';
					qn<='1';
				
				elsif(clk'event and clk='1') then
						if(pre='1') then
							q<='1';
							qn<='0';
						elsif('d'='0' or d='1') then
							q<=d;
							qn<= (not d);
						end if;
			end if;
			end process;
	end arqffd;