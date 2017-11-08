library ieee;
use ieee.std_logic_1164.all;

entity BCDTO7 is
	port(
		ent: in std_logic_vector(1 downto 0);
		sal: out std_logic_vector(6 downto 0)
	);

	attribute pin_numbers of BCDTO7: entity is
	"ent(0):1 ent(1):2 sal(0):14 sal(1):15 sal(2):16 "
	& " sal(3):17 sal(4):18 sal(5):19 sal(6):20";

end BCDTO7;

architecture ABCDTO7 of BCDTO7 is begin
	process(ent) begin
		case(ent) is
			when "00" 	=> sal<="0000001";
			when "01" 	=> sal<="1001111";
			when "10" 	=> sal<="0010010";
			when others => sal<="0000110";
		end case;
	end process;
end ABCDTO7;