`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2010
// Design Name:
// Module Name:    alu
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module alu(
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
		 bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );


input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

//following defined by myself
wire set,set_equal;
wire [31:0]equal;
wire temp_overflow ;
wire [32-1:0] temp_cout ;
wire temp_zero ;
wire [32-1:0] temp_result;
wire z;

assign z=(temp_result==0)? 1:0;

reg [32-1:0] src1_input;
reg [32-1:0] src2_input;
reg [4-1:0] ALU_s;

wire A_invert;
wire B_invert;
//wire [32-1:0] temp_cout;

assign A_invert = ALU_s[3];
assign B_invert = ALU_s[2];




//32 bit alu 
alu_first alu_0(.src1(src1_input[0]), .src2(src2_input[0]), .less(set), .equal(set_equal), .A_invert(A_invert), .B_invert(B_invert), .cin(B_invert), .operation(ALU_s[1:0]), .b_operation(bonus_control[2:0]), .result(temp_result[0]), .cout(temp_cout[0]) , .equal_out(equal[0]));
alu_top alu_1(.src1(src1_input[1]), .src2(src2_input[1]), .less(1'b0), .equal(equal[0]),.A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[0]), .operation(ALU_s[1:0]), .result(temp_result[1]), .cout(temp_cout[1]) , .equal_out(equal[1]));
alu_top alu_2(.src1(src1_input[2]), .src2(src2_input[2]), .less(1'b0), .equal(equal[1]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[1]), .operation(ALU_s[1:0]),  .result(temp_result[2]), .cout(temp_cout[2]) , .equal_out(equal[2]));
alu_top alu_3(.src1(src1_input[3]), .src2(src2_input[3]), .less(1'b0), .equal(equal[2]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[2]), .operation(ALU_s[1:0]),  .result(temp_result[3]), .cout(temp_cout[3]) , .equal_out(equal[3]));
alu_top alu_4(.src1(src1_input[4]), .src2(src2_input[4]), .less(1'b0), .equal(equal[3]),.A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[3]), .operation(ALU_s[1:0]),  .result(temp_result[4]), .cout(temp_cout[4]) , .equal_out(equal[4]));
alu_top alu_5(.src1(src1_input[5]), .src2(src2_input[5]), .less(1'b0) ,.equal(equal[4]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[4]), .operation(ALU_s[1:0]),  .result(temp_result[5]), .cout(temp_cout[5]) , .equal_out(equal[5]));
alu_top alu_6(.src1(src1_input[6]), .src2(src2_input[6]), .less(1'b0), .equal(equal[5]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[5]), .operation(ALU_s[1:0]),  .result(temp_result[6]), .cout(temp_cout[6]) , .equal_out(equal[6]));
alu_top alu_7(.src1(src1_input[7]), .src2(src2_input[7]), .less(1'b0), .equal(equal[6]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[6]), .operation(ALU_s[1:0]),  .result(temp_result[7]), .cout(temp_cout[7]) , .equal_out(equal[7]));
alu_top alu_8(.src1(src1_input[8]), .src2(src2_input[8]), .less(1'b0), .equal(equal[7]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[7]), .operation(ALU_s[1:0]), .result(temp_result[8]), .cout(temp_cout[8]) , .equal_out(equal[8]));
alu_top alu_9(.src1(src1_input[9]), .src2(src2_input[9]), .less(1'b0), .equal(equal[8]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[8]), .operation(ALU_s[1:0]),  .result(temp_result[9]), .cout(temp_cout[9]) , .equal_out(equal[9]));
alu_top alu_10(.src1(src1_input[10]), .src2(src2_input[10]), .less(1'b0),.equal(equal[9]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[9]), .operation(ALU_s[1:0]),  .result(temp_result[10]), .cout(temp_cout[10]) , .equal_out(equal[10]));
alu_top alu_11(.src1(src1_input[11]), .src2(src2_input[11]), .less(1'b0),.equal(equal[10]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[10]), .operation(ALU_s[1:0]),  .result(temp_result[11]), .cout(temp_cout[11]) , .equal_out(equal[11]));
alu_top alu_12(.src1(src1_input[12]), .src2(src2_input[12]), .less(1'b0),.equal(equal[11]),.A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[11]), .operation(ALU_s[1:0]),  .result(temp_result[12]), .cout(temp_cout[12]) , .equal_out(equal[12]));
alu_top alu_13(.src1(src1_input[13]), .src2(src2_input[13]), .less(1'b0),.equal(equal[12]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[12]), .operation(ALU_s[1:0]), .result(temp_result[13]), .cout(temp_cout[13]) , .equal_out(equal[13]));
alu_top alu_14(.src1(src1_input[14]), .src2(src2_input[14]), .less(1'b0),.equal(equal[13]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[13]), .operation(ALU_s[1:0]), .result(temp_result[14]), .cout(temp_cout[14]) , .equal_out(equal[14]));
alu_top alu_15(.src1(src1_input[15]), .src2(src2_input[15]), .less(1'b0),.equal(equal[14]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[14]), .operation(ALU_s[1:0]),  .result(temp_result[15]), .cout(temp_cout[15]) , .equal_out(equal[15]));
alu_top alu_16(.src1(src1_input[16]), .src2(src2_input[16]), .less(1'b0),.equal(equal[15]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[15]), .operation(ALU_s[1:0]),  .result(temp_result[16]), .cout(temp_cout[16]) , .equal_out(equal[16]));
alu_top alu_17(.src1(src1_input[17]), .src2(src2_input[17]), .less(1'b0),.equal(equal[16]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[16]), .operation(ALU_s[1:0]),  .result(temp_result[17]), .cout(temp_cout[17]) , .equal_out(equal[17]));
alu_top alu_18(.src1(src1_input[18]), .src2(src2_input[18]), .less(1'b0),.equal(equal[17]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[17]), .operation(ALU_s[1:0]),  .result(temp_result[18]), .cout(temp_cout[18]) , .equal_out(equal[18]));
alu_top alu_19(.src1(src1_input[19]), .src2(src2_input[19]), .less(1'b0),.equal(equal[18]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[18]), .operation(ALU_s[1:0]),  .result(temp_result[19]), .cout(temp_cout[19]) , .equal_out(equal[19]));
alu_top alu_20(.src1(src1_input[20]), .src2(src2_input[20]), .less(1'b0),.equal(equal[19]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[19]), .operation(ALU_s[1:0]),  .result(temp_result[20]), .cout(temp_cout[20]) , .equal_out(equal[20]));
alu_top alu_21(.src1(src1_input[21]), .src2(src2_input[21]), .less(1'b0),.equal(equal[20]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[20]), .operation(ALU_s[1:0]),  .result(temp_result[21]), .cout(temp_cout[21]) , .equal_out(equal[21]));
alu_top alu_22(.src1(src1_input[22]), .src2(src2_input[22]), .less(1'b0),.equal(equal[21]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[21]), .operation(ALU_s[1:0]),  .result(temp_result[22]), .cout(temp_cout[22]) , .equal_out(equal[22]));
alu_top alu_23(.src1(src1_input[23]), .src2(src2_input[23]), .less(1'b0),.equal(equal[22]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[22]), .operation(ALU_s[1:0]),  .result(temp_result[23]), .cout(temp_cout[23]) , .equal_out(equal[23]));
alu_top alu_24(.src1(src1_input[24]), .src2(src2_input[24]), .less(1'b0),.equal(equal[23]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[23]), .operation(ALU_s[1:0]),  .result(temp_result[24]), .cout(temp_cout[24]) , .equal_out(equal[24]));
alu_top alu_25(.src1(src1_input[25]), .src2(src2_input[25]), .less(1'b0),.equal(equal[24]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[24]), .operation(ALU_s[1:0]),  .result(temp_result[25]), .cout(temp_cout[25]) , .equal_out(equal[25]));
alu_top alu_26(.src1(src1_input[26]), .src2(src2_input[26]), .less(1'b0),.equal(equal[25]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[25]), .operation(ALU_s[1:0]),  .result(temp_result[26]), .cout(temp_cout[26]) , .equal_out(equal[26]));
alu_top alu_27(.src1(src1_input[27]), .src2(src2_input[27]), .less(1'b0),.equal(equal[26]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[26]), .operation(ALU_s[1:0]),  .result(temp_result[27]), .cout(temp_cout[27]) , .equal_out(equal[27]));
alu_top alu_28(.src1(src1_input[28]), .src2(src2_input[28]), .less(1'b0),.equal(equal[27]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[27]), .operation(ALU_s[1:0]),  .result(temp_result[28]), .cout(temp_cout[28]) , .equal_out(equal[28]));
alu_top alu_29(.src1(src1_input[29]), .src2(src2_input[29]), .less(1'b0),.equal(equal[28]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[28]), .operation(ALU_s[1:0]),  .result(temp_result[29]), .cout(temp_cout[29]) , .equal_out(equal[29]));
alu_top alu_30(.src1(src1_input[30]), .src2(src2_input[30]), .less(1'b0),.equal(equal[29]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[29]), .operation(ALU_s[1:0]),  .result(temp_result[30]), .cout(temp_cout[30]) , .equal_out(equal[30]));
alu_bottom alu_31(.src1(src1_input[31]), .src2(src2_input[31]), .less(1'b0),.equal(equal[30]), .A_invert(A_invert), .B_invert(B_invert), .cin(temp_cout[30]), .operation(ALU_s[1:0]),  .result(temp_result[31]), .cout(temp_cout[31]), .set(set), .overflow(temp_overflow) , .equal_out(set_equal));

always@(*)
begin
	if(~rst_n)
	begin
		overflow <= 1'b0;
		result <= 32'd0;
		zero <= 1'b0;
		cout <= 1'b0;
	end
	else 
	begin
		ALU_s <= ALU_control;
		src1_input <= src1;
		src2_input <= src2;
		result <= temp_result;
		zero <= z;
		cout <= (ALU_s[1:0]==2'b10)?temp_cout[31]:0;
		overflow <= (ALU_s[1:0]==2'b10)? temp_overflow:0;
	end

end

endmodule
