/****************************************************************************
 * wb_initiator_bfm.v
 * 
 ****************************************************************************/

module wb_initiator_bfm #(
		parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32
		) (
		input							clock,
		input							reset,
		output reg						stb_o,
		output reg						cyc_o,
		output reg						we_o,
		output reg[(DATA_WIDTH/8)-1:0]	sel_o,
		output reg[DATA_WIDTH-1:0]		dat_o,
		output reg[ADDR_WIDTH-1:0]		adr_o,
		input							ack_i,
		input[DATA_WIDTH-1:0]			dat_i
		);
	reg						stb_v = 0;
	reg						cyc_v = 0;
	reg						we_v = 0;
	reg[(DATA_WIDTH/8)-1:0]	sel_v = 0;
	reg[DATA_WIDTH-1:0]		dat_v = 0;
	reg[ADDR_WIDTH-1:0]		adr_v = 0;
	
	reg						in_reset = 0;
	reg[3:0]				post_reset_delay = 0;
	
	always @(posedge clock) begin
		if (reset) begin
			stb_o <= 0;
			cyc_o <= 0;
			we_o <= 0;
			sel_o <= 0;
			dat_o <= 0;
			adr_o <= 0;
			in_reset <= 1;
			post_reset_delay <= 0;
		end else begin
			if (in_reset) begin
				if (post_reset_delay == 4'hf) begin
					_reset();
					in_reset <= 0;
				end else begin
					post_reset_delay <= post_reset_delay + 1;
				end
			end
			stb_o <= stb_v;
			cyc_o <= cyc_v;
			we_o <= we_v;
			sel_o <= sel_v;
			dat_o <= dat_v;
			adr_o <= adr_v;
			
			if (cyc_o && stb_o && ack_i) begin
				_access_ack(dat_i);
				stb_v = 0;
				cyc_v = 0;
				we_v = 0;
				sel_v = 0;
				dat_v = 0;
				adr_v = 0;
				stb_o <= 0;
				cyc_o <= 0;
				we_o <= 0;
			end
		end
	end
	
	task _access_req(
		input reg[63:0]			adr,
		input reg[63:0]			dat,
		input reg[7:0]			we,
		input reg[7:0]			sel);
	begin
		$display("--> _access_req");
		stb_v = 1;
		cyc_v = 1;
		we_v = we;
		sel_v = sel;
		dat_v = dat;
		adr_v = adr;
		$display("<-- _access_req");
	end
	endtask

	task init;
	begin
		$display("wb_initiator_bfm: %m");
		_set_parameters(ADDR_WIDTH, DATA_WIDTH);
	end
	endtask

	// Auto-generated code to implement the BFM API
${pybfms_api_impl}
endmodule
 