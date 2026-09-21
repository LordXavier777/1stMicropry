library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.package_1st.all;

entity Temp_SSD is
    port (
        clk   : in  std_logic; 
        start : in  std_logic;
        stop  : in  std_logic;
        reset : in  std_logic;
        
     
        out_min     : out std_logic_vector(6 downto 0);
        out_dec : out std_logic_vector(6 downto 0);
        out_uni : out std_logic_vector(6 downto 0));
		  
end entity;

architecture Comportamental of Temp_SSD is

    signal cnt_min : integer range 0 to 9 := 0;
    signal cnt_dec   : integer range 0 to 5 := 0; 
    signal cnt_uni   : integer range 0 to 9 := 0; 


begin
    process(clk, reset)
        -- La variable se declara estrictamente antes del 'begin' del proceso[cite: 10]
        variable v_running : std_logic := '0';
    begin
        -- 1. Reset Asíncrono Activo en Bajo
        if reset = '0' then
            cnt_min <= 0;
            cnt_dec   <= 0;
            cnt_uni   <= 0;
            v_running := '0'; -- Asignación inmediata con ':='[cite: 10]
            
        elsif rising_edge(clk) then
            
            -- 2. Lógica de botones (Actualización instantánea)
            if start = '0' then
                v_running := '1'; -- La variable toma el valor '1' de inmediato[cite: 10]
            elsif stop = '0' then
                v_running := '0';
            end if;

            -- 3. Lógica del Temporizador en Cascada
            -- Como v_running es una variable, si se activó arriba, esta línea ya la lee como '1' 
            -- en este mismo pulso de reloj, eliminando el retraso[cite: 9].
            if v_running = '1' then
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

    
    out_min <= decode_ssd(cnt_min);
    out_dec <= decode_ssd(cnt_dec);
    out_uni <= decode_ssd(cnt_uni);

end architecture;