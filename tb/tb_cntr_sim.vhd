-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                tb_cntr_sim.vhd
--  
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	Architecture of the testbench of the counter unit.
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

architecture sim of tb_cntr is

	component cntr
	port (clk_i      :   in  std_logic; 
		  reset_i    :   in  std_logic; 
		  cntrup_i   :   in  std_logic;
          cntrdown_i :   in  std_logic;
          cntrreset_i:   in  std_logic;
          cntrhold_i :   in  std_logic;
          cntr0_o    :  out  unsigned(3 downto 0);
          cntr1_o    :  out  unsigned(3 downto 0);
          cntr2_o    :  out  unsigned(3 downto 0);
          cntr3_o    :  out  unsigned(3 downto 0));
	end component;
	
    
	signal clk_i      : std_logic:='0'; 
	signal reset_i    : std_logic:='1'; 
	signal cntrup_i   : std_logic:='1';
    signal cntrdown_i : std_logic:='0';
    signal cntrreset_i: std_logic:='0';
    signal cntrhold_i : std_logic:='1';
    signal cntr0_o    : unsigned(3 downto 0);
    signal cntr1_o    : unsigned(3 downto 0);
    signal cntr2_o    : unsigned(3 downto 0);
    signal cntr3_o    : unsigned(3 downto 0);

	begin                                        

	i_cntr : cntr
	port map              
		(clk_i        => clk_i,      
		 reset_i      => reset_i,    
		 cntrup_i     => cntrup_i,   
         cntrdown_i   => cntrdown_i, 
         cntrreset_i  => cntrreset_i,
         cntrhold_i   => cntrhold_i, 
         cntr0_o      => cntr0_o,    
         cntr1_o      => cntr1_o,    
         cntr2_o      => cntr2_o,    
         cntr3_o      => cntr3_o);

		
	clk_i <= not(clk_i) after 5 us; -- 1kHz clock
	
	p_reset : process   -- testing the asynchronous-reset and the different modes
		begin
			wait for 20 us;
			reset_i <= '0';
            wait for 0.5 sec;
            cntrup_i <= '0';
            cntrdown_i <= '1';
            wait for 100 ms;
            cntrhold_i <= '0';
            wait for 200 ms;
            cntrreset_i <= '1';
			
		end process;
		
end sim;

