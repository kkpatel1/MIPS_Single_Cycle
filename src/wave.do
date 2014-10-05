onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_module/CLK
add wave -noupdate /top_module/Output
add wave -noupdate /top_module/InstWrite
add wave -noupdate /top_module/InstIn
add wave -noupdate /top_module/NextAddr
add wave -noupdate /top_module/CurrAddr
add wave -noupdate /top_module/Inst
add wave -noupdate /top_module/MemWrite
add wave -noupdate /top_module/MemtoReg
add wave -noupdate /top_module/Branch
add wave -noupdate /top_module/ALUSrc
add wave -noupdate /top_module/RegDst
add wave -noupdate /top_module/RegWrite
add wave -noupdate /top_module/ALUControl
add wave -noupdate /top_module/Jump
add wave -noupdate /top_module/RegDstOut
add wave -noupdate /top_module/RdOut1
add wave -noupdate /top_module/RdOut2
add wave -noupdate /top_module/ALUIn
add wave -noupdate /top_module/SXOut
add wave -noupdate /top_module/ALUOut
add wave -noupdate /top_module/COMP
add wave -noupdate /top_module/MemOut
add wave -noupdate /top_module/MemtoRegOut
add wave -noupdate /top_module/PCad4
add wave -noupdate /top_module/PCad4adSX
add wave -noupdate /top_module/RegOut
add wave -noupdate /top_module/shifted
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {999050 ps} {1000050 ps}
