-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                cntr_.vhd
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

entity cntr is

    port (clk_i      :   in  std_logic;            -- 1kHz-clock
          reset_i    :   in  std_logic;            -- asynchronous high active reset
          cntrup_i   :   in  std_logic;            -- switch to count up
          cntrdown_i :   in  std_logic;            -- switch to count down 
          cntrreset_i:   in  std_logic;            -- switch for soft reset of counter
          cntrhold_i :   in  std_logic;            -- switch to hold current value
          cntr0_o    :  out  unsigned(3 downto 0); -- counter for digit0
          cntr1_o    :  out  unsigned(3 downto 0); -- counter for digit1
          cntr2_o    :  out  unsigned(3 downto 0); -- counter for digit2
          cntr3_o    :  out  unsigned(3 downto 0)  -- counter for digit3
          );                                       
                                                 
end cntr;                                        

