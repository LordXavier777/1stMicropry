library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Temp_SSD is
    port (
        clk   : in  std_logic; 
        start : in  std_logic;
        stop  : in  std_logic;
        reset : in  std_logic;
        
     
        out_min     : out std_logic_vector(6 downto 0);
        out_dec : out std_logic_vector(6 downto 0);
        out_uni : out std_logic_vector(6 downto 0));
		  
end entity;

architecture Behavioral of Temp_SSD is

    signal cnt_min : integer range 0 to 9 := 0;
    signal cnt_dec   : integer range 0 to 5 := 0; 
    signal cnt_uni   : integer range 0 to 9 := 0; 

   signal running : std_logic := '0';

    
    function decode_ssd(num : integer) return std_logic_vector is
    begin
        case num is
            when 0 => return "1000000"; 
            when 1 => return "1111001";
            when 2 => return "0100100";
            when 3 => return "0110000";
            when 4 => return "0011001";
            when 5 => return "0010010";
            when 6 => return "0000010";
            when 7 => return "1111000";
            when 8 => return "0000000";
            when 9 => return "0010000";
            when others => return "1111111"; 
        end case;
    end function;

begin
    process(clk, reset)
    begin
       
        if reset = '0' then
            cnt_min <= 0;
            cnt_dec   <= 0;
            cnt_uni   <= 0;
            running <= '0';
            
        elsif rising_edge(clk) then
            
            if start = '0' then
                running <= '1';
            elsif stop = '0' then
                running <= '0';
            end if;

           
            if running = '1' then
                if cnt_uni = 9 then
                    cnt_uni <= 0; 
                    
                    if cnt_dec = 5 then
                        cnt_dec <= 0; 
                        
                        if cnt_min = 9 then
                            cnt_min <= 0; 
                        else
                            cnt_min <= cnt_min + 1; 
                        end if;
                    else
                        cnt_dec <= cnt_dec + 1; 
                    end if;
                else
                    cnt_uni <= cnt_uni + 1; 
                end if;
            end if;
        end if;
    end process;

    
    out_min <= decode_ssd(cnt_min);
    out_dec <= decode_ssd(cnt_dec);
    out_uni <= decode_ssd(cnt_uni);

end architecture;