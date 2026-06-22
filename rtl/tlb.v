module tlb (

    input clk,
    input rst,

    input [19:0] vpn_in,
    input [7:0]  asid_in,

    output reg hit,
    output reg [19:0] ppn_out,

    output reg r_perm,
    output reg w_perm,
    output reg x_perm,
    output reg user_perm,

    input refill_en,
    input [2:0] refill_index,

    input [19:0] refill_vpn,
    input [19:0] refill_ppn,

    input refill_r,
    input refill_w,
    input refill_x,
    input refill_user,

    input [7:0] refill_asid

);

reg valid [0:7];

reg [19:0] vpn_table [0:7];
reg [19:0] ppn_table [0:7];

reg [7:0] asid_table [0:7];

reg r_table [0:7];
reg w_table [0:7];
reg x_table [0:7];

reg user_table [0:7];

integer i;

always @(*) begin

    hit = 0;

    ppn_out = 0;

    r_perm = 0;
    w_perm = 0;
    x_perm = 0;
    user_perm = 0;

    for(i=0;i<8;i=i+1)
    begin

        if(valid[i] &&
           vpn_table[i] == vpn_in &&
           asid_table[i] == asid_in)
        begin

            hit = 1;

            ppn_out = ppn_table[i];

            r_perm = r_table[i];
            w_perm = w_table[i];
            x_perm = x_table[i];
            user_perm = user_table[i];

        end
    end
end

integer j;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin

        for(j=0;j<8;j=j+1)
            valid[j] <= 0;

    end

    else if(refill_en)
    begin

        valid[refill_index] <= 1;

        vpn_table[refill_index] <= refill_vpn;
        ppn_table[refill_index] <= refill_ppn;

        asid_table[refill_index] <= refill_asid;

        r_table[refill_index] <= refill_r;
        w_table[refill_index] <= refill_w;
        x_table[refill_index] <= refill_x;

        user_table[refill_index] <= refill_user;

    end

end

endmodule