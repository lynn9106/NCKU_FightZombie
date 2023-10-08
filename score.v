`define t 32'd25000000
module score(clk,rst,hit,end_flag,Out1,Out2);
input clk,rst,hit, end_flag;//, hit1, hit2, hit3, hit4;
//input [3:0] countdowntimer;
reg [3:0] high, low;
output [6:0] Out1,Out2;
reg [6:0] Out1,Out2;
//wire hit;
wire clk_edit;

clk_div frequency_divider(.clk(clk), .rst(rst),.div_clk(clk_edit));

//assign hit= ((hit1|hit2)|hit3)|hit4;

always@(negedge rst or posedge hit )
begin
	if(!rst)
	begin
		high<=4'd0;
		low<=4'd0;
	end
	else
	begin
	
		if(low == 4'd9)
		begin
			high<=high+4'd1;
			low<=4'd0;
		end
		else
		begin
			low<=low+4'd1;
		end
		
	end
end

always@(high or low or end_flag or clk_edit)
begin
	if(end_flag == 1)
	begin
		if(clk_edit == 1)
		begin
			case(low)

				4'b0000:Out2=7'b1000000;
				4'b0001:Out2=7'b1111001;
				4'b0010:Out2=7'b0100100;
				4'b0011:Out2=7'b0110000;
				4'b0100:Out2=7'b0011001;
				4'b0101:Out2=7'b0010010;
				4'b0110:Out2=7'b0000010;
				4'b0111:Out2=7'b1111000;
				4'b1000:Out2=7'b0000000;
				4'b1001:Out2=7'b0010000;
				4'b1010:Out2=7'b0001000;
				4'b1011:Out2=7'b0000011;
				4'b1100:Out2=7'b1000110;
				4'b1101:Out2=7'b0100001;
				4'b1110:Out2=7'b0000110;
				4'b1111:Out2=7'b0001110;

			endcase
		
			case(high)

				4'b0000:Out1=7'b1000000;
				4'b0001:Out1=7'b1111001;
				4'b0010:Out1=7'b0100100;
				4'b0011:Out1=7'b0110000;
				4'b0100:Out1=7'b0011001;
				4'b0101:Out1=7'b0010010;
				4'b0110:Out1=7'b0000010;
				4'b0111:Out1=7'b1111000;
				4'b1000:Out1=7'b0000000;
				4'b1001:Out1=7'b0010000;
				4'b1010:Out1=7'b0001000;
				4'b1011:Out1=7'b0000011;
				4'b1100:Out1=7'b1000110;
				4'b1101:Out1=7'b0100001;
				4'b1110:Out1=7'b0000110;
				4'b1111:Out1=7'b0001110;

			endcase
		end
		else
		begin
			Out2=7'b1111111;
			Out1=7'b1111111;
		end
	end
	else
	begin
		case(low)

			4'b0000:Out2=7'b1000000;
			4'b0001:Out2=7'b1111001;
			4'b0010:Out2=7'b0100100;
			4'b0011:Out2=7'b0110000;
			4'b0100:Out2=7'b0011001;
			4'b0101:Out2=7'b0010010;
			4'b0110:Out2=7'b0000010;
			4'b0111:Out2=7'b1111000;
			4'b1000:Out2=7'b0000000;
			4'b1001:Out2=7'b0010000;
			4'b1010:Out2=7'b0001000;
			4'b1011:Out2=7'b0000011;
			4'b1100:Out2=7'b1000110;
			4'b1101:Out2=7'b0100001;
			4'b1110:Out2=7'b0000110;
			4'b1111:Out2=7'b0001110;

		endcase
		
		case(high)

			4'b0000:Out1=7'b1000000;
			4'b0001:Out1=7'b1111001;
			4'b0010:Out1=7'b0100100;
			4'b0011:Out1=7'b0110000;
			4'b0100:Out1=7'b0011001;
			4'b0101:Out1=7'b0010010;
			4'b0110:Out1=7'b0000010;
			4'b0111:Out1=7'b1111000;
			4'b1000:Out1=7'b0000000;
			4'b1001:Out1=7'b0010000;
			4'b1010:Out1=7'b0001000;
			4'b1011:Out1=7'b0000011;
			4'b1100:Out1=7'b1000110;
			4'b1101:Out1=7'b0100001;
			4'b1110:Out1=7'b0000110;
			4'b1111:Out1=7'b0001110;

		endcase
	end

end

endmodule

module clk_div(clk, rst,div_clk);
input clk,rst;
output div_clk;

reg div_clk;
reg [31:0]count;

always@(posedge clk)
begin
	if(!rst)
	begin
		count<=32'd0;
		div_clk<=1'b0;
	end
	else
	begin
		if(count == `t)
		begin
			count<=32'd0;
			div_clk<=~div_clk;
		end
		else
		begin
			count<=count+32'd1;
		end
	end
end

endmodule
