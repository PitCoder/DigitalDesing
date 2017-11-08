library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity Estados is
	port(clk,clr,control: in std_logic;
		  input: in std_logic_vector(7 downto 0);
		  regout: out std_logic_vector(7 downto 0);
		  output: out std_logic_vector(7 downto 0);
		  display: out std_logic_vector(3 downto 0));
end Estados;

architecture Behavioral of Estados is
		type states is (A,B,C,D,E);
		signal prescaler : unsigned(27 downto 0);
		constant letterA: std_logic_vector(7 downto 0):= "00010001";
		constant letternull: std_logic_vector(7 downto 0):= "01100001";
		begin
			state_transitions: process(clk,clr,control,input,prescaler)
				variable Serial_register: std_logic_vector(7 downto 0);
				variable present_state: states := A;
				variable future_state: states:= A;
				variable serial: std_logic;
				begin
					if(clr='0') then
						output <= letternull;
						display <= "1110";
						Serial_register:= "00000000";
						present_state := A;
						future_state := A;
						
					elsif rising_edge(clk) then
							if(control = '0') then
								Serial_register := input;
							else
								if(prescaler = X"17D7840") then
								present_state := future_state;
								serial := Serial_register(7);
								regout <= Serial_register;
								Serial_register :=  to_stdlogicvector(to_bitvector(Serial_register) rol 1);
								case present_state is
									when A => output <= letternull;
												if(serial = '0') then
													future_state := A;
													present_state := future_state;
												else
													future_state := B;
												end if;
												
									when B => output <= letternull;
												if(serial = '0') then
													future_state := A;
												else
													future_state := C;
												end if;
												
									when C => output <= letternull;
												if(serial = '0') then
													future_state := D;
												else
													future_state := C;
												end if;
												
									when D => output <= letternull;
												if(serial = '0') then
													future_state := A;
												else
													future_state := E;
												end if;
												
									when E => output <= letterA;
												if(serial = '0') then
													future_state := A;
												else
													future_state := B;
												end if;
								end case;
								 prescaler   <= (others => '0');
								else
									prescaler <= prescaler + "1";	
								end if;	
							end if;
					end if;
				end process;
		end Behavioral;