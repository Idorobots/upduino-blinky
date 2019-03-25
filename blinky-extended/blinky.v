module blinky (output wire led_blue,
               output wire led_green,
               output wire led_red);

   wire clk;
   
   SB_HFOSC inthosc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

   localparam N = 27;

   reg [N:0] counter;
   always @(posedge clk)
     counter <= counter + 1;


   SB_RGBA_DRV RGB_DRIVER ( 
			    .RGBLEDEN (1'b1),
			    .RGB0PWM  (counter[N]),
			    .RGB1PWM  (counter[N-1]),
			    .RGB2PWM  (counter[N-2]),
			    .CURREN   (1'b1), 
			    .RGB0     (led_blue),
			    .RGB1     (led_green),
			    .RGB2     (led_red)
			    );
   defparam RGB_DRIVER.CURRENT_MODE = "0b1";
   defparam RGB_DRIVER.RGB0_CURRENT = "0b000001";
   defparam RGB_DRIVER.RGB1_CURRENT = "0b000001";
   defparam RGB_DRIVER.RGB2_CURRENT = "0b000001";
endmodule
