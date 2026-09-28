library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Divisor_1Hz is --Reduce el reloj base de la FPGA (50MHz) a una señal de 1Hz--
    port (
        clk_50MHz : in  std_logic;
        reset     : in  std_logic;
        clk_1s    : out std_logic
    );
end entity;

architecture Behavioral of Divisor_1Hz is
    
    signal contador : integer range 0 to 24999999 := 0; --Limite de cuenta para medio periodo: 50,000,000/2 - 1 = 24,999,999
    signal estado   : std_logic := '0'; --señal intermedia para almacenar y conmutar el estado del reloj de salida--
begin
    process(clk_50MHz, reset)
    begin
        
        if reset = '0' then
            contador <= 0;
            estado   <= '0';
        
        elsif rising_edge(clk_50MHz) then
            if contador = 24999999 then     --Al alcanzar medio periodo, reinicia la cuenta e invierte el estado
                contador <= 0;              --para crear un reloj con un ciclo de trabajo del 50%--
                estado   <= not estado; 
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
    
    
    clk_1s <= estado; --Se asigna a la señal de salida de 1Hz la señal que almacena el estado del reloj--
end architecture;