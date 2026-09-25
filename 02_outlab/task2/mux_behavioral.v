module mux_behavioral (
    input wire a,
    input wire b,
    input wire sel,
    output reg y
);
    always @(*) begin
        y<=!sel&a|sel&b;
    end
endmodule
