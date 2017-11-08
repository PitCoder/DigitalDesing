library ieee;
use ieee.std_logic_1164.all;

entity fft is
	port(t,clr,clk,pre: in std_logic;
			q,qn: inout std_logic);
	
	attribute pin_numbers of fft: entity is
		"clk:1 clr:2 pre:3 t:4"
		& " q:19 qn:18";
end fft;

architecture arqfft of fft is
	begin
		process(t,clr,clk,pre,q,qn)
		 begin
			if(clr='0') then
				q<='0';
				qn<='1';
			elsif(clk'event and clk='1') then
					if(pre='1') then
						q<='1';
						qn<='0';
					elsif(t='0' or t='1') then
						q<= q xor t;
						qn<= (not q);
					end if;
			end if;
		 end process;
	end arqfft;