library ieee;
use ieee.std_logic_1164.all;
library work;
use work.package_1st.all;

entity tb_temp_one_button is
  
end entity;

architecture try_out of tb_temp_one is
  
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
      
  
