library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Temporizador_extra is
	port(clk_1s: in std_logic;
	     estado: in std_logic;
		  en_alarm: in std_logic;
		  t_extra: out integer range 0 to 99);
end entity;

architecture temp_xtra of Temporizador_extra is
	signal count: integer range 0 to 99 :=0; --registro interno inicializado en 0 para acumular los segundos extra
begin
	process(clk_1s)
	begin
		if rising_edge(clk_1s) then
			if estado='0' then --estado = '0' (Ausencia / Salida de la persona)
				count<=0;
			else
				if en_alarm='1' then --estado = '1' (Presencia detectada)
					if count<99 then --evita el desbordamiento en los displays de 2 dígitos
						count<= count + 1;
					end if;
				end if;
			end if;
		end if;
	end process;
t_extra<= count; --asignacion de la señal de conteo a la salida de la entidad

end architecture;