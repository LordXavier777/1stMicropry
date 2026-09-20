library ieee;
use ieee.std_logic_1164.all;
library work;
use work.package_1st.all;

entity System_3 is
	port( clk_general: in std_logic;
			start: in std_logic;
			
			disp_min: out std_logic_vector(6 downto 0);
			disp_dec: out std_logic_vector(6 downto 0);
			disp_uni: out std_logic_vector(6 downto 0));

end entity;

architecture Epsilon of System_3 is
	signal clk_1Hz: std_logic;
	
begin
	U1: Divisor_1Hz_NR port map(
			clk_50MHz => clk_general,
			clock_1s => clk_1Hz);
	U2: Temp_one_button port map(
			clk => clk_1Hz,
			btn => start,
			sec_min => disp_min,
			sec_dec => disp_dec,
			sec_uni => disp_uni);

end architecture;