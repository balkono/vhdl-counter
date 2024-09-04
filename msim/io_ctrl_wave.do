onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_io_ctrl/clk_i
add wave -noupdate -format Logic /tb_io_ctrl/reset_i   
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_presentstate
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_nextstate
add wave -noupdate -format Logic /tb_io_ctrl/ss_o    
add wave -noupdate -format Logic /tb_io_ctrl/ss_sel_o 
add wave -noupdate -format Logic /tb_io_ctrl/cntr0_i 
add wave -noupdate -format Logic /tb_io_ctrl/cntr1_i 
add wave -noupdate -format Logic /tb_io_ctrl/cntr2_i 
add wave -noupdate -format Logic /tb_io_ctrl/cntr3_i
add wave -noupdate -format Logic /tb_io_ctrl/led_o 
add wave -noupdate -format Logic /tb_io_ctrl/sw_i    
add wave -noupdate -format Logic /tb_io_ctrl/pb_i    
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_swsync0
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_swsync1
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_swsync2
add wave -noupdate -format Logic /tb_io_ctrl/swsync_o
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_pbsync0 
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_pbsync1 
add wave -noupdate -format Logic /tb_io_ctrl/i_io_ctrl/s_pbsync2 
add wave -noupdate -format Logic /tb_io_ctrl/pbsync_o
   
                                 
TreeUpdate [SetDefaultTree]                                
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
