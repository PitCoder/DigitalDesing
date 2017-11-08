library ieee;
use ieee.std_logic_1164.all;
	entity teclado is
		port(clk,clr: in std_logic;
				f: in std_logic_vector(3 downto 0);
				c: inout std_logic_vector(2 downto 0);
				o: out std_logic_vector(6 downto 0));

		attribute pin_numbers of teclado: entity is
 	    	"clk:1 clr:2 f(3):3 f(2):4 f(1):5 f(0):6"
			& " o(6):14 o(5):15 o(4):16 o(3):17 o(2):18 o(1):19 o(0):20 c(2):23 c(1):22 c(0):21";
	end teclado;
	
	architecture arq_teclado of teclado  is
		begin
			process(clk,clr,f,c)
				begin
				if(clr='0') then
					c<= "011";
					o<= "1111111";
				elsif(clk'event and clk='1') then
					case c is
						when "011" => case f is
														when "1110" => o <= "1001111"; --1
														when "1101" => o <= "1001100"; --4
														when "1011" => o <= "0001111"; --7
														when "0111" => o <= "1111110"; --*
														when others => o <= "1111111";
													end case;

																																						
						when "101" => case f is
														when "1110" => o <= "0010010"; --2
														when "1101" => o <= "0100100"; --5
														when "1011" => o <= "0000000"; --8
														when "0111" => o <= "0000001"; --0
														when others => o <= "1111111";
													end case;
													
						when others => case f is
														when "1110" => o <= "0000110"; --3
														when "1101" => o <= "0100000"; --6
														when "1011" => o <= "0000100"; --9
														when "0111" => o <= "1001000"; --#
														when others => o <= "1111111";
													end case;
					end case;	
					c<=to_stdlogicvector(to_bitvector(c) ror 1);
				end if;
			end process;
		end arq_teclado;	