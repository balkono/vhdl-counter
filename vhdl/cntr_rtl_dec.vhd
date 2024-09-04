-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                cntr_rtl.vhd
--
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The counter unit is part of the counter project.
--				It counts up/down/hold its value and provides the counted
--              values to the top module and then to the IO Control unit.
--
-------------------------------------------------------------------------------
--                                                                      
-- CHANGES:     V1.0:  5.04.2023: initial Version  
--
-------------------------------------------------------------------------------



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use IEEE.numeric_std_unsigned.all;

architecture rtl of cntr is
	signal s_cntr0 : unsigned(3 downto 0); 
    signal s_cntr1 : unsigned(3 downto 0);
    signal s_cntr2 : unsigned(3 downto 0);
    signal s_cntr3 : unsigned(3 downto 0);

begin	

	p_cntr: process(clk_i, reset_i)
    begin
		if reset_i = '1' then
            s_cntr <= "0000000000000000";
            
		elsif (clk_i'event and clk_i = '1') then        -- prioritisation of switches                                
            if cntrreset_i = '1' then                   -- 1) soft-reset                                  
                s_cntr3 <="0000";
                s_cntr2 <="0000";
                s_cntr1 <="0000";
                s_cntr0 <="0000";
                
            elsif cntrhold_i = '1' then 
                if cntrup_i = '1' then                  -- 2) counting up
                    if s_cntr0 ="1001" then
                        if s_cntr1 ="1001" then
                            if s_cntr2 ="1001" then
                                if s_cntr3 ="1001" then
                                    s_cntr3 <="0000";
                                else
                                    s_cntr3 <= s_cntr3 + 1;
                                end if;
                                s_cntr2 <= "0000";
                            else
                                s_cntr2 <= s_cntr2 + 1;
                            end if;
                            s_cntr1 <= "0000";
                        else
                            s_cntr1 <= s_cntr1 + 1;
                        end if;
                        s_cntr0 <= "0000";
                    else 
                        s_cntr0 <= s_cntr0 + 1;   
                    end if;
                                 
                    
                    
                elsif cntrdown_i = '1' then             -- 3) counting down
                    if s_cntr0 ="0000" then
                        if s_cntr1 ="0000" then
                            if s_cntr2 ="0000" then
                                if s_cntr3 ="0000" then
                                    s_cntr3 <="1001";
                                else
                                    s_cntr3 <= s_cntr3 - 1;
                                end if;
                                s_cntr2 <= "1001";
                            else
                                s_cntr2 <= s_cntr2 - 1;
                            end if;
                            s_cntr1 <= "1001";
                        else
                            s_cntr1 <= s_cntr1 - 1;
                        end if;
                        s_cntr0 <= "1001";
                    else 
                        s_cntr0 <= s_cntr0 - 1;   
                    end if;
                end if;
                
            else
                s_cntr0 <= s_cntr0;                       -- 4) holding the value
                s_cntr1 <= s_cntr1;
                s_cntr2 <= s_cntr2;
                s_cntr3 <= s_cntr3;
            end if;
        end if;
		
	end process p_cntr;
	cntr0_o <= s_cntr0;
    cntr1_o <= s_cntr1;
    cntr2_o <= s_cntr2;
    cntr3_o <= s_cntr3;
    
end rtl;
