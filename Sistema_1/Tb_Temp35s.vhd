library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.package_1st.all;

entity Tb_Temp35s is
end entity;

architecture archone of Tb_Temp35s is
  signal clk_tb: std_logic :='0';
  signal estado_tb: std_logic :='0';
  signal good_tb: std_logic;
  signal alarm_tb: std_logic;
  signal t_35_tb: integer range 0 to 35;
  
  constant clk_period: time:= 10 ns;
  
begin
  DUT: Temporizador35s port map(
    clk_1s => clk_tb,
    estado => estado_tb,
    led_good => good_tb,
    led_alarm => alarm_tb,
    tiempo_35 => t_35_tb);

    
    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;
    
    stimulus: process
    begin
      estado_tb<='0';
      wait for 30 ns;
      
      estado_tb<='1';
      wait for 100 ns;
      estado_tb<='0';
      wait for 30 ns;
      
      estado_tb<='1';
      wait for 380 ns;
      
      estado_tb<='0';
      wait for 50 ns;
      
      wait;
    end process;
end architecture;