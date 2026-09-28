library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.package_1st.all;

entity Temp_one_button is --Temporizador de un solo boton
    port ( clk   : in  std_logic; 
			  btn   : in  std_logic; 
			  
			  sec_min : out std_logic_vector(6 downto 0);
			  sec_dec : out std_logic_vector(6 downto 0);
			  sec_uni : out std_logic_vector(6 downto 0));
		  
end entity;

architecture zzz of Temp_one_button is

   --señales internas para rutear los valores hacia los display
   signal cnt_min : integer range 0 to 9 := 0;
   signal cnt_dec   : integer range 0 to 5 := 0;
   signal cnt_uni   : integer range 0 to 9 := 0;


begin
    process(clk)
	 
	 --VARIABLES: Se usan en lugar de señales para que su actualización en memoria sea instantánea.
        -- Esto elimina los retrasos de reloj (latencia) al arrancar, pausar o reiniciar el sistema.
		  
        variable running  : std_logic := '0';
        variable hold_cnt : integer range 0 to 3 := 0;
    begin
        if rising_edge(clk) then
            
            if btn = '0' then 
                
                if hold_cnt < 3 then
                    hold_cnt := hold_cnt + 1; 
                end if;

               --RESET: Si se sostiene por 2 flancos de reloj (2 segundos continuos), 
                -- se fuerza el reinicio de los contadores y la pausa del sistema. 
                if hold_cnt = 2 then
                    cnt_min <= 0;
                    cnt_dec <= 0;
                    cnt_uni <= 0;
                    running := '0'; 
                end if;

            else
                -- ARRANQUE/PAUSA: Al soltar el botón, si el conteo registró menos 
                -- de 2 segundos, se interpreta como un "clic" corto y se alterna el estado.
					 
                if hold_cnt > 0 and hold_cnt < 2 then
                    running := not running; 
                end if;
                
                
                hold_cnt := 0; --Limpieza de la memoria del botón para la próxima interacción 
            end if;

            --Como v_running es una variable, si el estado cambió en el bloque superior,
            -- el temporizador lo detecta en este mismo instante, arrancando sin perder ciclos.
				
            if running = '1' and btn = '1' then
                if cnt_uni = 9 then
                    cnt_uni <= 0;
                    
                    if cnt_dec = 5 then
                        cnt_dec <= 0;
                        
                        if cnt_min = 9 then
                            cnt_min <= 0;
                        else
                            cnt_min <= cnt_min + 1;
                        end if;
                    else
                        cnt_dec <= cnt_dec + 1;
                    end if;
                else
                    cnt_uni <= cnt_uni + 1;
                end if;
            end if;
            
        end if;
    end process;

--  decodificación del valor matemático (integer) al formato 
    -- de 7 bits físico de los displays mediante la función del paquete.
    sec_min <= decode_ssd(cnt_min);
    sec_dec <= decode_ssd(cnt_dec);
    sec_uni <= decode_ssd(cnt_uni);

end architecture;