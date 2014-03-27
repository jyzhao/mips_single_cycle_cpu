// interface
`include "register_file_if.vh"
 
import cpu_types_pkg::*;
   
  // register file ports
  /*
  modport rf (
    input   WEN, wsel, rsel1, rsel2, wdat,
    output  rdat1, rdat2
  );
  */

module register_file (input logic CLK, nRST,register_file_if.rf rfif);

	word_t [31:0] register;
	
	always_ff @ (posedge CLK, negedge nRST) begin
		if (!nRST) begin
			register[31:0] <= 0;
		end
		else begin
			if (rfif.WEN) begin
				if(rfif.wsel != 0) begin
				register[rfif.wsel] <= rfif.wdat;
				end
			end
		end
		
	end

	always_comb begin
		//register[0] = 0;
		rfif.rdat1 = register[rfif.rsel1];
		rfif.rdat2 = register[rfif.rsel2];
	end


endmodule
