library ieee;
use ieee.std_logic_1164.all;

entity contador_decada is
	port(clk,clr: in std_logic;
		 control: in std_logic_vector(1 downto 0);
		 i: in std_logic_vector(3 downto 0);
		 d: inout std_logic_vector(6 downto 0));

end contador_decada;

architecture arq_contador_decada of contador_decada is
	type Digits_array is array(0 to 3) of std_logic_vector(6 downto 0);
	constant Off: std_logic_vector(6 downto 0):="1111111";
	constant Digits : Digits_array :=("0000001","1001111","0010010","0000110",
													  "1001100","0100100","0100000","0001111",
													  "0000000","0001100");
												  
	begin
		process(clk,clr,control,d,i)
			begin
				if(clr='0') then
					d<=DIG0;	

				elsif(clk'event and clk='1') then
					case control is
					when "00" => case i is
								 when "0000" => d <= Digits(0);
								 when "0001" => d <= Digits(1);
								 when "0010" => d <= Digits(2);
								 when "0011" => d <= Digits(3);
								 when "0100" => d <= Digits(4);
								 when "0101" => d <= Digits(5);
								 when "0110" => d <= Digits(6);
								 when "0111" => d <= Digits(7);
								 when "1000" => d <= Digits(8);
								 when "1001" => d <= Digits(9);
								 when others => d <= Off;	
								 end case;

					when "01" => case d is
								 when 	Digits(0) => d <= Digits(1);
								 when  Digits(1) => d <= Digits(2);
								 when  Digits(2) => d <= Digits(3);
								 when  Digits(3) => d <= Digits(4);
								 when  Digits(4) => d <= Digits(5);
								 when  Digits(5) => d <= Digits(6);
								 when  Digits(6) => d <= Digits(7);
								 when  Digits(7) => d <= Digits(8);
								 when  Digits(8) => d <= Digits(9);
								 when  Digits(9) => d <= Digits(0);
								 when others => d <= Off;	
								 end case;

					when "10" => case d is
								 when  Digits(0) => d <= Digits(9);
								 when  Digits(1) => d <= Digits(0);
								 when  Digits(2) => d <= Digits(1);
								 when  Digits(3) => d <= Digits(2);
								 when  Digits(4) => d <= Digits(3);
								 when  Digits(5) => d <= Digits(4);
								 when  Digits(6) => d <= Digits(5);
								 when  Digits(7) => d <= Digits(6);
								 when  Digits(8) => d <= Digits(7);
								 when  Digits(9) => d <= Digits(8);
								 when others => d <= Off;	
								 end case;
					when others => d <= d;
					end case;
				end if;
			end process;
	end arq_contador_decada;