library ieee;
use ieee.std_logic_1164.all;

library work;
use work.package_1st.all;

entity System_2 is
	port(	clk_general: in std_logic;
			start: in std_logic;
			stop: in std_logic;
			rst: in std_logic;
			
			disp_min: out std_logic_vector(6 downto 0);
			disp_dec: out std_logic_vector(6 downto 0);
			disp_uni: out std_logic_vector(6 downto 0);
			
			punto_DP: out std_logic);
			
end entity;

architecture Gamma of System_2 is
	signal clock_1Hz: std_logic; --creacion de la señal que conecta la salida del divisor de frecuencia a la entrada del contador
	
begin
	U1: Divisor_1Hz port map( --Instancia del divisor de frecuencia
		clk_50MHz => clk_general,
		reset => rst,
		clk_1s => clock_1Hz);
		
	U2: Temp_SSD port map(  --Instancia del contador que contiene la logica general de conteo para la entidad
									-- la información ya empaquetada va hacia los pines de salida de la FPGA mediante la entidad general
			clk => clock_1Hz,
			start => start,
			stop => stop,
			reset => rst,
			out_min => disp_min,
			out_dec => disp_dec,
			out_uni => disp_uni);
			
			punto_DP<='0'; --asignacion del punto para el display

end architecture;			
	