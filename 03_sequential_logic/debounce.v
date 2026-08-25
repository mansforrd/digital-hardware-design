module debounce (
    input clk,
    input rst,
    input noisy_input,
    output reg clean_output
);

    parameter THRESHOLD = 20; 

    reg [7:0] stability_counter;
    reg last_input;

    always @(posedge clk) begin
        if (rst) begin
            stability_counter <= 0;
            clean_output      <= 0;
            last_input        <= 0;
        end
        else begin
            if (noisy_input != last_input) begin
                
                stability_counter <= 0;
            end
            else if (stability_counter < THRESHOLD) begin
                
                stability_counter <= stability_counter + 1;
            end
            else begin
                ç
                clean_output <= noisy_input;
            end

            last_input <= noisy_input;
        end
    end

endmodule
