library ieee;
use ieee.std_logic_1164.all;

entity ffjk is
	port(j,k,clk,clr,pre: in std_logic;
			q,qn: inout std_logic);
			
	attribute pin_numbers of ffjk: entity is
		"clk:1 clr:2 pre:3 j:4 k:5"
		& " q:19 qn:18";
end ffjk;

architecture arqffjk of ffjk is
	begin
		process(j,k,clr,clk,pre,q,qn)
			begin
				if(clr='0') then
					q<='0';
					qn<='1';
				
				elsif(clk'event and clk='1') then
						if(pre='1') then
							q<='1';
							qn<='0';
						
 						elsif((j='0' and k='1') or (j='1' and k='0')) then
							q<=j;
							qn<= (not j);
							
						elsif(j='1' and k='1') then
							qn<=q;
							q<= (not q);		
						end if;
				end if;
			end process;
	end arqffjk;