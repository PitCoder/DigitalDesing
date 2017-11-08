library ieee;
use ieee.std_logic_1164.all;

entity reg_cont is
	port(clk,clr,rs,ls: in std_logic;
			control: in std_logic_vector (2 downto 0);
			input: in std_logic_vector (4 downto 0);
			output: inout std_logic_vector (4 downto 0));
end reg_cont;

architecture arq_req_cont of reg_cont is
	begin
		process(clk,clr,rs,ls,control,input)
			constant cero: std_logic_vector(4 downto 0):="00000";
			constant one: std_logic_vector(4 downto 0):="00001";
			constant two: std_logic_vector(4 downto 0):="00010";
			constant three: std_logic_vector(4 downto 0):="00011";
			constant four: std_logic_vector(4 downto 0):="00100";
			constant five: std_logic_vector(4 downto 0):="00101";
			constant six: std_logic_vector(4 downto 0):="00110";
			constant seven: std_logic_vector(4 downto 0):="00111";
			constant eight: std_logic_vector(4 downto 0):="01000";
			constant nine: std_logic_vector(4 downto 0):="01001";
			constant ten: std_logic_vector(4 downto 0):="01010";
			constant eleven: std_logic_vector(4 downto 0):="01011";
			constant twelve: std_logic_vector(4 downto 0):="01100";
			constant thirteen: std_logic_vector(4 downto 0):="01101";
			constant fourteen: std_logic_vector(4 downto 0):="01110";
			constant fifteen: std_logic_vector(4 downto 0):="01111";
			constant sixteen: std_logic_vector(4 downto 0):="10000";
			constant seventeen: std_logic_vector(4 downto 0):="10001";
			constant eighteen: std_logic_vector(4 downto 0):="10010";
			constant nineteen: std_logic_vector(4 downto 0):="10011";
			constant twenty: std_logic_vector(4 downto 0):="10100";
			constant twenty_one: std_logic_vector(4 downto 0):="10101";
			constant twenty_two: std_logic_vector(4 downto 0):="10110";
			constant twenty_three: std_logic_vector(4 downto 0):="10111";
			constant twenty_four: std_logic_vector(4 downto 0):="11000";
			constant twenty_five: std_logic_vector(4 downto 0):="11001";
			constant twenty_six: std_logic_vector(4 downto 0):="11010";
			constant twenty_seven: std_logic_vector(4 downto 0):="11011";
			constant twenty_eight: std_logic_vector(4 downto 0):="11100";
			constant twenty_nine: std_logic_vector(4 downto 0):="11101";
			constant thirty: std_logic_vector(4 downto 0):="11110";
			constant thirty_one: std_logic_vector(4 downto 0):="11111";
			
		begin
			
			if(clr='0') then
				output<="00000";
			
			elsif(clk'event and clk='1') then
				case control is
					when "000" =>	output <= input;		--CHARGE
					
					when "001" => output <= to_stdlogicvector(to_bitvector(output) srl 1);	--RIGHT SHIFT
											output(4) <= rs;
											
					when "010" => output <= to_stdlogicvector(to_bitvector(output) sll 1);	--LEFT SHIFT
											output(0) <= ls;
											
					when "011" => output <= output;		--RETAIN
					
					when "100" => case output is	--ASC
												when cero 				=> output <=	one;
												when one 				=> output <=	two;
												when two 				=> output <=	three;
												when three 				=> output <=	four;
												when four 				=> output <=	five;
												when five 				=> output <=	six;
												when six 					=> output <=	seven;
												when seven 				=> output <=	eight;
												when eight 				=> output <=	nine;
												when nine 				=> output <=	ten;
												when ten 					=> output <=	eleven;
												when eleven 			=> output <=	twelve;
												when twelve 			=> output <=	thirteen;
												when thirteen 			=> output <=	fourteen;
												when fourteen 			=> output <=	fifteen;
												when fifteen 			=> output <=	sixteen;
												when sixteen 			=> output <=	seventeen;
												when seventeen 		=> output <=	eighteen;
												when eighteen 			=> output <=	nineteen;
												when nineteen 			=> output <=	twenty;
												when twenty 			=> output <=	twenty_one;
												when twenty_one 		=> output <=	twenty_two;
												when twenty_two 		=> output <=	twenty_three;
												when twenty_three 	=> output <=	twenty_four;
												when twenty_four 	=> output <=	twenty_five;
												when twenty_five 		=> output <=	twenty_six;
												when twenty_six 		=> output <=	twenty_seven;
												when twenty_seven 	=> output <=	twenty_eight;
												when twenty_eight 	=> output <=	twenty_nine;
												when twenty_nine 	=> output <=	thirty;
												when thirty 				=> output <=	thirty_one;
												when others			=> output <=	cero;
											end case;
					
					when "101" => case output is	--DESC
												when cero 				=> output <=	thirty_one;
												when one 				=> output <=	cero;
												when two 				=> output <=	one;
												when three 				=> output <=	two;
												when four 				=> output <=	three;
												when five 				=> output <=	four;
												when six 					=> output <=	five;
												when seven 				=> output <=	six;
												when eight 				=> output <=	seven;
												when nine 				=> output <=	eight;
												when ten 					=> output <=	nine;
												when eleven 			=> output <=	ten;
												when twelve 			=> output <=	eleven;
												when thirteen 			=> output <=	twelve;
												when fourteen 			=> output <=	thirteen;
												when fifteen 			=> output <=	fourteen;
												when sixteen 			=> output <=	fifteen;
												when seventeen 		=> output <=	sixteen;
												when eighteen 			=> output <=	seventeen;
												when nineteen 			=> output <=	eighteen;
												when twenty 			=> output <=	nineteen;
												when twenty_one 		=> output <=	twenty;
												when twenty_two 		=> output <=	twenty_one;
												when twenty_three 	=> output <=	twenty_two;
												when twenty_four 	=> output <=	twenty_three;
												when twenty_five 		=> output <=	twenty_four;
												when twenty_six 		=> output <=	twenty_five;
												when twenty_seven 	=> output <=	twenty_six;
												when twenty_eight 	=> output <=	twenty_seven;
												when twenty_nine 	=> output <=	twenty_eight;
												when thirty 				=> output <=	twenty_nine;
												when others			=> output <=	thirty;
											end case;
											
					when "110" => output <= to_stdlogicvector(to_bitvector(output) ror 1); --RIGHT ROTATION
									
					when others => output <= to_stdlogicvector(to_bitvector(output) rol 1); --LEFT ROTATION
				end case;
			end if;
		end process;
	end arq_req_cont;