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
	signal s_cntr : unsigned(15 downto 0); 

begin	

	p_cntr: process(clk_i, reset_i)
    begin
		if reset_i = '1' then
            s_cntr <= "0000000000000000";
            
		elsif (clk_i'event and clk_i = '1') then        -- prioritisation of switches                                
            if cntrreset_i = '1' then                   -- 1) soft-reset                                  
                s_cntr <= "0000000000000000";
                
            elsif cntrhold_i = '1' then 
                if cntrup_i = '1' then                  -- 2) counting up
                    if s_cntr = "1111111111111111" then
                        s_cntr <= "0000000000000000";
                        
                    else
                        s_cntr <= s_cntr + 1;
                    end if;
                    
                elsif cntrdown_i = '1' then             -- 3) counting down
                    if s_cntr = "0000000000000000" then
                        s_cntr <= "1111111111111111";

                    else
                        s_cntr <= s_cntr - 1;
                    end if;
                end if;
                
            else
                s_cntr <= s_cntr;                       -- 4) holding the value
            end if;
        end if;
		
	end process p_cntr;
	cntr0_o <= s_cntr( 3 downto  0);
    cntr1_o <= s_cntr( 7 downto  4);
    cntr2_o <= s_cntr(11 downto  8);
    cntr3_o <= s_cntr(15 downto 12);
    
end rtl;
