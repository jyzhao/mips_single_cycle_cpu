/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

 assign ccif.dload = ccif.ramload;
 assign ccif.iload = ccif.ramload;
  
  always_comb begin
  
    //reset
    ccif.dwait = 1;
    ccif.iwait = 1;
    ccif.ramREN = 0;
    ccif.ramWEN = 0;
    ccif.ramaddr = 0;
    ccif.ramstore = 0;
    
    
    if (ccif.dREN[0]) begin
      ccif.ramREN = ccif.dREN[0];      
      ccif.ramaddr = ccif.daddr;
      if (ccif.ramstate == ACCESS) begin
        ccif.dwait = 0;
      end
    end
    
    else if (ccif.dWEN[0]) begin
      ccif.ramWEN = ccif.dWEN[0];
      ccif.ramaddr = ccif.daddr;
      ccif.ramstore = ccif.dstore;
      if (ccif.ramstate == ACCESS) begin
        ccif.dwait = 0;
      end
    end
    
    else if (ccif.iREN[0]) begin
      ccif.ramREN = ccif.iREN[0];
      ccif.ramaddr = ccif.iaddr;
      if (ccif.ramstate == ACCESS) begin
        ccif.iwait = 0;
      end
    end
  end
    
endmodule
