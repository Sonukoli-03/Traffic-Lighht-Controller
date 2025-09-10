`timescale 1ns / 1ps
module Traffic_Light_Controller(
    input clk,
    input rst,
    output reg [2:0] light_M1,
    output reg [2:0] light_S,
    output reg [2:0] light_MT,
    output reg [2:0] light_M2
);

    // State encoding
    parameter S1 = 0, S2 = 1, S3 = 2, S4 = 3, S5 = 4, S6 = 5;

    reg [3:0] count;    // Timer counter
    reg [2:0] ps;       // Present state

    // Timing durations for each state
    parameter sec7 = 7,
              sec5 = 5,
              sec2 = 2,
              sec3 = 3;

    // State Transition Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps <= S1;
            count <= 0;
        end 
        else begin
            case (ps)
                S1: if (count < sec7)
                        count <= count + 1;
                    else begin
                        ps <= S2;
                        count <= 0;
                    end

                S2: if (count < sec2)
                        count <= count + 1;
                    else begin
                        ps <= S3;
                        count <= 0;
                    end

                S3: if (count < sec5)
                        count <= count + 1;
                    else begin
                        ps <= S4;
                        count <= 0;
                    end

                S4: if (count < sec2)
                        count <= count + 1;
                    else begin
                        ps <= S5;
                        count <= 0;
                    end

                S5: if (count < sec3)
                        count <= count + 1;
                    else begin
                        ps <= S6;
                        count <= 0;
                    end

                S6: if (count < sec2)
                        count <= count + 1;
                    else begin
                        ps <= S1;
                        count <= 0;
                    end

                default: ps <= S1;
            endcase
        end
    end

    // Output Logic
    always @(ps) begin
        case (ps)
            S1: begin
                light_M1 <= 3'b001; // Green
                light_M2 <= 3'b001; // Green
                light_MT <= 3'b100; // Red
                light_S  <= 3'b100; // Red
            end
            S2: begin
                light_M1 <= 3'b001; // Green
                light_M2 <= 3'b010; // Yellow
                light_MT <= 3'b100; // Red
                light_S  <= 3'b100; // Red
            end
            S3: begin
                light_M1 <= 3'b001; // Green
                light_M2 <= 3'b100; // Red
                light_MT <= 3'b001; // Green
                light_S  <= 3'b100; // Red
            end
            S4: begin
                light_M1 <= 3'b010; // Yellow
                light_M2 <= 3'b100; // Red
                light_MT <= 3'b010; // Yellow
                light_S  <= 3'b100; // Red
            end
            S5: begin
                light_M1 <= 3'b100; // Red
                light_M2 <= 3'b100; // Red
                light_MT <= 3'b100; // Red
                light_S  <= 3'b001; // Green
            end
            S6: begin
                light_M1 <= 3'b100; // Red
                light_M2 <= 3'b100; // Red
                light_MT <= 3'b100; // Red
                light_S  <= 3'b010; // Yellow
            end
            default: begin
                light_M1 <= 3'b000;
                light_M2 <= 3'b000;
                light_MT <= 3'b000;
                light_S  <= 3'b000;
            end
        endcase
    end
endmodule
