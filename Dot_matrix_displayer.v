module Dot_matrix_displayer(clk_div,reset,place,flag, dot_column ,dot_row);

input [7:0]place;
input clk_div,reset,flag;
output reg [7:0]dot_row;
output reg [7:0]dot_column;

reg [2:0]row_count;

always @(posedge clk_div or negedge reset or posedge flag) begin 
if(!reset || flag) begin 
	row_count <= 0;
	dot_row <= 8'b00000000;
	dot_column <= 8'b00000000;
end
else begin
	row_count <= row_count +1;
	
	case(row_count)
		3'd0: dot_row <= 8'b01111111;
		3'd1: dot_row <= 8'b10111111;
		3'd2: dot_row <= 8'b11011111;
		3'd3: dot_row <= 8'b11101111;
		3'd4: dot_row <= 8'b11110111;
		3'd5: dot_row <= 8'b11111011;
		3'd6: dot_row <= 8'b11111101;
		3'd7: dot_row <= 8'b11111110;
	endcase
	case(row_count)
		3'd0: begin
			case(place[7:6])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd1: begin
			case(place[7:6])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd2: begin
			case(place[5:4])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd3: begin
			case(place[5:4])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd4: begin
			case(place[3:2])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd5: begin
			case(place[3:2])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd6: begin
			case(place[1:0])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
		3'd7: begin
			case(place[1:0])
				2'b00: dot_column <= 8'b11000000;
				2'b01: dot_column <= 8'b00110000;
				2'b10: dot_column <= 8'b00001100;
				2'b11: dot_column <= 8'b00000011;
			endcase
		end
	endcase
	end
end




endmodule



