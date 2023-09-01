transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Product01 {E:/Product01/permissionCheck.v}
vlog -vlog01compat -work work +incdir+E:/Product01 {E:/Product01/mainmodule.v}
vlog -vlog01compat -work work +incdir+E:/Product01 {E:/Product01/authandfeatures.v}

