module fourbit_comparator (
    input wire [3:0] a,
    input wire [3:0] b,
    output wire eq,
    output wire gt,
    output wire lt
);
    integer i;
    always @(*) begin
        for(i=3;i>=0 && ~(a[i]^b[i]);i=i-1)
        begin
        end
    end
    assign eq = (i==-1);
    assign gt = ~eq & a[i];
    assign lt = ~eq & b[i];
endmodule