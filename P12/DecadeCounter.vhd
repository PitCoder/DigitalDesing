library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package decadecounter is
	function int_to7seg (A:integer) return std_logic_vector;
	procedure seg_ctrl (signal NUMBER: in integer; signal digit1,digit2,digit3,digit4: out integer range 0 to 9);
end decadecounter;

package body decadecounter is
	function int_to7seg (A:integer) return std_logic_vector is
		variable result: std_logic_vector(7 downto 0);
		begin
			case A is
				when 0 => result := "00000011";
				when 1 => result := "10011111";
				when 2 => result := "00100101";
				when 3 => result := "00001101";
				when 4 => result := "10011001";
				when 5 => result := "01001001";
				when 6 => result := "11000001";
				when 7 => result := "00011111";
				when 8 => result := "00000001";
				when 9 => result := "00011001";
				when others => result := (others=>'0');
			end case;
		return result;
		end int_to7seg;
		---------------------------------------------
		
	procedure seg_ctrl (signal NUMBER: in integer; signal digit1,digit2,digit3,digit4: out integer range 0 to 9) is
		variable temp: integer range 0 to 9999;
		variable d1: integer range 0 to 9;
		variable d2: integer range 0 to 9;
		variable d3: integer range 0 to 9;
		variable d4: integer range 0 to 9;
		begin
			temp:=NUMBER;
			if(temp>999) then
				d4:=temp/1000;
				temp:=temp-d4*1000;
			else
				d4:=0;
			end if;
			
			if(temp>99) then
				d4:=temp/100;
				temp:=temp-d3*100;
			else
				d4:=0;
			end if;
			
			if(temp>9) then
				d4:=temp/10;
				temp:=temp-d2*10;
			else
				d4:=0;
			end if;
			
			d1:=temp;
			
			digit1 <= d1;
			digit2 <= d2;
			digit3 <= d3;
			digit4 <= d4;
			
		end seg_ctrl;
		---------------------------------------------
end decadecounter;