`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:25:08 03/15/2017 
// Design Name: 
// Module Name:    full_adder 
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
module full_adder(
						src1,
						src2,
						cin,
						cout,
						sum,
						op
    );

input src1;	 
input src2;	 
input cin;
input [1:0]op;	 
output cout;	 
output sum;	 

wire a , b , c, temp , flag;

assign flag=(op==2'b10 || op==2'b11 )?1:0;

//create sum
xor g1(a , src1 , src2);
xor g2(sum , cin , a);

//create cout
and g3(b , a , cin);
and g4(c , src1 , src2);
or g5(temp , b , c);
and g6(cout,temp,flag);
endmodule
