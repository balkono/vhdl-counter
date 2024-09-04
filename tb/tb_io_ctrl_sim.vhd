-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                tb_io_ctrl_sim.vhd
--  
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The architecture of the IO Control unit of the counter project.
--
-------------------------------------------------------------------------------
--                                                                      
-- CHANGES:     V1.0:  5.04.2023: initial Version      
--
------------------------------------------------------------------------------- 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.numeric_std_unsigned.all;

architecture sim of tb_io_ctrl is

  component io_ctrl
  port (clk_i   : in  std_logic;                     -- 1kHz-clock
		reset_i : in  std_logic;                     -- asynchronous high active reset
		cntr0_i : in  unsigned( 3 downto 0);         -- counter for 7-segment digit0
		cntr1_i : in  unsigned( 3 downto 0);         -- counter for 7-segment digit1
		cntr2_i : in  unsigned( 3 downto 0);         -- counter for 7-segment digit2
		cntr3_i : in  unsigned( 3 downto 0);         -- counter for 7-segment digit3
		sw_i    : in  std_logic_vector(15 downto 0); -- 16 switches from board
		pb_i    : in  std_logic_vector( 3 downto 0); -- 4 buttons from board
		ss_o    : out std_logic_vector( 7 downto 0); -- 7 cathodes of one digit, '0' for ON
		ss_sel_o: out std_logic_vector( 3 downto 0); -- 4 anodes for 4 digits, '0' for ON
		swsync_o: out std_logic_vector(15 downto 0); -- 16 debounced switches to top module
		pbsync_o: out std_logic_vector( 3 downto 0); -- 4 debounced buttons to top module
		led_o   : out unsigned(15 downto 0)          -- anodes of 16 leds on board
		);
        
  end component;
  
  signal clk_i   : std_logic:= '0';
  signal reset_i : std_logic:= '1';
  signal cntr0_i : unsigned( 3 downto 0):="0000";
  signal cntr1_i : unsigned( 3 downto 0):="1111"; -- set to FFh for overflow, set to 00h to count from start
  signal cntr2_i : unsigned( 3 downto 0):="1111"; -- set to FFh for overflow, set to 00h to count from start
  signal cntr3_i : unsigned( 3 downto 0):="1111"; -- set to FFh for overflow, set to 00h to count from start
  signal sw_i    : std_logic_vector(15 downto 0):="0000000000000000";
  signal pb_i    : std_logic_vector( 3 downto 0):="0000";
  signal ss_o    : std_logic_vector( 7 downto 0);
  signal ss_sel_o: std_logic_vector( 3 downto 0);
  signal swsync_o: std_logic_vector(15 downto 0);
  signal pbsync_o: std_logic_vector( 3 downto 0);
  signal led_o   : unsigned(15 downto 0);
											 
begin                                        

  -- Instantiate the io_ctrl design for testing
  i_io_ctrl : io_ctrl
  port map              
    (clk_i    => clk_i,
     reset_i  => reset_i,
     cntr0_i  => cntr0_i,
     cntr1_i  => cntr1_i,
     cntr2_i  => cntr2_i,
     cntr3_i  => cntr3_i,
     sw_i     => sw_i,
     pb_i     => pb_i,
     ss_o     => ss_o,
     ss_sel_o => ss_sel_o,          
     swsync_o => swsync_o,
     pbsync_o => pbsync_o,
     led_o    => led_o);

  clk_i <= not(clk_i) after 5 us; -- 1kHz clock
  
  p_reset : process     -- testing of asynchronous reset
    begin
      wait for 10 us;
      reset_i <= '0';
    end process;
  
  -- testing of counter-outputs with and without overflow
  p_counter0: process   
    begin
      wait for 1 ms;
      cntr0_i <= cntr0_i + 1;
    end process;
  
  p_counter1: process   
    begin
      wait for 1*16 ms; 
      cntr1_i <= cntr1_i + 1;
    end process;
  
  p_counter2: process   
    begin
      wait for 1*16 ms;
      cntr2_i <= "0000";
      --wait for 1*256 ms;
      --cntr2_i <= cntr2_i + 1;
    end process;
  
  p_counter3: process
    begin
      wait for 1*16 ms;
      cntr3_i <= "0000";
      --wait for 1*4096 ms;
      --cntr3_i <= cntr3_i + 1;
    
    
    end process;
  
  p_buttons: process    -- testing latching of the buttons
    begin
      wait for 4 ms;
      pb_i <= "0001";
      wait for 4 ms;
      pb_i <= "0010";
      wait for 4 ms;
      pb_i <= "0100";
      wait for 4 ms;
      pb_i <= "1000";
      wait for 4 ms;
      pb_i <= "1010";
    end process;
    
  p_switches: process   -- testing latching of the switches
    begin
      wait for 4 ms;
      sw_i <= "0000000000000001";
      wait for 4 ms;
      sw_i <= "0000000000000011";
      wait for 4 ms;
      sw_i <= "0000000000000111";
      wait for 4 ms;
      sw_i <= "0000000000001111";
      wait for 4 ms;
      sw_i <= "0000000000011111";
      wait for 4 ms;
      sw_i <= "1000000000000000";
      wait for 4 ms;
      sw_i <= "1100000000000000";
      wait for 4 ms;
      sw_i <= "1110000000000000";
      wait for 4 ms;
      sw_i <= "1111000000000000";
      wait for 4 ms;
      sw_i <= "1111100000000000";
    end process;
  

end sim;

