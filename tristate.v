module tristate

(
input               q,           
input               bufe,
output				out
);
    always @() begin
        if (bufe == 1)
            assign out = q;
        else
        assign out = X;
    end

endmodule