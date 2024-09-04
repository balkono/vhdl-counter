-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                tb_io_ctrl_sim_cfg.vhd
--  
-- ENGINEER:                Moritz Emersberger
--  
-- DATE (current Version):  5. April 2023
--  
-- VERSION:                 1.0
--
-------------------------------------------------------------------------------
--                                                                      
-- DESCRIPTION:	The configuration of the IO Control unit of the counter project.
--
-------------------------------------------------------------------------------
--                                                                      
-- CHANGES:     V1.0:  5.04.2023: initial Version      
--
------------------------------------------------------------------------------- 

library IEEE;
use IEEE.std_logic_1164.all;

configuration tb_io_ctrl_sim_cfg of tb_io_ctrl is
  for sim
    for i_io_ctrl : io_ctrl
      use configuration work.io_ctrl_rtl_cfg;
    end for;
  end for;
end tb_io_ctrl_sim_cfg;
