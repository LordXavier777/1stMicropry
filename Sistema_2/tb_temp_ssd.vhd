library ieee;
use ieee.std_logic_1164.all;

entity tb_temp_ssd is
end entity;

architecture ssd_temp of tb_temp_ssd is
  
  component Temp_SSD is
    port(clk,start,reset,stop: in std_logic;
        out_min,out_dec,out_uni: std_logic_vector(6 downto 0));
  
  end component;

  signal clk_tb: std_logic :='0';
  signal start_tb: std_logic :='1';
  signal reset_tb: std_logic :='1';
  signal stop_tb: std_logic :='1';
  
  signal out_min_tb: std_logic_vector(6 downto 0);
  signal out_dec_tb: std_logic_vector(6 downto 0);
  signal out_uni_tb: std_logic_vector(6 downto 0));
  
  constant clk_period: time:= 10 ns;
  
    

 