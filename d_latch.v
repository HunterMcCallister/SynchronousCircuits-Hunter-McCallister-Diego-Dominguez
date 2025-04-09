`timescale 1ps/1ps

module d_latch(
    input D, E,
    output NotQ,
    output reg Q
);

    // Will contain D-Latch behavior
always @(D, E) begin
    if (E)
        Q <= D;
end
assign NotQ = ~Q;

endmodule