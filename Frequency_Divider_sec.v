`define Time 32'd25000000

module Frequency_Divider_sec(clock, reset, sec);

input clock, reset;
output sec;

reg sec;
reg [31:0]count;

always@(posedge clock or negedge reset) begin
	if(!reset) begin
		count <= 0;
		sec <= 0;
	end
	
	else begin
		count <= count + 1;
		if(count == `Time) begin
			sec <= !sec;
			count <= 0;
		end
	end
end

endmodule
