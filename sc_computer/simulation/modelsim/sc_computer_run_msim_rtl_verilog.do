transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/rom_1port.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/ram_1port.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/sc_instmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/sc_datamem.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/sc_cu.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/sc_cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/sc_computer.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/mux4x32.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/mux2x5.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/mux2x32.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/dff32.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/clock_2T.v}
vlog -vlog01compat -work work +incdir+C:/Users/kmyko/Desktop/digital\ design/lab/sc_computer {C:/Users/kmyko/Desktop/digital design/lab/sc_computer/clock_adjust.v}

