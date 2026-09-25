module bhavesh_traffic_light (
    input clk, rst_n,
    input ped_button,
    input tick_1hz,

    output [1:0] state_out,
    output [7:0] duration_out,
    output red, green, yellow
);

    // TODO

endmodule


// -----------------------------------------------------------
// CONTROL
// -----------------------------------------------------------
module traffic_fsm (
    input clk, rst_n,
    input ped_button,
    input [7:0] remaining_next,
    input do_transition,

    output reg [1:0] current_state,
    output    [1:0] next_state,
    output reg [7:0] remaining,
    output reg       ped_request
);

    localparam GREEN = 2'b00, YELLOW = 2'b01, RED = 2'b10;

    // next-state logic (purely combinational)
    // TODO
    reg [1:0] next_state_r;
    always @(*) begin
        case (current_state)
            GREEN:   next_state_r = YELLOW;
            YELLOW:  next_state_r = RED;
            RED:     next_state_r = GREEN;
            default: next_state_r = GREEN;
        endcase
    end
    assign next_state = next_state_r;
    // register updates
    // TODO
    always @(posedge clk) begin
        if(!rst_n)
        begin
            current_state<=GREEN;
            remaining<=8'd25;
            ped_request<=1'b0;
        end
        else
        begin
            if(ped_button)
                ped_request<=1'b1;
            remaining<=remaining_next;
            if(do_transition)
            begin
                current_state<=next_state;
                if(next_state==GREEN)
                    ped_request<=1'b0;
            end
        end

    end

endmodule


// -----------------------------------------------------------
// DATAPATH
// -----------------------------------------------------------
module duration_datapath (
    input [1:0] current_state,
    input [1:0] next_state,
    input [7:0] remaining,
    input       tick_1hz,
    input       ped_button,
    input       ped_request,

    output reg [7:0] remaining_next,
    output reg       do_transition
);

    localparam GREEN = 2'b00, YELLOW = 2'b01, RED = 2'b10;

    // TODO: update + modify
    always @(*) begin
        if(tick_1hz)
        begin
            if(remaining_next>1)
                remaining_next=remaining-1;
            else
            begin
                do_transition=1'b1;
                case (next_state)
                    GREEN: remaining_next=8'd25;
                    YELLOW:remaining_next=8'd5;
                    RED:remaining_next = ped_request ? 8'd40 : 8'd30;
                endcase
            end
        end
        else
        begin
            remaining_next=remaining;
            do_transition=1'b0;
        end
    end

endmodule


// -----------------------------------------------------------
// OUTPUT DECODE
// -----------------------------------------------------------
module output_decoder (
    input [1:0] state,
    output red, green, yellow
);

    localparam GREEN = 2'b00, YELLOW = 2'b01, RED = 2'b10;

    assign green  = (state == GREEN);
    assign yellow = (state == YELLOW);
    assign red    = (state == RED);

endmodule