/*
  Jiyuan Zhao

  request unit
*/

// control unit interface
`include "request_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"


module request_unit(input logic CLK,nRST, request_unit_if.ru ruif);
   
   // type import
   import cpu_types_pkg::*;

always_ff @ (posedge CLK,negedge nRST) begin
  
  if(!nRST) begin
    ruif.dmemREN <= 0;
    ruif.dmemWEN <= 0;
    
  end
  else begin
      if(ruif.ihit) begin
        ruif.dmemWEN <= ruif.dWEN;
        ruif.dmemREN <= ruif.dREN;
        
      end
      else begin
        if (ruif.dhit) begin
          ruif.dmemREN <= 0;
          ruif.dmemWEN <= 0;
        end
      end
  end
  
end

always_comb begin
	ruif.pcWEN = 0;
	if (ruif.ihit) begin
		if (ruif.dWEN == 1 || ruif.dREN == 1)
        	begin
        		ruif.pcWEN = 1;
        	end
        end
        else begin
        	if (ruif.dhit) begin
        		ruif.pcWEN = 1;
        	end
        end
        
end
	

endmodule

