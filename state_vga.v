module state_vga(clock, reset, hit, end_flag, fail, result);
input clock, reset, hit, end_flag, fail;
output [1:0] result;
reg [1:0] result;
reg [31:0] debounce;
reg cool_down;
parameter running_S = 1, hit_S = 0, fail_S = 2, ending_S = 3;

always @(posedge clock or negedge reset) begin
	if(!reset) begin
		result <= ending_S;
	end
	else begin
		if(cool_down == 1) begin
			if(debounce < 32'd5000000) begin
				debounce <= debounce + 1'b1;
				cool_down <= 1;
			end
			else begin
				debounce <= 32'd0;
				cool_down <= 0;
			end
		end
		else begin
			if(end_flag == 1) begin
				result <= ending_S;
			end
			else if(hit == 1) begin
				result <= hit_S;
				cool_down <= 1;
			end
			else if(fail == 1) begin
				result <= fail_S;
				cool_down <= 1;
			end
			else begin
				result <= running_S;
			end
		end
	end
end
endmodule
