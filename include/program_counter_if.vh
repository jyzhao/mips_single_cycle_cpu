/*
  Jiyuan Zhao
  zhao89@purdue.edu

  program counter interface
*/
`ifndef PROGRAM_COUNTER_IF_VH
`define PROGRAM_COUNTER_IF_VH

// types
`include "cpu_types_pkg.vh"

interface program_counter_if;
  // import types
  import cpu_types_pkg::*;
  
  //logic CLK;
  //logic nRST;
  word_t pc_in;
  word_t pc_out;
  logic pcWEN;
  
  modport pc(
    input   pc_in,pcWEN,
    output  pc_out
  );

endinterface

`endif //PROGRAM_COUNTER_IF_VH
