library ieee;
use ieee.std_logic_1164.all;
library work;
use work.package_1st.all;

entity System_3 is --entidad general
	port( clk_general: in std_logic;
			start: in std_logic; --boton que pausa, para y renicia, se llamó asi por conveniencia para la asignacion de pines a la FPGA
			
			disp_min: out std_logic_vector(6 downto 0);
			disp_dec: out std_logic_vector(6 downto 0);
			disp_uni: out std_logic_vector(6 downto 0);
			punto_DP: out std_logic);
end entity;

architecture Epsilon of System_3 is
	signal clk_1Hz: std_logic; --Cable interno de cobre que transporta el reloj ya reducido (1 Hz)
	
begin

   --uso la versión "No Reset" (NR) para que el reloj de 1 Hz nunca se congele. 
    -- Así el temporizador siempre tendrá "latidos" para poder medir cuánto tiempo se sostiene el botón.
	 
	U1: Divisor_1Hz_NR port map(
			clk_50MHz => clk_general,
			clock_1s => clk_1Hz);
			
	U2: Temp_one_button port map( --instancia de la entidad que realiza el conteo
			clk => clk_1Hz,
			btn => start,
			sec_min => disp_min,
			sec_dec => disp_dec,
			sec_uni => disp_uni);
			
			punto_DP<='0';

end architecture;