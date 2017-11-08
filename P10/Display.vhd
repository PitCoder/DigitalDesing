library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity Display is
	port(clk,clr: in std_logic;
			o: out std_logic_vector(7 downto 0);
			d: out std_logic_vector(3 downto 0));
end Display;

architecture Behavioral of Display is
signal prescaler : unsigned(23 downto 0);
begin
	process(clk,clr,prescaler)		
		constant codI: std_logic_vector(7 downto 0):= "10011111";
		constant codP: std_logic_vector(7 downto 0):= "00110001";
		constant codN: std_logic_vector(7 downto 0):= "11010101";
		constant codNULL: std_logic_vector(7 downto 0):= "11111111";
		variable counter: std_logic_vector(3 downto 0):="1011";
			begin
				if(clr='0') then
					o<="00000000";
					d<="1111";
					counter:="1011";
				elsif rising_edge(clk) then
					if(prescaler = X"65B9A") then
						case counter is
							when "1011" => o <= codI;
							when "1101" => o <= codP;
							when "1110" => o <= codN;
							when others => o <= codNULL;
						end case;
						d <= counter;
						counter:= to_stdlogicvector(to_bitvector(counter) ror 1);
						prescaler   <= (others => '0');
					else
						 prescaler <= prescaler + "1";
					end if;
				end if;
			end process;
end Behavioral;