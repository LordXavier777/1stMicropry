library ieee;
use ieee.std_logic_1164.all;

package package_1st is

	component Temporizador35s is
		port(clk_1s: in std_logic;
				estado: in std_logic;
				led_good: out std_logic;
				led_alarm: out std_logic;
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
	
	component Divisor_1Hz is
		port(clk_50MHz : in  std_logic;
        reset     : in  std_logic;
        clk_1s    : out std_logic);
	end component;
	
	component Temp_SSD is
		port(	clk,start,stop,reset: in std_logic;
				out_min,out_dec,out_uni: out std_logic_vector(6 downto 0));
	end component;
	
	function decode_ssd(num : integer) return std_logic_vector;
	
end package_1st;

package body package_1st is

    function decode_ssd(num : integer) return std_logic_vector is
    begin
        case num is
            when 0 => return "0000001"; 
            when 1 => return "1001111"; 
            when 2 => return "0010010"; 
            when 3 => return "0000110"; 
            when 4 => return "1001100"; 
            when 5 => return "0100100"; 
            when 6 => return "0100000"; 
            when 7 => return "0001111"; 
            when 8 => return "0000000"; 
            when 9 => return "0000100"; 
            when others => return "1111111"; 
        end case;
    end function;

end package body package_1st;