library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.package_1st.all;

entity Temp_one_button is
    port ( clk   : in  std_logic; 
			  btn   : in  std_logic; 
			  
			  min     : out std_logic_vector(6 downto 0);
			  sec_dec : out std_logic_vector(6 downto 0);
			  sec_uni : out std_logic_vector(6 downto 0));
		  
end entity;

architecture zzz of temp_one_button is

   signal cnt_min : integer range 0 to 9 := 0;
   signal cnt_dec   : integer range 0 to 5 := 0;
   signal cnt_uni   : integer range 0 to 9 := 0;

   
   signal running : std_logic := '0';
	signal btn_cnt : integer range 0 to 3 := 0;

    

begin
    process(clk)
    begin
        if rising_edge(clk) then
            
				if btn = '0' then 
                
                if btn_cnt < 3 then
                    btn_cnt <= btn_cnt + 1; 
                end if;
                
                
                if btn_cnt = 2 then
                    cnt_min <= 0;
                    cnt_dec   <= 0;
                    cnt_uni   <= 0;
                    running <= '0'; 
                end if;
                
            else
                
                if btn_cnt > 0 and btn_cnt < 2 then
                   
                    running <= not running; 
                end if;
                
                
                btn_cnt <= 0; 
            end if;

           
          
            if running = '1' and btn = '1' then
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

    
    min     <= decode_ssd(cnt_min);
    sec_dec <= decode_ssd(cnt_dec);
    sec_uni <= decode_ssd(cnt_uni);

end architecture;