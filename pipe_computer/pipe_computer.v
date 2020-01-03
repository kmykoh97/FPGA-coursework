module pipe_computer_main(resetn, clock, mem_clock,
	pc, ins, dpc4, inst, da, db, dimm, drn, ealu, eb, ern, mmo, mrn, wdi, wrn,
	sw, key, hex5, hex4, hex3, hex2, hex1, hex0, led);

	input         resetn, clock;
	output        mem_clock;
	output [4:0]  drn, ern, mrn, wrn;
	output [31:0] pc, ins, dpc4, inst, da, db, dimm, ealu, eb, mmo, wdi;
	input  [9:0]  sw;
	input  [3:1]  key;
	output [6:0]  hex5, hex4, hex3, hex2, hex1, hex0;
	output [9:0]  led;

	wire   [31:0] pc, bpc, jpc, npc, pc4, ins, inst;
	wire   [31:0] dpc4, da, db, dimm;
	wire   [31:0] epc4, ea, eb, eimm, ealu;
	wire   [31:0] mb, mmo, malu;
	wire   [31:0] wmo, wdi, walu;
	wire   [4:0]  drn, ern0, ern, mrn, wrn;
	wire   [3:0]  daluc, ealuc;
	wire   [1:0]  pcsource;
	wire          wpcir;
	wire          dwreg, dm2reg, dwmem, daluimm, dshift, djal;
	wire          ewreg, em2reg, ewmem, ealuimm, eshift, ejal;
	wire          mwreg, mm2reg, mwmem;
	wire          wwreg, wm2reg;

	assign mem_clock = ~clock;

	pipe_F_reg prog_cnt(npc, wpcir, clock, resetn, pc);

	// IF 取指令模块，注意其中包含的指令同步 ROM 存储器的同步信号。
	// 留给信号半个节拍的传输时间。
	pipe_F_stage if_stage(pcsource, pc, bpc, da, jpc, npc, pc4, ins, mem_clock);

	// IF/ID 流水线寄存器模块，起承接 IF 阶段和 ID 阶段的流水任务。
	// 在 clock 上升沿时，将 IF 阶段需传递给 ID 阶段的信息，锁存在 IF/ID 流水线寄存器中，并呈现在 ID 阶段。
	pipe_D_reg inst_reg(pc4, ins, wpcir, clock, resetn, dpc4, inst);

	// ID 指令译码模块。注意其中包含控制器 CU、寄存器堆及多个多路器等。
	// 其中的寄存器堆，会在系统 clock 的下沿进行寄存器写入，也就是给信号从 WB 阶段
	// 传输过来留有半个 clock 的延迟时间，亦即确保信号稳定。
	// 该阶段 CU 产生的，要传播到流水线后级的信号较多。
	pipe_D_stage id_stage(mwreg, mrn, ern, ewreg, em2reg, mm2reg, dpc4, inst,
		wrn, wdi, ealu, malu, mmo, wwreg, clock, resetn,
		bpc, jpc, pcsource, wpcir, dwreg, dm2reg, dwmem, daluc,
		daluimm, da, db, dimm, drn, dshift, djal);

	// ID/EXE 流水线寄存器模块，起承接 ID 阶段和 EXE 阶段的流水任务。
	// 在 clock 上升沿时，将 ID 阶段需传递给 EXE 阶段的信息，锁存在 ID/EXE 流水线寄存器中，并呈现在 EXE 阶段。
	pipe_E_reg de_reg(dwreg, dm2reg, dwmem, daluc, daluimm, da, db, dimm, drn, dshift,
		djal, dpc4, clock, resetn, ewreg, em2reg, ewmem, ealuc, ealuimm,
		ea, eb, eimm, ern0, eshift, ejal, epc4);

	// EXE 运算模块。其中包含 ALU 及多个多路器等。
	pipe_E_stage exe_stage(ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4, ejal, ern, ealu);

	// EXE/MEM 流水线寄存器模块，起承接 EXE 阶段和 MEM 阶段的流水任务。
	// 在 clock 上升沿时，将 EXE 阶段需传递给 MEM 阶段的信息，锁存在 EXE/MEM 流水线寄存器中，并呈现在 MEM 阶段。
	pipe_M_reg em_reg(ewreg, em2reg, ewmem, ealu, eb, ern, clock, resetn, mwreg, mm2reg, mwmem, malu, mb, mrn);

	// MEM 数据存取模块。其中包含对数据同步 RAM 的读写访问。
	// 留给信号半个节拍的传输时间，然后在 mem_clock 上沿时，读输出或写输入。
	pipe_M_stage mem_stage(mwmem, malu, mb, mem_clock, resetn, mmo, sw, key, hex5, hex4, hex3, hex2, hex1, hex0, led);

	// MEM/WB 流水线寄存器模块，起承接 MEM 阶段和 WB 阶段的流水任务。
	// 在 clock 上升沿时，将 MEM 阶段需传递给 WB 阶段的信息，锁存在 MEM/WB 流水线寄存器中，并呈现在 WB 阶段。
	pipe_W_reg mw_reg(mwreg, mm2reg, mmo, malu, mrn, clock, resetn, wwreg, wm2reg, wmo, walu, wrn);

	// WB 写回阶段模块。
	pipe_W_stage wb_stage(walu, wmo, wm2reg, wdi);
endmodule
