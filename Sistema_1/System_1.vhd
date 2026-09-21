library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.package_1st.all;

entity System_1 is
	port(clk_general: in std_logic;
			estado: in std_logic;
			led_alert: out std_logic;
			led_GJ: out std_logic;
			disp_uni: out std_logic_vector(6 downto 0);
			disp_dec: out std_logic_vector(6 downto 0));
			
end entity;

architecture Ryze of System_1 is
	signal clk_1Hz: std_logic;
	
	signal bcd_uni: std_logic_vector(3 downto 0);
	signal bcd_dec: std_logic_vector(3 downto 0);
	
	signal alerta: std_logic;
	
	signal t_35: integer range 0 to 35;
	signal tiempo_extra: integer range 0 to 99;
	signal t_final: integer range 0 to 99;
	
begin
	U1: Divisor_1Hz_NR port map(
			clk_50MHz => clk_general,
			clock_1s  => clk_1Hz);

    
    U2: Temporizador35s port map (
        clk_1s     => clk_1Hz,
        estado     => estado,
        tiempo_35  => t_35,
        led_alarm  => alerta,
        led_good   => led_GJ);

  
    U3: Temporizador_extra port map (
        clk_1s       => clk_1Hz,
        estado       => estado,
        en_alarm     => alerta, 
        t_extra      => tiempo_extra);
		  
	t_final<= tiempo_extra when alerta='1' else t_35;

	bcd_dec<= conv_std_logic_vector(t_final/10,4);
	bcd_uni<= conv_std_logic_vector(t_final mod 10,4);

	led_alert<=alerta;
	
	U4: BCD_7seg port map(V => bcd_dec, d => disp_dec);
	U5: BCD_7seg port map(V => bcd_uni, d => disp_uni);
	

end architecture;

