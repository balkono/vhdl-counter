-------------------------------------------------------------------------------
--                                                                      
--                        4x7-segments counter project
--  
-------------------------------------------------------------------------------
--                                                                      
--
-- FILENAME:                cntr_top_struc_cfg.vhd
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

configuration cntr_top_struc_cfg of cntr_top is
  for struc
  end for;
end cntr_top_struc_cfg;
