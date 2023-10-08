module counter(clk_sec, reset, count, flag);

input clk_sec, reset;
output [3:0]count;
output flag;

reg [3:0]count;
reg flag;

always@(posedge clk_sec or negedge reset) begin
	
	if(!reset) begin
		count <= 0;
		flag <= 0;
	end
	
	else begin
		if(count == 4'd15)
			flag <= 1;
		else
			count <= count + 1;
	end
	
end

endmodule
