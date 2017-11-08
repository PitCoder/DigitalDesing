library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package decadecounter is
	function log2 (X : integer) return integer;
	function unsigned_to7seg (A:unsigned(3 downto 0)) return std_logic_vector;
	procedure seg_ctrl (variable counter: in integer; variable digit1,digit2,digit3,digit4: out unsigned(3 downto 0));
end decadecounter;

package body decadecounter is
	function log2 (X : integer) return integer is
      variable i : integer;
   begin
      i := 0;  
      while (2**i < x) and i < 31 loop
         i := i + 1;
      end loop;
      return i;
   end log2;
	
	function unsigned_to7seg (A:unsigned(3 downto 0)) return std_logic_vector is
		variable result: std_logic_vector(7 downto 0);
		begin
			case A is
				when "0000" => result := "00000011";
				when "0001" => result := "10011111";
				when "0010" => result := "00100101";
				when "0011" => result := "00001101";
				when "0100" => result := "10011001";
				when "0101" => result := "01001001";
				when "0110" => result := "11000001";
				when "0111" => result := "00011111";
				when "1000" => result := "00000001";
				when others => result := "00011001";
			end case;
		return result;
		end unsigned_to7seg;
		---------------------------------------------
		
	procedure seg_ctrl (variable counter: in integer; variable digit1,digit2,digit3,digit4: out unsigned(3 downto 0)) is
		variable binary: unsigned(15 downto 0);
		variable d1: unsigned(3 downto 0):="0000";
		variable d2: unsigned(3 downto 0):="0000";
		variable d3: unsigned(3 downto 0):="0000";
		variable d4: unsigned(3 downto 0):="0000";
		variable i: integer:= 0;
		constant shifts: integer:= log2(counter);
		
		begin
			binary:= to_unsigned(counter,16);
			binary:= binary sll (16-shifts);
			
			while (i<shifts) loop
					if(i<5) then
						d4:= d4 sll 1;
						d4(0):= binary(15);
							if(d4>4) then
								d4:= d4 + "11";
							end if;
					elsif(i>4 and i<9) then
						d3:= d3 sll 1;
						d3(0):= d4(3);
							if(d3>4) then
								d3:= d3 + "11";
							end if;
							
						d4:= d4 sll 1;
						d4(0):= binary(15);
							if(d4>4) then
								d4:= d4 + "11";
							end if;
					elsif(i>8 and i<13) then
						d2:= d2 sll 1;
						d2(0):= d3(3);
							if(d2>4) then
								d2:= d2 + "11";
							end if;
							
						d3:= d3 sll 1;
						d3(0):= d4(3);
							if(d3>4) then
								d3:= d3 + "11";
							end if;
							
						d4:= d4 sll 1;
						d4(0):= binary(15);
							if(d4>4) then
								d4:= d4 + "11";
							end if;
					else
						d1:= d1 sll 1;
						d1(0):= d2(3);
							if(d1>4) then
								d1:= d1 + "11";
							end if;
							
						d2:= d2 sll 1;
						d2(0):= d3(3);
							if(d2>4) then
								d2:= d2 + "11";
							end if;
							
						d3:= d3 sll 1;
						d3(0):= d4(3);
							if(d3>4) then
								d3:= d3 + "11";
							end if;
							
						d4:= d4 sll 1;
						d4(0):= binary(15);
							if(d4>4) then
								d4:= d4 + "11";
							end if;
					end if;
					binary:=binary sll 1;
					i:= i+1;
			end loop;
			digit1:= d1;
			digit2:= d2;
			digit3:= d3;
			digit4:= d4;
		end seg_ctrl;
		---------------------------------------------
end decadecounter;