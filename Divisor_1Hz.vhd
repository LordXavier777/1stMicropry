library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Divisor_1Hz is
    port (
        clk_50MHz : in  std_logic;
        reset     : in  std_logic;
        clk_1s    : out std_logic
    );
end entity;

architecture Behavioral of Divisor_1Hz is
    
    signal contador : integer range 0 to 24999999 := 0;
    signal estado   : std_logic := '0';
begin
    process(clk_50MHz, reset)
    begin
        
        if reset = '0' then
            contador <= 0;
            estado   <= '0';
        
        elsif rising_edge(clk_50MHz) then
            if contador = 24999999 then
                contador <= 0;
                estado   <= not estado; 
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
    
    
    clk_1s <= estado;
end architecture;