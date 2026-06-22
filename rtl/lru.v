module lru(

    input clk,
    input rst,

    input access,

    output reg [2:0] victim

);

always @(posedge clk or posedge rst)
begin

    if(rst)
        victim <= 0;

    else if(access)
        victim <= victim + 1;

end

endmodule