library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_7seg is
	port(V  : in std_logic_vector(3 downto 0);
	     d  : out std_logic_vector(6 downto 0));
end entity;

architecture archi of BCD_7seg is
begin
	process(V) begin
		case V is
			when "0000" =>d<= "0000001";
			when "0001" =>d<= "1001111";
			when "0010" =>d<= "0010010";
			when "0011" =>d<= "0000110";
			when "0100" =>d<= "1001100";
			when "0101" =>d<= "0100100";
			when "0110" =>d<= "0100000";
			when "0111" =>d<= "0001111";
			when "1000" =>d<= "0000000";
			when "1001" =>d<= "0000100";
			when others =>d<= "1111111";
		end case;
	end process;
end architecture;