library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
	port( clk, clr, pre: in std_logic;
			c: in std_logic_vector(1 downto 0);
			d: in std_logic_vector(2 downto 0);
			q: inout std_logic_vector(2 downto 0)	);
	attribute pin_numbers of shift_register: entity is
		"clk:1 clr:2 pre:3 c(0):4 c(1):5 d(0):6 d(1):7 d(2):8 "
		& "q(0):14 q(1):15 q(2):16";
end shift_register;

architecture a_shift of shift_register is
begin
	process (clk, clr, pre, d, c, q)
		begin
			if(clr = '0') then
				q <= "000";
			elsif(clk'event and clk = '1') then
				if(pre = '1') then
					q <= "111";
				else
					for i in 0 to 2 loop
						case c is
							when "00" => q(i) <= q(i);
							when "01" =>
								if(i = 0) then
									q(0) <= d(0); -- q(i) = d
								else
									q(i) <= q(i-1);
								end if;
							when "10" =>
								if(i = 2) then
									q(2) <= d(2); -- q(i) = d
								else
									q(i) <= q(i+1);
								end if;
							when others => q <= d;
						end case;
					end loop;
				end if;
			end if;
		end process;
end a_shift;