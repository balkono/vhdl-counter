-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                tb_cntr_sim_cfg.vhd
--  
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The configuration of the testbench of the counter unit.
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

configuration tb_cntr_sim_cfg of tb_cntr is
  for sim
    for i_cntr : cntr
      use configuration work.cntr_rtl_cfg;
    end for;
  end for;
end tb_cntr_sim_cfg;
