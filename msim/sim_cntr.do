vsim -t ns -novopt -lib work work.tb_cntr_sim_cfg  
view *
do cntr_wave.do
run 2000 ms
