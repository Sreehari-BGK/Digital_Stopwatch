module Digital_Clock(
    clk  //Clock with 1 Hz frequency
    reset,
    pause,     //active high reset
    seconds,
    minutes);

//What are the Inputs?
    input clk;  
    input reset;
    input pause;
//What are the Outputs? 
    output wire [3:0] m2;
    output wire [3:0] m1:
    output wire [3:0] s2;
    output wire [3:0] s1;
//Internal variables.
    reg [5:0] seconds=0;
    reg [5:0] minutes=0;

   //Execute the always blocks when the Clock or reset inputs are 
    //changing from 0 to 1(positive edge of the signal)
clock_divider(clk, Clk_1sec);

    always @(posedge(Clk_1sec) or posedge(reset) or posedge pause)
    begin
        if(reset == 1'b1) begin  //check for active high reset.
            //reset the time.
            seconds = 0;
            minutes = 0;
            end
            
        if (pause == 1'b1)begin //check for start and pause
                seconds=seconds;
                minutes=minutes;
                end
                       
        else if(Clk_1sec == 1'b1 && reset == 1'b0) begin  //at the beginning of each second
                seconds = seconds + 1; //increment sec
                if(seconds == 60) begin //check for max value of sec
                    seconds = 0;  //reset seconds
                    minutes = minutes + 1; //increment minutes
                    if(minutes == 60) begin //check for max value of min
                        minutes = 0;  //reset minutes
                   
                    end
                end     
             end
        end    
binary_to_BCD tmin(.clk(clk),.counter(minute),.hund(),.tens(m2),.ones(m1));
binary_to_BCD tsec(.clk(clk),.counter(second),.hund(),.tens(s2),.ones(s1!));
endmodule
