module Seven_Displayer(In, flag, digit, Out);

input [3:0]In;
input digit;
input flag;
output [6:0]Out;

reg [6:0]Out;

always@(digit or In)

begin
	case(digit)
		0 : begin
			if(flag) Out = 7'b1000000; //0
			else begin
				case(In)
					0 : Out = 7'b0010010; //5
					1 : Out = 7'b0011001; //4
					2 : Out = 7'b0110000; //3
					3 : Out = 7'b0100100; //2
					4 : Out = 7'b1111001; //1
					5 : Out = 7'b1000000; //0
					6 : Out = 7'b0010000; //9
					7 : Out = 7'b0000000; //8
					8 : Out = 7'b1111000; //7
					9 : Out = 7'b0000010; //6
					10 : Out = 7'b0010010; //5
					11 : Out = 7'b0011001; //4
					12 : Out = 7'b0110000; //3
					13 : Out = 7'b0100100; //2
					14 : Out = 7'b1111001; //1
					15 : Out = 7'b1000000; //0
					default : Out = 7'b1000000; //5
				endcase
			end
		end
		1 : begin
			if(flag) Out = 7'b1000000; //0
			else begin
				case(In)
					1 : Out = 7'b1111001; //1
					2 : Out = 7'b1111001;
					3 : Out = 7'b1111001;
					4 : Out = 7'b1111001;
					5 : Out = 7'b1111001;
					6 : Out = 7'b1000000; //0
					7 : Out = 7'b1000000;
					8 : Out = 7'b1000000;
					9 : Out = 7'b1000000;
					10 : Out = 7'b1000000;
					11 : Out = 7'b1000000;
					12 : Out = 7'b1000000;
					13 : Out = 7'b1000000;
					14 : Out = 7'b1000000;
					15 : Out = 7'b1000000;
					default : Out = 7'b1111001; //1
				endcase
			end
		end
	endcase
end

endmodule
