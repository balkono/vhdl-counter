onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_cntr_top/clk_i
add wave -noupdate -format Logic /tb_cntr_top/reset_i  
add wave -noupdate -format Logic /tb_cntr_top/sw_i
add wave -noupdate -format Logic /tb_cntr_top/pb_i 
add wave -noupdate -format Logic /tb_cntr_top/ss_o 
add wave -noupdate -format Logic /tb_cntr_top/ss_sel_o 
add wave -noupdate -format Logic /tb_cntr_top/led_o 

add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/s_enctr
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/s_1khzen 
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_io_ctrl/s_presentstate
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_io_ctrl/s_swsync0
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_io_ctrl/s_swsync1
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_io_ctrl/s_swsync2
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_cntr/s_cntr
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_cntr/cntrhold_i
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_cntr/cntrup_i
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_cntr/cntrdown_i
add wave -noupdate -format Logic /tb_cntr_top/i_cntr_top/i_cntr/cntrreset_i
   

                                                       
TreeUpdate [SetDefaultTree]                                
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
