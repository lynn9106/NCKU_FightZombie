module vga(clock, reset, state, red, green, blue, hs, vs);
input clock, reset;
input [1:0] state;
output [3:0] red;
output [3:0] green;
output [3:0] blue;
output hs, vs;
reg [3:0] red, green, blue;
reg [3:0] r_counter, g_counter, b_counter;
reg [11:0] h_cnt; 
reg [11:0] v_cnt; 
reg clk_25M;
wire active_flag;

parameter running = 0, hit = 1, fail = 2, ending = 3;
parameter H_SYNC_PULSE = 96, H_LINE_PERIOD = 800, 
			H_BACK_PORCH = 48, H_ACTIVE_TIME = 640, H_FRONT_PORCH = 16;
parameter V_SYNC_PULSE = 2, V_FRAME_PERIOD = 525, 
			V_BACK_PORCH = 33, V_ACTIVE_TIME = 480, V_FRONT_PORCH = 10;
parameter COLOR_BAR_WIDTH = H_ACTIVE_TIME/8  ; 
                
always @(posedge clock)
begin
    clk_25M <= ~clk_25M;     
end

always @(posedge clk_25M)
begin
    if(h_cnt == H_LINE_PERIOD - 1'b1)
        h_cnt <= 12'd0   ;
    else
        h_cnt <= h_cnt + 1'b1  ;                
end                
assign hs = (h_cnt < H_SYNC_PULSE) ? 1'b0 : 1'b1; 

always @(posedge clk_25M)
begin
    if(v_cnt == V_FRAME_PERIOD - 1'b1)
        v_cnt <=  12'd0   ;
    else if(h_cnt == H_LINE_PERIOD - 1'b1)
        v_cnt <=  v_cnt + 1'b1  ;
    else
        v_cnt <=  v_cnt ;                        
end                
assign vs = (v_cnt < V_SYNC_PULSE) ? 1'b0 : 1'b1; 

assign active_flag = (h_cnt >= (H_SYNC_PULSE + H_BACK_PORCH)) && 
							(h_cnt <= (H_SYNC_PULSE + H_BACK_PORCH + H_ACTIVE_TIME)) && 
                     (v_cnt >= (V_SYNC_PULSE + V_BACK_PORCH)) &&
							(v_cnt <= (V_SYNC_PULSE + V_BACK_PORCH + V_ACTIVE_TIME));
							

always @(posedge clk_25M)
begin
	if(active_flag)     
	begin
		if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH)) // red
		begin
			case(state)
				running: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b0000;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end
		else if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH*2)) // green
		begin
			case(state)
				running: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end 
		else if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH*3)) // blue
		begin
			case(state)
				running: begin
					red <= 4'b0000;
					green <= 4'b0000;
					blue <= 4'b1111;
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b0000;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end
		else if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH*4)) // white
		begin
			case(state)
				running: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end 
		else if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH*5)) // black
		begin
			case(state)
				running: begin
					red <= 4'b0000;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b0000;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end 
		else if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH*6)) // yellow
		begin
			case(state)
				running: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end 
		else if(h_cnt < (H_SYNC_PULSE + H_BACK_PORCH + COLOR_BAR_WIDTH*7)) // purple
		begin
			case(state)
				running: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b1111; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b0000;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end	
		else    	// green+blue
		begin
			case(state)
				running: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
				hit: begin
					red <= 4'b1111;
					green <= 4'b0000;
					blue <= 4'b0000; 
				end
				fail: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
				ending: begin
					red <= 4'b0000;
					green <= 4'b1111;
					blue <= 4'b0000; 
				end
				default: begin
					red <= 4'b1111;
					green <= 4'b1111;
					blue <= 4'b1111; 
				end
			endcase
		end       	            
	end
	else
	begin
		red <= 4'b0000;
		green <= 4'b0000;
		blue <= 4'b0000;
	end           
end
endmodule

