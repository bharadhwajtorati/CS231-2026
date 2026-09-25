module universal_shift_reg (
    input clk,
    input rst,
    input [1:0] mode,
    input serial_in,
    input [3:0] parallel_in,
    output [3:0] q
);
    // TODO: Implement the universal shift register.
    reg [3:0] shiftreg;
    assign q=shiftreg;
    always @(posedge clk ) begin
        if(rst)
            shiftreg<=4'b0000;
        else
        begin
            case (mode)
                2'b01:
                    shiftreg<={serial_in,shiftreg[3:1]};
                2'b10:
                    shiftreg<={shiftreg[2:0],serial_in};
                2'b11:
                    shiftreg<=parallel_in;
            endcase
        end
    end
endmodule