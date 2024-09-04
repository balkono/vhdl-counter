-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                cntr_top_struc.vhd
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
--              derives a 1kHz-Clock from the 100MHz-Clock of the Digilent
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

architecture struc of cntr_top is
    
    -- see comments in counter unit
    component cntr
        port (clk_i       :  in   std_logic; 
              reset_i     :  in   std_logic; 
              cntrup_i    :  in   std_logic;
              cntrdown_i  :  in   std_logic;
              cntrreset_i :  in   std_logic;
              cntrhold_i  :  in   std_logic;
              cntr0_o     :  out  unsigned( 3 downto 0);
              cntr1_o     :  out  unsigned( 3 downto 0);
              cntr2_o     :  out  unsigned( 3 downto 0);
              cntr3_o     :  out  unsigned( 3 downto 0)
              );
    end component;
    
    -- see comments in io control unit
    component io_ctrl
        port (clk_i   : in  std_logic; 
              reset_i : in  std_logic; 
              cntr0_i : in  unsigned( 3 downto 0); 
              cntr1_i : in  unsigned( 3 downto 0); 
              cntr2_i : in  unsigned( 3 downto 0); 
              cntr3_i : in  unsigned( 3 downto 0); 
              sw_i    : in  std_logic_vector(15 downto 0); 
              pb_i    : in  std_logic_vector( 3 downto 0); 
              ss_o    : out std_logic_vector( 7 downto 0); 
              ss_sel_o: out std_logic_vector( 3 downto 0);
              swsync_o: out std_logic_vector(15 downto 0);
              pbsync_o: out std_logic_vector( 3 downto 0);
              led_o   : out unsigned(15 downto 0)
              ); 
    end component;
    
    -- constant, signals to derive a 1kHz-clock
    constant C_ENCOUNTVAL : unsigned(16 downto 0):= "11000011010100000"; -- 100 000 in decimal
    signal   s_enctr      : unsigned(16 downto 0):= "00000000000000000";
    signal   s_1khzen     : std_logic:= '0';
    
    -- debounced board inputs and counter values
    signal s_swsync : std_logic_vector (15 downto 0);
    signal s_pbsync : std_logic_vector ( 3 downto 0);
    signal s_cntr0  : unsigned ( 3 downto 0);
    signal s_cntr1  : unsigned ( 3 downto 0);
    signal s_cntr2  : unsigned ( 3 downto 0);
    signal s_cntr3  : unsigned ( 3 downto 0);
	
begin	
	
    i_io_ctrl: io_ctrl
    port map              
        (clk_i        => s_1khzen, 
         reset_i      => reset_i,  
         cntr0_i      => s_cntr0,
         cntr1_i      => s_cntr1,
         cntr2_i      => s_cntr2,
         cntr3_i      => s_cntr3,
         sw_i         => sw_i,
         pb_i         => pb_i,
         ss_o         => ss_o,
         ss_sel_o     => ss_sel_o,          
         swsync_o     => s_swsync,
         pbsync_o     => s_pbsync,
         led_o        => led_o);
        
    i_cntr: cntr
    port map              
		(clk_i        => s_1khzen,      
		 reset_i      => reset_i,    
		 cntrup_i     => s_swsync(1),   
         cntrdown_i   => s_swsync(2), 
         cntrreset_i  => s_swsync(3),
         cntrhold_i   => s_swsync(0), 
         cntr0_o      => s_cntr0,    
         cntr1_o      => s_cntr1,    
         cntr2_o      => s_cntr2,    
         cntr3_o      => s_cntr3);    
    
    
   -- generate 1kHz clock (stays active for one 100MHz-clk-cycle)
    p_slowen: process (clk_i, reset_i)
    begin
        if reset_i = '1' then
            s_1khzen <= '0';
            s_enctr <= "00000000000000000"; 
        
        elsif clk_i'event and clk_i = '1' then
            if s_enctr = C_ENCOUNTVAL then 
                s_1khzen <= '1';            
                s_enctr <= "00000000000000000";
                
            else                           
                s_1khzen <= '0';
                s_enctr <= s_enctr + 1;
            end if;
                
        end if;
    end process p_slowen; 
    
end struc;
