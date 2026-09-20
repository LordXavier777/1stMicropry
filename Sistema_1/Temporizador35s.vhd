library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Temporizador35s is
	port(clk_1s: in std_logic;
	     estado: in std_logic;
	     tiempo_35: out integer range 0 to 35;
		  led_good: out std_logic;
		  led_alarm: out std_logic);
end entity;

architecture archtemp of Temporizador35s is
	signal count: integer range 0 to 35 :=35;
begin
	process(clk_1s)
	begin	
		if rising_edge(clk_1s) then
			if estado='0' then
				if count> 0 and count<35 then
					led_good<='1';
				else
					led_good<='0';
				end if;
			
				count<=35;
				led_alarm<='0';
			else
				led_good<='0';
				if count>0 then
					count<= count - 1;
				else
					led_alarm<='1';
				end if;
			end if;
		end if;
	end process;
	
tiempo_35<=count;

end architecture;

		  