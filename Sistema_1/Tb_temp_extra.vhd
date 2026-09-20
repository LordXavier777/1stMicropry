library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.package_1st.all;

entity Tb_temp_extra is
end entity;

architecture test of Tb_temp_extra is

    signal clk_tb     : std_logic := '0';
    signal estado_tb  : std_logic := '0';
    signal alarm_in_tb: std_logic := '0';
    signal t_extra_tb : integer range 0 to 99;

    constant clk_period : time := 10 ns; 

begin

    DUT: Temporizador_extra port map (
        clk_1s     => clk_tb,
        estado     => estado_tb,
        en_alarm   => alarm_in_tb,
        t_extra    => t_extra_tb
    );

    clk_process : process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    stimulus: process
    begin
       
        estado_tb   <= '0';
        alarm_in_tb <= '0';
        wait for 30 ns;

        estado_tb   <= '1';
        wait for 50 ns; 

        
        alarm_in_tb <= '1';
        wait for 150 ns; 

        
        estado_tb   <= '0';
        alarm_in_tb <= '0';
        wait for 50 ns; 

        wait;
    end process;

end architecture;
