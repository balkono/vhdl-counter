vsim -t ns -novopt -lib work work.tb_cntr_top_sim_cfg  
view *
do cntr_top_wave.do
run 100 ms
