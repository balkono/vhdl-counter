-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                io_ctrl_rtl.vhd
-- 
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.1
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION: The IO Control unit is part of the counter project.
--              It manages the interface to the 7-segment displays,
--              the LEDs, the push buttons and the switches of the
--              Digilent Basys3 FPGA board   
--
-------------------------------------------------------------------------------
--                                                                      
-- CHANGES:     V1.0: 31.03.2023: initial Version      
--              V1.1:  5.04.2023: modified p_display_ctrl, created p_digit_states, 
--                                changed cntrX_i to unsigned  
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use IEEE.numeric_std_unsigned.all;

architecture rtl of io_ctrl is
    
    -- signals for debouncing the board's inputs
    signal s_swsync0  : std_logic_vector(15 downto 0);
    signal s_pbsync0  : std_logic_vector( 3 downto 0);
    signal s_swsync1  : std_logic_vector(15 downto 0);
    signal s_pbsync1  : std_logic_vector( 3 downto 0);
    signal s_swsync2  : std_logic_vector(15 downto 0);
    signal s_pbsync2  : std_logic_vector( 3 downto 0);
    
    signal s_ss_sel : std_logic_vector( 3 downto 0); -- signal for 7 cathodes of one digit, '0' for ON
    signal s_ss     : std_logic_vector( 7 downto 0); -- signal for 4 anodes for 4 digits, '0' for ON
    
    -- state-signals for sampling counter values on digits
    type t_digsel is (OFF, DIGIT0, DIGIT1, DIGIT2, DIGIT3); 
    signal s_presentstate : t_digsel;
    signal s_nextstate : t_digsel;
    
    -- function to map 0-9,A-F to 7-segment digit
    function hex_to_7seg (cntvalue : unsigned(3 downto 0))
        return std_logic_vector is
    begin               
        -- binary-value to 7-segment-digit, DP lights up, if letter is displayed
        case cntvalue is-- CA|CB|CC|CD|CE|CE|CF|CG|DP
            when "0000" => return "00000011"; 
            when "0001" => return "10011111"; 
            when "0010" => return "00100101"; 
            when "0011" => return "00001101"; 
            when "0100" => return "10011001"; 
            when "0101" => return "01001001"; 
            when "0110" => return "01000001"; 
            when "0111" => return "00011111"; 
            when "1000" => return "00000001"; 
            when "1001" => return "00001001"; 
            when "1010" => return "00010000";
            when "1011" => return "11000000"; 
            when "1100" => return "11100100";
            --when "1100" => return "01100010";
            when "1101" => return "10000100"; 
            when "1110" => return "01100000"; 
            when "1111" => return "01110000"; 
            when others => return "11111110";
        end case;    
        
    end;
begin
    
    
    --debounce switches and buttons 2 times
    p_debounce: process (clk_i, reset_i)
    begin
        if reset_i = '1' then
            s_swsync0 <= "0000000000000000";
            s_pbsync0 <= "0000";
            s_swsync1 <= "0000000000000000";
            s_pbsync1 <= "0000";
            s_swsync2 <= "0000000000000000";
            s_pbsync2 <= "0000";
            
        elsif clk_i'event and clk_i = '1' then
            s_swsync1 <= s_swsync0;
            s_pbsync1 <= s_pbsync0;
            s_swsync0 <= sw_i;
            s_pbsync0 <= pb_i;
            
            if s_swsync0 = s_swsync1 then
                s_swsync2 <= s_swsync0;
            end if;
            
            if s_pbsync0 = s_pbsync1 then
                s_pbsync2 <= s_pbsync0;
            end if;
            --s_swsync1<= sw_i;
            --s_swsync2<= s_swsync1;
            --s_pbsync1<= pb_i;
            --s_pbsync2<= s_pbsync1;
        end if;
    end process p_debounce;
    
    swsync_o <= s_swsync2;
    pbsync_o <= s_pbsync2;
    
    --switching digits to display one digit each 0.25ms
    p_digit_states: process (clk_i, reset_i)
    begin
        if reset_i = '1' then
            s_presentstate <= OFF;
            
        elsif clk_i'event and clk_i = '1' then
            s_presentstate <= s_nextstate;
        end if;
    end process p_digit_states; 
    
    
    --display 4 7-segment digits 
    p_display_ctrl: process (s_presentstate)
    begin 
        case s_presentstate is
            when DIGIT0 =>
                s_ss_sel <= "1110";
                s_ss <= hex_to_7seg(cntr0_i);
                s_nextstate <= DIGIT1;
                
            when DIGIT1 =>
                s_ss_sel <= "1101";
                s_ss <= hex_to_7seg(cntr1_i);
                s_nextstate <= DIGIT2;
            
            when DIGIT2 =>
                s_ss_sel <= "1011";
                s_ss <= hex_to_7seg(cntr2_i);
                s_nextstate <= DIGIT3;
            
            when DIGIT3 =>
                s_ss_sel <= "0111";
                s_ss <= hex_to_7seg(cntr3_i);
                s_nextstate <= DIGIT0;
            
            when OFF => 
                s_ss <= "11111111";
                s_ss_sel <= "1111";
                s_nextstate <= DIGIT0;
        end case;        
    end process p_display_ctrl;
    
    ss_o <= s_ss;
    ss_sel_o <= s_ss_sel;
    
    --show counter in binary via leds
    led_o( 3 downto  0) <= cntr0_i(3 downto 0);
    led_o( 7 downto  4) <= cntr1_i(3 downto 0);
    led_o(11 downto  8) <= cntr2_i(3 downto 0);
    led_o(15 downto 12) <= cntr3_i(3 downto 0);
    
end rtl;
