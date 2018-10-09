`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:51 03/16/2017 
// Design Name: 
// Module Name:    alu_bottom 
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
module alu_bottom(
							src1,
							src2,
							less,
							equal,
							A_invert,
							B_invert,
							cin,
							operation,
							result,
							cout,
							set,
							overflow,
							equal_out
    );
	 
input src1;	 
input src2;	 
input less;
input equal;
input A_invert;
input B_invert;
input cin;
input [2-1:0] operation;

output result;
output cout;
output set;
output overflow;
output equal_out;

reg result;

//and , nor 
wire and_nor_src1;
wire and_nor_src2;
wire and_nor_result;
assign and_nor_src1 = (A_invert==1'b1)?~src1:src1;
assign and_nor_src2 = (B_invert==1'b1)?~src2:src2;
and and_nor_g(and_nor_result , and_nor_src1 , and_nor_src2); 

//or ,nand
wire or_nand_src1;
wire or_nand_src2;
wire or_nand_result;
assign or_nand_src1 = (A_invert==1'b1)?~src1:src1;
assign or_nand_src2 = (B_invert==1'b1)?~src2:src2;
or or_nand_g(or_nand_result , or_nand_src1 , or_nand_src2);



//add and sub
wire overflow , a , b , c , d;
wire add_sub_src2;
assign add_sub_src2 = (B_invert==1'b1)?~src2:src2;
wire add_sub_result;
full_adder adder(.op(operation) ,.src1(src1), .src2(add_sub_src2), .cin(cin), .cout(cout), .sum(add_sub_result));
xor check1(overflow,cin,cout);

wire e;
xor check(e,equal,add_sub_result);
assign equal_out=(equal==0)? 0:e;
/*xor check1(a , src1 ,add_sub_src2);
not check2(b , a);
xor check3(d , add_sub_result , src1);
assign overflow = (d==1'b1&&b==1'b1)?1'b1:1'b0; */

//slt
assign set = add_sub_result;

//mux to choose the output
always@( * )
begin
	if(operation==2'b00) begin
		result <= and_nor_result;
	end 
	else if(operation==2'b01) begin
		result <= or_nand_result;
	end 
	else if(operation==2'b10) begin
		result <= add_sub_result;
	end 
	else if(operation==2'b11) begin
		result <= less;
	end
end
endmodule
