
/****************************************************************************
 * initiator_smoke_tb.sv
 ****************************************************************************/
`ifdef IVERILOG
`timescale 1ns/1ns
`endif

`include "wishbone_macros.svh"

  
/**
 * Module: initiator_smoke_tb
 * 
 * TODO: Add module documentation
 */
module initiator_smoke_tb(input clk);
	
`ifdef HAVE_HDL_CLOCKGEN
	reg clk_r = 0;
	initial begin
		forever begin
			#10;
			clk_r <= ~clk_r;
		end
	end
	assign clk = clk_r;
`endif
	
	wire clock = clk;
	reg reset = 1;
	reg[3:0] reset_cnt = 0;

	always @(posedge clock) begin
		if (reset_cnt == 'hf) begin
			reset <= 0;
		end else begin
			reset_cnt <= reset_cnt + 1;
		end
	end


	
	`WB_WIRES(bfm2mem_, 32, 32);

	wb_initiator_bfm #(
		.ADDR_WIDTH  (32 ), 
		.DATA_WIDTH  (32 )
		) u_bfm (
		.clock       (clock      ), 
		.reset       (reset      ), 
		`WB_CONNECT(,bfm2mem_)
		);

	reg 		ack_r = 0;
	reg[31:0]	data = 0;
	assign bfm2mem_ack = ack_r;
	
	assign bfm2mem_dat_r = data;
	
	always @(posedge clock) begin
		if (reset) begin
			ack_r <= 0;
			data <= 0;
		end else begin
			ack_r <= (bfm2mem_cyc && bfm2mem_stb);
			if (bfm2mem_cyc && bfm2mem_stb && bfm2mem_we) begin
				data <= bfm2mem_dat_w;
			end
		end
	end

endmodule


