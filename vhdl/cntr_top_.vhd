-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                cntr__top_.vhd
--
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The counter top unit is the top module of the counter project.
--				It connects the IO Control unit with the Counter unit,
--              derives a 1kHz-clock from the 100MHz-clock of the Digilent
--              Basys3 FPGA board and manages/forwards the asynchronous reset.
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

entity cntr_top is

    port (clk_i   : in  std_logic;                     -- 100MHz-clock
		  reset_i : in  std_logic;                     -- asynchronous high active reset
		  sw_i    : in  std_logic_vector(15 downto 0); -- 16 switches from board
		  pb_i    : in  std_logic_vector( 3 downto 0); -- 4 buttons from board
		  ss_o    : out std_logic_vector( 7 downto 0); -- 7 cathodes of one digit, '0' for ON
		  ss_sel_o: out std_logic_vector( 3 downto 0); -- 4 anodes for 4 digits, '0' for ON
		  led_o   : out unsigned(15 downto 0)          -- anodes of 16 leds on board
          );

end cntr_top;

