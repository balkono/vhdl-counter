-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                tb_cntr_top_sim.vhd
--  
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The architecture of the top-level module counter top unit
--              of the counter project.
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

architecture sim of tb_cntr_top is

	component cntr_top
	port (clk_i   : in  std_logic;                     -- 100MHz-clock
          reset_i : in  std_logic;                     -- asynchronous high active reset
          sw_i    : in  std_logic_vector(15 downto 0); -- 16 switches from board
          pb_i    : in  std_logic_vector( 3 downto 0); -- 4 buttons from board
          ss_o    : out std_logic_vector( 7 downto 0); -- 7 cathodes of one digit, '0' for ON
          ss_sel_o: out std_logic_vector( 3 downto 0); -- 4 anodes for 4 digits, '0' for ON
          led_o   : out unsigned(15 downto 0)          -- anodes of 16 leds on board
        );
	end component;
	
	signal clk_i   : std_logic:='0'; 
	signal reset_i : std_logic:='1'; 
	signal sw_i    : std_logic_vector(15 downto 0):="0000000000000011"; 
	signal pb_i    : std_logic_vector( 3 downto 0):="0000"; 
    signal ss_o    : std_logic_vector( 7 downto 0); 
    signal ss_sel_o: std_logic_vector( 3 downto 0); 
    signal led_o   : unsigned(15 downto 0);

	begin                                        

	i_cntr_top : cntr_top
	port map              
		(clk_i   => clk_i,   
		 reset_i => reset_i, 
		 sw_i    => sw_i,    
		 pb_i    => pb_i,    
         ss_o    => ss_o,    
         ss_sel_o=> ss_sel_o,
         led_o   => led_o);

		
	clk_i <= not(clk_i) after 5 ns;
	
	p_rst_en : process      -- testing of asynchronous reset
		begin
			wait for 20 us;
			reset_i <= '0';
		end process;
		
end sim;

