library ieee;
use ieee.std_logic_1164.all;

entity ffsr is
	port(s,r,clk,clr,pre: in std_logic;
			q,qn: inout std_logic);
			
	attribute pin_numbers of ffsr: entity is
		"clk:1 clr:2 pre:3 s:4 r:5"
		& " q:19 qn:18";
end ffsr;

architecture arqffsr of ffsr is
	begin
		process(s,r,clr,clk,pre,q,qn)
			begin
				if(clr='0') then
					q<='0';
					qn<='1';
				
				elsif(clk'event and clk='1') then
						if(pre='1') then
							q<='1';
							qn<='0';
						
						elsif((s='0' and r='1') or (s='1' and r='0')) then
							q<=s;
							qn<= (not s);
							
						elsif(s='1' and r='1') then
							q<= '-';
							qn<= '-';
						end if;
				end if;
			end process;
	end arqffsr;