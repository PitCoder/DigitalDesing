library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.DECADECOUNTER.ALL;

entity EstadosSensores is
	port(clk,clr: in std_logic;
		  input: in std_logic_vector(1 downto 0);
		  display: out std_logic_vector(3 downto 0);
		  output: out std_logic_vector(7 downto 0);
		  outstates: out std_logic_vector(7 downto 0));
end EstadosSensores;

architecture Behavioral of EstadosSensores is
	type states is (A,B,C,D,E,F,G,H);
	signal prescaler: unsigned(23 downto 0);
	signal prescaler2: unsigned(23 downto 0);
	begin
		state_sensors: process(clk,clr,input)
			variable counter: integer range 0 to 9999:=0;
			variable digit1: unsigned(3 downto 0):="0000";
			variable digit2: unsigned(3 downto 0):="0000";
			variable digit3: unsigned(3 downto 0):="0000";
			variable digit4: unsigned(3 downto 0):="0000";
			variable action: std_logic_vector(1 downto 0):="00";
			variable rcounter: integer range 0 to 4:= 0;
			variable present_state: states:= A;
			variable future_state: states:= A;
			begin
				if(clr='0') then
					output <= "00000011";
					outstates <= "10000000";
					display <= "0000";
					counter :=0;
					rcounter :=0;
					digit1:= "0000";
					digit2:= "0000";
					digit3:= "0000";
					digit4:= "0000";
					action := "00";
					present_state := A;
					future_state := A;
					
				elsif rising_edge(clk) then
					if(prescaler=X"4C4B40") then
						present_state := future_state;
						case present_state is
							when A => outstates <= "10000000";
										case input is
											when "00" => future_state:=A;
															 action:="00";
															 
											when "01" => future_state:=D;
															 action:="00";
											
											when "10" => future_state:=B;
															 action:="00";
											
											when others => future_state:=A;
																action:="00";
										end case;
							when B => outstates <= "01000000";
										case input is
											when "00" => future_state:=A;
															 action:="00";
															 
											when "01" => future_state:=C;
															 action:="00";
											
											when "11" => future_state:=F;
															 action:="00";
											
											when others => future_state:=B;
																action:="00";
										end case;
							when C => outstates <= "00100000";
										case input is
											when "00" => future_state:=A;
															 action:="01";
															 
											when "10" => future_state:=B;
															 action:="00";
											
											when "11" => future_state:=G;
															 action:="00";
											
											when others => future_state:=C;
																action:="00";
										end case;
							when D => outstates <= "00010000";
										case input is
											when "00" => future_state:=A;
															 action:="00";
															 
											when "10" => future_state:=E;
															 action:="00";
											
											when "11" => future_state:=F;
															 action:="00";
											
											when others => future_state:=D;
																action:="00";
										end case;
							when E => outstates <= "00001000";
										case input is
											when "00" => future_state:=A;
															 action:="10";
															 
											when "01" => future_state:=D;
															 action:="00";
											
											when "11" => future_state:=H;
															 action:="00";
											
											when others => future_state:=E;
																action:="00";
										end case;
							when F => outstates <= "00000100";
										case input is
											when "00" => future_state:=A;
															 action:="00";
															 
											when "01" => future_state:=D;
															 action:="00";
											
											when "10" => future_state:=B;
															 action:="00";
											
											when others => future_state:=F;
																action:="00";
										end case;
							when G => outstates <= "00000010";
										case input is
											when "10" => future_state:=B;
															 action:="01";
											
											when others => future_state:=G;
																action:="00";
										end case;
							when H => outstates <= "00000001";
										case input is
											when "01" => future_state:=D;
															 action:="10";
											
											when others => future_state:=H;
																action:="00";
										end case;
						end case;
						case action is
								when "00" => counter := counter;
								when "01" => counter := counter + 1;
								when "10" => counter := counter - 1;
								when others => counter := 0;
						end case;
						
						if(counter>9999 and counter<0) then
									counter := 0;
						end if;
						seg_ctrl(counter,digit1,digit2,digit3,digit4);
						prescaler   <= (others => '0');
					else
						prescaler <= prescaler+"1";
					end if;
					if(prescaler2=X"32DCD") then
							case rcounter is
								when 1 => output <= unsigned_to7seg(digit4);
												display <= "1110";
												
								when 2 => output <= unsigned_to7seg(digit3);
											 display <= "1101";
											 
								when 3 => output <= unsigned_to7seg(digit2);
											 display <= "1011";
											 
								when others => output <= unsigned_to7seg(digit1);
													display <= "0111";
													rcounter:=0;
							end case;
						rcounter:= rcounter+1;
						prescaler2 <= (others => '0');
					else
						prescaler2 <= prescaler2+"1";
					end if;
				end if;
			end process; 
	end Behavioral;