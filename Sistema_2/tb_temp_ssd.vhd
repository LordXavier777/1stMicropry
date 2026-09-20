library ieee;
use ieee.std_logic_1164.all;

entity tb_temp_ssd is
end entity;

architecture ssd_temp of tb_temp_ssd is

    component Temp_SSD is
        port(
            clk, start, reset, stop : in std_logic;
            out_min, out_dec, out_uni : out std_logic_vector(6 downto 0)
        );
    end component;

    signal clk_tb       : std_logic := '0';
    signal start_tb     : std_logic := '1';
    signal reset_tb     : std_logic := '1';
    signal stop_tb      : std_logic := '1';

    signal out_min_tb   : std_logic_vector(6 downto 0);
    signal out_dec_tb   : std_logic_vector(6 downto 0);
    signal out_uni_tb   : std_logic_vector(6 downto 0);

    constant clk_period : time := 10 ns;

begin

    U1: Temp_SSD port map(
        clk     => clk_tb,
        start   => start_tb,
        reset   => reset_tb,
        stop    => stop_tb,
        out_min => out_min_tb,
        out_dec => out_dec_tb,
        out_uni => out_uni_tb
    );

    clk_process: process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    stimulus: process
    begin

        reset_tb <= '0';
        wait for 20 ns;
        reset_tb <= '1';
        wait for 20 ns;

        start_tb <= '0';
        wait for 20 ns;
        start_tb <= '1';
        wait for 150 ns;

        stop_tb <= '0';
        wait for 20 ns;
        stop_tb <= '1';
        wait for 50 ns;

        start_tb <= '0';
        wait for 20 ns;
        start_tb <= '1';
        wait for 400 ns;

        reset_tb <= '0';
        wait for 20 ns;
        reset_tb <= '1';
        wait for 30 ns;

        wait;
    end process;

end architecture;