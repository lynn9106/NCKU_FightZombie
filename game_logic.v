module game_logic(clock, reset, btn, location, hit, end_flag, fail);
input clock, reset, end_flag;
output [7:0] location;
reg [7:0] location;
input [3:0] btn;
reg [1:0] rand_num, factor;
reg hit, cool_down, fail;
output hit, fail;

reg [31:0] debounce;
always @(posedge clock or negedge reset or posedge end_flag)begin
	if(!reset || end_flag)
	begin
		rand_num <= 0;
	end
	else begin
		rand_num <= rand_num + 1 + factor;
	end
end

always @(posedge clock or negedge reset)begin
	if(!reset)begin
		location <= 8'b00011011;
		hit <= 0;
		cool_down <= 0;
		factor <= 2'b00;
		fail <= 0;
	end
	else begin
		if(cool_down == 1) begin
			if(debounce < 32'd9500000) begin
				debounce <= debounce + 1'b1;
				cool_down <= 1;
			end
			else begin
				debounce <= 32'd0;
				cool_down <= 0;
			end
			hit <= 0;
			location <= location;
			factor <= 2'b00;
			fail <= 0;
		end
		else begin
			if(!btn[0] && location[1:0] == 2'b00 && hit == 0)begin
				hit <= 1;
				location[5:0] <= location[7:2];
				location[7:6] <= rand_num;
				cool_down <= 1;
				factor <= 2'b01;
				fail <= 0;
			end
			else if(!btn[1] && location[1:0] == 2'b01 && hit == 0)begin
				hit <= 1;
				location[5:0] <= location[7:2];
				location[7:6] <= rand_num;
				cool_down <= 1;
				factor <= 2'b10;
				fail <= 0;
			end
			else if(!btn[2] && location[1:0] == 2'b10 && hit == 0)begin
				hit <= 1;
				location[5:0] <= location[7:2];
				location[7:6] <= rand_num;
				cool_down <= 1;
				factor <= 2'b00;
				fail <= 0;
			end
			else if(!btn[3] && location[1:0] == 2'b11 && hit == 0)begin
				hit <= 1;
				location[5:0] <= location[7:2];
				location[7:6] <= rand_num;
				cool_down <= 1;
				factor <= 2'b11;
				fail <= 0;
			end
			else if(!btn[0] && location[1:0] != 2'b00 || !btn[1] && location[1:0] != 2'b01 || !btn[2] && location[1:0] != 2'b10 || !btn[3] && location[1:0] != 2'b11) begin
				hit <= 0;
				location <= location;
				cool_down <= 0;
				factor <= 2'b00;
				fail <= 1;
				
			end
			else begin
				hit <= 0;
				location <= location;
				cool_down <= 0;
				factor <= 2'b00;
				fail <= 0;
			end
		end
	end
end

endmodule
