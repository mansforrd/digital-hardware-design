module debounce (
    input clk,
    input rst,
    input noisy_input,
    output reg clean_output
);

    parameter THRESHOLD = 20;  // number of stable clock cycles required

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
                // input just changed -- restart the stability count
                stability_counter <= 0;
            end
            else if (stability_counter < THRESHOLD) begin
                // input has been stable -- keep counting up
                stability_counter <= stability_counter + 1;
            end
            else begin
                // input has been stable long enough -- accept it
                clean_output <= noisy_input;
            end

            last_input <= noisy_input;
        end
    end

endmodule
