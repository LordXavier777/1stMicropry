library ieee;
use ieee.std_logic_1164.all;

entity Divisor_1Hz_NR is --Es el mismo divisor de frecuencia de 1Hz pero sin reset--
	port(clk_50MHz: in std_logic;
			clock_1s: out std_logic);
end entity;
	
architecture Behavioral of Divisor_1Hz_NR is
    
    signal contador : integer range 0 to 24999999 := 0; --Limite de cuenta para medio periodo 50,000,000/2 - 1 = 24,999,999--
    signal estado   : std_logic := '0'; --Señal intermedia para almacenar y conmutar el estado del reloj de salida--
begin
    process(clk_50MHz)
    begin
        if rising_edge(clk_50MHz) then --Al alcanzar medio periodo, reinicia la cuenta e invierte el estado 
		  
				if contador = 24999999 then  --para crear un reloj con un ciclo de trabajo del 50%
                contador <= 0;
                estado   <= not estado; 
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
    
 clock_1s <= estado;
 
end architecture;