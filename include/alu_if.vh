/*
  Jiyuan Zhao
  zhao89@purdue.edu

  alu interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;
  
   logic [31:0] port_A,port_B;
   logic [3:0] aluop;
   logic [31:0] output_port;
   logic negative,overflow,zero;
   
  modport a(
    input   port_A,port_B, aluop,
    output  output_port,negative,overflow,zero
  );

endinterface

`endif //ALU_IF_VH

