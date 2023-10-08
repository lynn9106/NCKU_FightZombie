module Countdown_Timer(clock, reset, out1, out2, flag);

input clock;
input reset;
output [6:0]out1;
output [6:0]out2;
output flag;

wire clock;
wire reset;
wire sec;
wire [3:0]count;
wire flag;
wire [6:0]out1;
wire [6:0]out2;

Frequency_Divider_sec(clock, reset, sec);
counter(sec, reset, count, flag);
Seven_Displayer(count, flag, 0, out1);
Seven_Displayer(count, flag, 1, out2);

endmodule
