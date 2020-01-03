module Draw_Tubes(
	input clk10,
	input clr,
	input game_end,
	output reg [9:0] tube1_y_pos,
	output reg [9:0] tube2_y_pos,
	output reg [9:0] tube3_y_pos,
	output reg [9:0] tube1_x_pos,
	output reg [9:0] tube2_x_pos,
	output reg [9:0] tube3_x_pos,
	output reg [7:0] score
    );
	
	
	initial score = 8'b0;
	initial tube1_x_pos = 10'd364;
	initial tube2_x_pos = 10'd584;
	initial tube3_x_pos = 10'd804;
	initial tube1_y_pos = 10'd240;
	initial tube2_y_pos = 10'd220;
	initial tube3_y_pos = 10'd150;
	
	wire [6:0] rand;
	reg [9:0] randconv;
	
	random_gen pipe_gen(
		.clk(clk10),
		.out(rand)
	);
	
	always @ (posedge clk10, negedge clr) begin
		if (!clr) begin
			score <= 8'b0;
			tube1_x_pos <= 10'd324;
			tube2_x_pos <= 10'd400;
			tube3_x_pos <= 10'd804;
			tube1_y_pos <= 10'd240;
			tube2_y_pos <= 10'd240;
			tube3_y_pos <= 10'd150;
		end
		else if (~game_end) begin
			// converted rand to randconv, lowing game difficulty
			randconv <= rand;
			tube1_x_pos <= tube1_x_pos - 10'd3;
			tube2_x_pos <= tube2_x_pos - 10'd3;
			tube3_x_pos <= tube3_x_pos - 10'd3;
			// scoring algorithm should be done here, not implemented
		end
	end

endmodule