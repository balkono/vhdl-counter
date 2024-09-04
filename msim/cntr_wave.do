onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_cntr/clk_i      
add wave -noupdate -format Logic /tb_cntr/reset_i    
add wave -noupdate -format Logic /tb_cntr/cntrup_i   
add wave -noupdate -format Logic /tb_cntr/cntrdown_i 
add wave -noupdate -format Logic /tb_cntr/cntrreset_i
add wave -noupdate -format Logic /tb_cntr/cntrhold_i 
add wave -noupdate -format Logic /tb_cntr/cntr0_o    
add wave -noupdate -format Logic /tb_cntr/cntr1_o    
add wave -noupdate -format Logic /tb_cntr/cntr2_o    
add wave -noupdate -format Logic /tb_cntr/cntr3_o    

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left
