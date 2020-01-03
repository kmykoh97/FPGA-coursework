module gt(a, b, d);
	input  [31:0] a, b;
	output reg [31:0] d;

	wire   [31:0] c;
	
//	assign c = 8'b000010;
	
	always @(*) begin
		if (a > b)
			d <= 1;
		else
			d <= 0;
	end
//	always @(*) begin
//		if (a[31] > b[31])
//			d <= 1;
//		else if (a[31] < b[31])
//			d <= 0;
//		else
//			if (a[30] > b[30])
//				d <= 1;
//			else if (a[30] < b[30])
//				d <= 0;
//			 else
//				if (a[29] > b[29])
//					d <= 1;
//				else if (a[29] < b[29])
//					d <= 0;
//				else
//					if (a[28] > b[28])
//						d <= 1;
//					else if (a[28] < b[28])
//						d <= 0;
//					else
//						if (a[27] > b[27])
//							d <= 1;
//						else if (a[27] < b[27])
//							d <= 0;
//						else
//							if (a[26] > b[26])
//								d <= 1;
//							else if (a[26] < b[26])
//								d <= 0;
//							else
//								if (a[25] > b[25])
//									d <= 1;
//								else if (a[25] < b[25])
//									d <= 0;
//								else
//									if (a[24] > b[24])
//										d <= 1;
//									else if (a[24] < b[24])
//										d <= 0;
//									else
//										if (a[23] > b[23])
//											d <= 1;
//										else if (a[23] < b[23])
//											d <= 0;
//										else
//											if (a[22] > b[22])
//			d <= 1;
//		else if (a[22] < b[22])
//			d <= 0;
//		else
//			if (a[21] > b[21])
//			d <= 1;
//		else if (a[21] < b[21])
//			d <= 0;
//		else
//			if (a[20] > b[20])
//			d <= 1;
//		else if (a[20] < b[20])
//			d <= 0;
//		else
//			if (a[19] > b[19])
//			d <= 1;
//		else if (a[19] < b[19])
//			d <= 0;
//		else
//			if (a[18] > b[18])
//			d <= 1;
//		else if (a[18] < b[18])
//			d <= 0;
//		else
//			if (a[17] > b[17])
//			d <= 1;
//		else if (a[17] < b[17])
//			d <= 0;
//		else
//			if (a[16] > b[16])
//			d <= 1;
//		else if (a[16] < b[16])
//			d <= 0;
//		else
//			if (a[15] > b[15])
//			d <= 1;
//		else if (a[15] < b[15])
//			d <= 0;
//		else
//			if (a[14] > b[14])
//			d <= 1;
//		else if (a[14] < b[14])
//			d <= 0;
//		else
//			if (a[13] > b[13])
//			d <= 1;
//		else if (a[13] < b[13])
//			d <= 0;
//		else
//			if (a[12] > b[12])
//			d <= 1;
//		else if (a[12] < b[12])
//			d <= 0;
//		else
//			if (a[11] > b[11]) 
//			d <= 1;
//		else if (a[11] < b[11]) 
//			d <= 0;
//		else
//			if (a[10] > b[10]) 
//			d <= 1;
//		else if (a[10] < b[10]) 
//			d <= 0;
//		else
//			if (a[9] > b[9]) 
//			d <= 1;
//		else if (a[9] < b[9]) 
//			d <= 0;
//		else
//			if (a[8] > b[8]) 
//			d <= 1;
//		else if (a[8] < b[8]) 
//			d <= 0;
//		else
//			if (a[7] > b[7]) 
//			d <= 1;
//		else if (a[7] < b[7])
//			d <= 0;
//		else
//			if (a[6] > b[6])
//			d <= 1;
//		else if (a[6] < b[6])
//			d <= 0;
//		else
//			if (a[5] > b[5]) 
//			d <= 1;
//		else if (a[5] < b[5])
//			d <= 0;
//		else
//			if (a[4] > b[4])
//			d <= 1;
//		else if (a[4] < b[4])
//			d <= 0;
//		else 
//			if (a[3] > b[3]) 
//			d <= 1;
//		else if (a[3] < b[3]) 
//			d <= 0;
//		else
//			if (a[2] > b[2])
//			d <= 1;
//		else if (a[2] < b[2]) 
//			d <= 0;
//		else
//			if (a[1] > b[1]) 
//			d <= 1;
//		else if (a[1] < b[1]) 
//			d <= 0;
//		else
//			if (a[0] > b[0]) 
//			d <= 1;
//		else if (a[0] < b[0]) 
//			d <= 0;
//		else
//			d <= 0;
//		end
endmodule