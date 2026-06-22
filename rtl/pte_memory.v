module pte_memory (

    input wire [19:0] vpn,

    output reg [19:0] ppn,

    output reg valid,

    output reg r_perm,
    output reg w_perm,
    output reg x_perm,

    output reg user_perm

);

always @(*)
begin

    case(vpn)

        20'h001:
        begin
            ppn = 20'h101;

            valid = 1;

            r_perm = 1;
            w_perm = 1;
            x_perm = 0;

            user_perm = 1;
        end

        20'h002:
        begin
            ppn = 20'h102;

            valid = 1;

            r_perm = 1;
            w_perm = 0;
            x_perm = 1;

            user_perm = 1;
        end

        20'h003:
        begin
            ppn = 20'h103;

            valid = 1;

            r_perm = 1;
            w_perm = 1;
            x_perm = 1;

            user_perm = 0;
        end

        default:
        begin
            ppn = 0;

            valid = 0;

            r_perm = 0;
            w_perm = 0;
            x_perm = 0;

            user_perm = 0;
        end

    endcase

end

endmodule