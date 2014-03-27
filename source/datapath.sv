/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "register_file_if.vh"
`include "program_counter_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "alu_if.vh"
`include "cache_control_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  
  register_file_if  rfif();
  program_counter_if pcif();
  control_unit_if cuif();
  request_unit_if ruif();
  alu_if aif();
  cache_control_if ccif();


logic RegDst, Branch, MemRead, MemtoReg, MemWrite,ALUSrc, RegWrite, Equal,Jump,ExtOp,Branch_Equal,negative,overflow;
word_t signed_imm,mux_branch,pc,mux_MemtoReg,PC_4,mux_ALUSrc,Offset,PC_Offset,ALUResult,instruction;
logic [4:0] mux_RegDst;
aluop_t ALUOp;


opcode_t opcode;
assign opcode = opcode_t'(instruction[31:26]);

regbits_t rs;
//assign rs = dpif.imemload[25:21];

regbits_t rt;
//assign rt = dpif.imemload[20:16];

regbits_t rd;
//assign rd = dpif.imemload[15:11];

logic [SHAM_W-1:0]  shamt;
assign shamt = instruction[10:6];

funct_t funct;
assign funct = funct_t'(instruction[5:0]);

logic [IMM_W-1:0] imm;
assign imm = instruction[15:0];


assign Offset = signed_imm << 2;
assign Branch_Equal = Branch & Equal;

//sign extend
sign_extender SIGN_EXTENDER (
                             .in (imm),
                             .ExtOp (ExtOp),
                             .out (signed_imm)
                            );
//mux memtoreg                                                
MUX_32bit MUX_MemtoReg(
    .data1_in   (ALUResult),
    .data2_in   (dpif.dmemload),
    .select     (MemtoReg),
    .data_out   (mux_MemtoReg)
);        

//mux branch
MUX_32bit MUX_Branch(
    .data1_in   (PC_4),
    .data2_in   (PC_Offset),
    .select     (Branch_Equal),
    .data_out   (mux_branch)
);

//mux alusrc
MUX_32bit MUX_ALUSrc(
    .data1_in   ({27'b0,rt}),
    .data2_in   (signed_imm),
    .select     (ALUSrc),
    .data_out   (mux_ALUSrc)
);

//mux regdst
MUX_5bit MUX_RegDst(
    .data1_in   (dpif.imemload[20:16]),
    .data2_in   (dpif.imemload[15:11]),
    .select     (RegDst),
    .data_out   (mux_RegDst)
);                                        

//adder pc add 4
adder PC_Add_4(
    .data1_in   (pc),
    .data2_in   (32'd4),
    .data_out   (PC_4)
);

//adder pc add offset
adder PC_Add_Offset(
    .data1_in   (PC_4),
    .data2_in   (Offset),
    .data_out   (PC_Offset)
);

//registerfile
register_file REGISTER_FILE(CLK,nRST,rfif);

assign rfif.WEN = RegWrite;
assign rfif.wsel = mux_RegDst;
assign rfif.rsel1 = dpif.imemload[25:21];
assign rfif.rsel2 = dpif.imemload[20:16];
assign rfif.wdat = mux_MemtoReg;
assign rs = rfif.rdat1;
assign rt = rfif.rdat2;

//program counter
program_counter PROGRAM_COUNTER (CLK,nRST,pcif);
assign pcif.pcWEN = 1;//////////////////////////////////////////////////////////////////
assign pcif.pc_in = mux_branch;
assign pc = pcif.pc_out;


//alu
alu ALU_UNIT (aif);
assign aif.port_A = rs;
assign aif.port_B = mux_ALUSrc;
assign aif.aluop = ALUOp;
assign ALUResult = aif.output_port;
assign negative = aif.negative;
assign overflow = aif.overflow;
assign Equal = aif.zero;

//instruction mem
assign dpif.imemaddr = pc;

always_comb begin
  if (~nRST | cuif.halt) begin
    dpif.imemREN = 0;
  end
  else begin
    dpif.imemREN = 1;
  end
end
  
//data mem
assign dpif.dmemaddr = ALUResult;
assign dpif.dmemstore = rt;


//request unit
request_unit REQUEST_UNIT (CLK,nRST,ruif);
assign dpif.dmemREN = ruif.dmemREN;
assign dpif.dmemWEN = ruif.dmemWEN;
assign ruif.dWEN = MemWrite;
assign ruif.dREN = MemRead;
assign ruif.dhit = dpif.dhit;
assign ruif.ihit = dpif.ihit;
assign instruction = dpif.imemREN ? dpif.imemload : 0;


//control unit
control_unit CONTROL_UNIT (cuif);
assign cuif.opcode = opcode;
assign cuif.funct = funct;
assign ALUSrc = cuif.ALUSrc;
assign Jump = cuif.Jump;
assign Branch = cuif.Branch;
assign MemWrite = cuif.MemWrite;
assign MemRead = cuif.MemRead; 
assign MemtoReg = cuif.MemtoReg; 
assign RegWrite = cuif.RegWrite;
assign RegDst = cuif.RegDst;
assign cuif.Equal = Equal;
assign ALUOp = cuif.ALUOp;
assign ExtOp = cuif.ExtOp;

assign dpif.halt = cuif.halt;



endmodule
