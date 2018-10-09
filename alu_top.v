`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2011 
// Design Name: 
// Module Name:    alu_top 
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

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,					//1 bit less     (input)
               equal,
					A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
					result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               equal_out
					);

input         src1;
input         src2;
input         less;
input 		  equal;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;
output        equal_out;
reg           result;


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
assign or_nand_src1 = (A_invert==1'b1)? !src1:src1;
assign or_nand_src2 = (B_invert==1'b1)? !src2:src2;
or or_nand_g(or_nand_result , or_nand_src1 , or_nand_src2);

//slt

//add and sub
wire add_sub_src2;
assign add_sub_src2 = (B_invert==1'b1)?~src2:src2;
wire add_sub_result;
full_adder adder(.op(operation) ,.src1(src1), .src2(add_sub_src2), .cin(cin), .cout(cout), .sum(add_sub_result));

wire e;
xor check(e,equal,add_sub_result);
assign equal_out=(equal==0)? 0:e;
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
