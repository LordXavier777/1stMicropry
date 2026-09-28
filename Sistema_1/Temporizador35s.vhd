library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Temporizador descendente principal: Controla el tiempo de permanencia máximo (35s)
-- Activa la alarma si el tiempo se agota, o un indicador de exito si el espacio se libera antes

entity Temporizador35s is
	port(clk_1s: in std_logic;
	     estado: in std_logic;
	     tiempo_35: out integer range 0 to 35;
		  led_good: out std_logic;
		  led_alarm: out std_logic;
		  led_prof: out std_logic);
end entity;

architecture archtemp of Temporizador35s is
	signal count: integer range 0 to 35 :=35;
begin
	process(clk_1s)
	begin	
		if rising_edge(clk_1s) then
		
			if estado='0' then -- espacio libre
				if count> 0 and count<35 then -- si la persona se retira antes de que el contador llegue a 0, se enciende el led de felicitacion
					led_good<='1';
				else
					led_good<='0';
				end if;
			
				count<=35; --se reinicia el conteo para el próximo ciclo y se apaga lalarmas
				led_alarm<='0';
				
			else              -- estado = '1' significa que se detectó una presencia
				led_good<='0';
				if count>0 then
					count<= count - 1;
				else
					led_alarm<='1'; -- al agotarse el tiempo el contador se congela y se dispara la alarma
				end if;
			end if;
			
		end if;
	end process;
	
tiempo_35<=count;

led_prof<=clk_1s when (count>0 and count<35) else '0';


end architecture;

		  