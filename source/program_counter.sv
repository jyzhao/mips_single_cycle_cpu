/*
  Jiyuan Zhao

  program counter
*/

// program counter interface
`include "program_counter_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module program_counter (input logic CLK, nRST, program_counter_if pcif);
  // import types
  import cpu_types_pkg::*;

  // pc init
  //parameter PC_INIT = 0;
  
  always_ff @(posedge CLK, negedge nRST)
  begin
    if (!nRST)
    begin
        pcif.pc_out <= 32'b0;
    end
    else
    begin
    	if (pcif.pcWEN) begin
        	pcif.pc_out <= pcif.pc_in;
        end
    end
  end

endmodule
