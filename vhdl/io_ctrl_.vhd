-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                io_ctrl_.vhd
--  
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.1
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The IO Control unit is part of the counter project.
--				It manages the interface to the 7-segment displays,
--				the LEDs, the push buttons and the switches of the
--				Digilent Basys3 FPGA board   
--
-------------------------------------------------------------------------------
--                                                                      
-- CHANGES:     V1.0: 31.03.2023: initial Version    
--              V1.1:  5.04.2023: changed cntrX_i to unsigned   
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use IEEE.numeric_std_unsigned.all;

entity io_ctrl is

	port (clk_i  : in  std_logic;                      -- 1kHz-clock
		  reset_i: in  std_logic;                      -- asynchronous high active reset
		  cntr0_i: in  unsigned( 3 downto 0);          -- counter for 7-segment digit0
		  cntr1_i: in  unsigned( 3 downto 0);          -- counter for 7-segment digit1
		  cntr2_i: in  unsigned( 3 downto 0);          -- counter for 7-segment digit2
		  cntr3_i: in  unsigned( 3 downto 0);          -- counter for 7-segment digit3
		  sw_i   : in  std_logic_vector(15 downto 0);  -- 16 switches from board
		  pb_i   : in  std_logic_vector( 3 downto 0);  -- 4 buttons from board
		  ss_o   : out std_logic_vector( 7 downto 0);  -- 7 cathodes of one digit, '0' for ON
		  ss_sel_o: out std_logic_vector( 3 downto 0); -- 4 anodes for 4 digits, '0' for ON
		  swsync_o: out std_logic_vector(15 downto 0); -- 16 debounced switches to top module
		  pbsync_o: out std_logic_vector( 3 downto 0); -- 4 debounced buttons to top module
		  led_o   : out unsigned(15 downto 0)          -- anodes of 16 leds on board
		  );
          
end io_ctrl;

