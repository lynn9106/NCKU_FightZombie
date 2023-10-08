module Final(clock,reset, dot_column ,dot_row, out1_timer, out2_timer, out1_score, out2_score, btn, red, green, blue, HSync, VSync);

input clock, reset ;
input [3:0]btn;
output [6:0] out1_timer, out2_timer, out1_score, out2_score;

wire [7:0] place;
wire [1:0] vga_S;

output wire [7:0]dot_row;
output wire [7:0]dot_column;

output HSync, VSync;
output [3:0] red, blue, green;

wire flag;
wire clk_div;
wire hit, fail;

//assign flag = 0;
//assign place = 8'b11100100;
Countdown_Timer CT(
	.clock(clock), 
	.reset(reset), 
	.out1(out1_timer), 
	.out2(out2_timer), 
	.flag(flag)
);//count down
Frequency_Divider fd(
	.clk(clock),
	.reset(reset),
	.clk_div(clk_div)
);
game_logic gl(
	.clock(clock),
	.reset(reset),
	.btn(btn), 
	.location(place), 
	.hit(hit), 
	.end_flag(flag),
	.fail(fail)
);//game

Dot_matrix_displayer dd(
	.clk_div(clk_div),
	.reset(reset),
	.place(place),
	.flag(flag),
	.dot_column(dot_column) ,
	.dot_row(dot_row)
);

state_vga(
	.clock(clock), 
	.reset(reset), 
	.hit(hit), 
	.end_flag(flag), 
	.fail(fail),
	.result(vga_S)
);

vga VG(
	.clock(clock),
	.reset(reset), 
	.state(vga_S), 
	.red(red), 
	.green(green), 
	.blue(blue), 
	.hs(HSync), 
	.vs(VSync)
);
	
score sc(
	.clk(clock),
	.rst(reset),
	.hit(hit),
	.end_flag(flag),
	.Out1(out1_score),
	.Out2(out2_score)
);
	
endmodule

