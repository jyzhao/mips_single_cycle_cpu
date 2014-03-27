/*
  Jiyuan Zhao
  zhao89@purdue.edu

  control_unit interface
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;
  
  opcode_t opcode;
  funct_t funct;
  
  logic RegDst;
  logic ALUSrc;
  logic MemtoReg;
  logic RegWrite;
  logic MemWrite;
  logic PCSrc;
  logic Jump;
  logic ExtOp;
  aluop_t ALUOp;
  logic halt;
  
  logic Equal;
  logic Branch;
  logic MemRead;

modport cu(
    input   opcode,funct,Equal,
    output  RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,PCSrc,Jump,ExtOp,ALUOp,halt,Branch,MemRead
  );


endinterface

`endif //CONTROL_UNIT_IF_VH
