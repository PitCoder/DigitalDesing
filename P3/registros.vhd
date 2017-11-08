library ieee;
use ieee.std_logic_1164.all;

entity registros is
	port(clk,clr,pre,ls,rs: in std_logic;
			d: in std_logic_vector(6 downto 0);
			sel: in std_logic_vector(1 downto 0);
			q: inout std_logic_vector(6 downto 0));
	
		attribute pin_numbers of registros: entity is
		"clk:1 clr:2 pre:3 sel(0):4 sel(1):5 d(0):6 d(1):7 d(2):8 d(3):9 d(4):10 d(5):11 d(6):13 ls:14 rs:15"
		& "  o(6):16 o(5):17 o(4):18 o(3):19 o(2):20 o(1):21 o(0):22";
end registros;

architecture arqregistros of registros is	
	begin
		process(clk,clr,pre,sel,d,q)
			variable man,carga,der,izq: std_logic_vector(6 downto 0);
			begin
				if(clr='0') then
					q<="00000000";
				elsif(clk'event and clk='1') then
					if(pre='1') then
						q<="11111111";
					else
						carga:=d;		
						man:=q;
						
						der(0):=rf;
						der(1):=q(0);
						der(2):=q(1);
						der(3):=q(2);
						der(4):=q(3);
						der(5):=q(4);
						der(6):=q(5);
						der(7):=q(6);
						
						izq(0):=q(1);
						izq(1):=q(2);
						izq(2):=q(3);
						izq(3):=q(4);
						izq(4):=q(5);
						izq(5):=q(6);
						izq(6):=q(7);
						izq(7):=lf;
						
							case sel is	
								when "00" =>q<=man;
								when "01" =>q<=carga;
								when "10" =>q<=der;
								when others =>q<=izq;
							end case;
					end if;
				end if;
			end process;
	end arqregistros;