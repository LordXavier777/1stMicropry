library ieee;
use ieee.std_logic_1164.all;
library work;
use work.package_1st.all;

entity tb_temp_one_button is
  
end entity;

architecture try_out of tb_temp_one_button is
  
  component Temp_one_button is
    port( clk,btn: in std_logic;
          sec_min,sec_dec,sec_uni: std_logic_vector(6 downto 0));
  end component;
  
  signal clk_tb: std_logic :='0';
  signal btn_tb: std_logic :='1';
  signal sec_min_tb, sec_dec_tb, sec_uni_tb: std_logic_vector(6 downto 0);
  
  constant clk_period: time := 10 ns;
  
begin
  DUT: Temp_one_button port map(
      clk => clk_tb,
      btn => btn_tb,
      sec_min => sec_min_tb,
      sec_dec => sec_dec_tb,
      sec_uni => sec_uni_tb);
    
  clk_process: process
  begin
    clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;
    
  stimulus: process
    begin
        -- =========================================================
        -- CASO 1: Condición Inicial (Sistema en reposo)
        -- =========================================================
        btn_tb <= '1'; -- Botón sin presionar
        wait for 30 ns; 
        
        -- =========================================================
        -- CASO 2: Arranque (Toque corto de menos de 2 ciclos)
        -- =========================================================
        btn_tb <= '0'; -- Simulamos el clic del usuario[cite: 11]
        wait for 10 ns; -- Lo mantenemos 1 ciclo (1 segundo virtual)
        btn_tb <= '1'; -- Soltamos el botón rápido[cite: 11]
        
        -- Dejamos que el reloj avance libremente para ver el conteo
        wait for 150 ns; 

        -- =========================================================
        -- CASO 3: Pausa (Otro toque corto)
        -- =========================================================
        btn_tb <= '0'; 
        wait for 10 ns; 
        btn_tb <= '1'; 
        
        -- Dejamos pasar el tiempo para confirmar que el contador está congelado
        wait for 50 ns;

        -- =========================================================
        -- CASO 4: Reanudación
        -- =========================================================
        btn_tb <= '0'; 
        wait for 10 ns;
        btn_tb <= '1'; 
        
        wait for 100 ns;

        -- =========================================================
        -- CASO 5: Reinicio general (Toque largo mayor a 2 ciclos)
        -- =========================================================
        btn_tb <= '0'; 
        -- Lo mantenemos presionado por 30 ns (equivale a 3 segundos virtuales)
        
        wait for 30 ns; 
        btn_tb <= '1';

        wait for 50 ns;

        wait; 
    end process;

end architecture;
  
