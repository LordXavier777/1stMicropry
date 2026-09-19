library ieee;
use ieee.std_logic_1164;
package package_1st is
	component Temporizador35s is
		port(clk_1s, estado: in std_logic;
				led_good,led_alarm out: std_logic;
				tiempo_35: out integer range 0 to 35);
	end component;
	
	component Temporizador_extra is
		port(clk_1s, estado,en_alarm: in std_logic;
				t_extra: out integer range 0 to 99);
	end component;
	
	component BCD_7seg is
		port(V  : in std_logic_vector(3 downto 0);
	     d  : out std_logic_vector(6 downto 0));
	end component;
	
	component Divisor_1Hz_NR is
		port(clk_50MHz: in std_logic;
				clock_1s: out std_logic);
	end component;
end package_1st;
		
