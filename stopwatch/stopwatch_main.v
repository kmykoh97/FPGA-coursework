module stopwatch(clk, key_reset, key_start_pause, key_display_stop, hex0, hex1, hex2, hex3, hex4, hex5, led0, led1, led2);
input        clk;
input        key_reset, key_start_pause, key_display_stop;  // keys, default of 1, 0 when pressed
output [6:0] hex0, hex1, hex2, hex3, hex4, hex5;  // display
output       led0, led1, led2;  // LEDs, default of 0, light when 1

reg led0, led1, led2;

// time display
reg [3:0] minute_display_high;
reg [3:0] minute_display_low;
reg [3:0] second_display_high;
reg [3:0] second_display_low;
reg [3:0] msecond_display_high;
reg [3:0] msecond_display_low;

// time counter background
reg [3:0] minute_counter_high;
reg [3:0] minute_counter_low;
reg [3:0] second_counter_high;
reg [3:0] second_counter_low;
reg [3:0] msecond_counter_high;
reg [3:0] msecond_counter_low;

// from binary digit to 7-seg display
sevenseg LED8_minute_display_high(minute_display_high, hex5);
sevenseg LED8_minute_display_low(minute_display_low, hex4);
sevenseg LED8_second_display_high(second_display_high, hex3);
sevenseg LED8_second_display_low(second_display_low, hex2);
sevenseg LED8_msecond_display_high(msecond_display_high, hex1);
sevenseg LED8_msecond_display_low(msecond_display_low, hex0);

// utilities registers
reg [31:0] stopwatch_clk; // stopwatch derived clock counter, increment every cycle until 500000(10ms)
reg freeze; // whether to freeze screen
reg timess; // whether to start or stop time run

// debouncer
reg key_reset_state; // current state of the key_reset
reg key_start_pause_state; // current state of the key_start_pause
reg key_display_stop_state; // current state of the key_display_stop
reg [8:0] counter_reset; // counter for time in key_reset
reg [8:0] counter_start_pause; // counter for time in key_start_pause
reg [8:0] counter_display_stop; // counter for time in key_display_stop

// LED indicators
always @ (key_reset) begin
    led0 = key_reset;
end

always @ (key_start_pause) begin
    led1 = key_start_pause;
end

always @ (key_display_stop) begin
    led2 = key_display_stop;
end

// actual logic of stopwatch
always @ (posedge clk) begin
    if (clk) begin
	 
        // debouncer for key_reset
        if (key_reset_state && !key_reset) begin
            counter_reset = counter_reset + 1;

            if (counter_reset == 8'b11111111) begin
                counter_reset = 0;
                key_reset_state = ~key_reset_state;
            end
        end else if (!key_reset_state && key_reset) begin
            counter_reset = counter_reset + 1;

            if (counter_reset == 8'b11111111) begin
                counter_reset = 0;
                key_reset_state = ~key_reset_state;

					 msecond_counter_low = 0;
					 msecond_counter_high = 0;
					 second_counter_low = 0;
					 second_counter_high = 0;
					 minute_counter_low = 0;
					 minute_counter_high = 0;
            end
        end else begin
            counter_reset = 0; // for continuing state
        end

		  // debouncer for key_start_pause
        if (key_start_pause_state && !key_start_pause) begin
            counter_start_pause = counter_start_pause + 1;

            if (counter_start_pause == 8'b11111111) begin
                counter_start_pause = 0;
                key_start_pause_state = ~key_start_pause_state;
					 timess = ~timess;
            end
        end else if (!key_start_pause_state && key_start_pause) begin
            counter_start_pause = counter_start_pause + 1;

            if (counter_start_pause == 8'b11111111) begin
                counter_start_pause = 0;
                key_start_pause_state = ~key_start_pause_state;
            end
        end else begin
            counter_start_pause = 0;
        end
	
		  // debouncer for key_display_stop
        if (key_display_stop_state && !key_display_stop) begin
            counter_display_stop = counter_display_stop + 1;

            if (counter_display_stop == 8'b11111111) begin
                counter_display_stop = 0;
                key_display_stop_state = ~key_display_stop_state;
					 freeze = ~freeze;
            end
        end else if (!key_display_stop_state && key_display_stop) begin
            counter_display_stop = counter_display_stop + 1;

            if (counter_display_stop == 8'b11111111) begin
                counter_display_stop = 0;
                key_display_stop_state = ~key_display_stop_state;
            end
        end else begin
            counter_display_stop = 0;
        end

        // update display
        if (freeze) begin
            minute_display_high = minute_counter_high;
            minute_display_low = minute_counter_low;
            second_display_high = second_counter_high;
            second_display_low = second_counter_low;
            msecond_display_high = msecond_counter_high;
            msecond_display_low = msecond_counter_low;
        end

        // update time
        if (timess) begin
            stopwatch_clk = stopwatch_clk + 1;

            if (stopwatch_clk == 500000) begin
                stopwatch_clk = 0;
                msecond_counter_low = msecond_counter_low + 1;

                if (msecond_counter_low == 10) begin
                    msecond_counter_low = 0;
                    msecond_counter_high = msecond_counter_high + 1;

                    if (msecond_counter_high == 10) begin
                        msecond_counter_high = 0;
                        second_counter_low = second_counter_low + 1;

                        if (second_counter_low == 10) begin
                            second_counter_low = 0;
                            second_counter_high = second_counter_high + 1;

                            if (second_counter_high == 6) begin
                                second_counter_high = 0;
                                minute_counter_low = minute_counter_low + 1;

                                if (minute_counter_low == 10) begin
                                    minute_counter_low = 0;
                                    minute_counter_high = minute_counter_high + 1;

                                    if (minute_counter_high == 10) begin
                                        minute_counter_high = 0;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
endmodule

// 4bit 的 BCD 码至 7 段 LED 数码管译码器模块
// 可供实例化共 6 个显示译码模块
module sevenseg(data, ledsegments);
input [3:0] data;
output [6:0] ledsegments;
reg [6:0] ledsegments;
always @ ( * )
    // gfe_dcba, 7 段 LED 数码管的位段编号
    // 654_3210, DE1-SOC 板上的信号位编号, DE1-SOC 板上的数码管为共阳极接法。
    case(data)
        0: ledsegments = 7'b100_0000;
        1: ledsegments = 7'b111_1001;
        2: ledsegments = 7'b010_0100;
        3: ledsegments = 7'b011_0000;
        4: ledsegments = 7'b001_1001;
        5: ledsegments = 7'b001_0010;
        6: ledsegments = 7'b000_0010;
        7: ledsegments = 7'b111_1000;
        8: ledsegments = 7'b000_0000;
        9: ledsegments = 7'b001_0000;
        default: ledsegments = 7'b111_1111;  // 其它值时全灭。
    endcase
endmodule  // stopwatch