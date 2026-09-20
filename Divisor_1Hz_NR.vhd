library ieee;
use ieee.std_logic_1164.all;

entity Divisor_1Hz_NR is
	port(clk_50MHz: in std_logic;
			clock_1s: out std_logic);
end entity;
	
architecture Behavioral of Divisor_1Hz_NR is
    
    signal contador : integer range 0 to 24999999 := 0;
    signal estado   : std_logic := '0';
begin
    process(clk_50MHz)
    begin
        if rising_edge(clk_50MHz) then
				if contador = 24999999 then
                contador <= 0;
                estado   <= not estado; 
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
    
 clock_1s <= estado;
 
end architecture;