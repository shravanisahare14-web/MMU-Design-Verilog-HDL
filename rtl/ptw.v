module ptw(

    input clk,
    input rst,

    input start,

    input [19:0] vpn_in,

    input pte_valid,
    input [19:0] pte_ppn,

    output reg done,
    output reg fault,

    output reg [19:0] ppn_out,

    output reg mem_req

);

localparam IDLE   = 2'd0;
localparam FETCH  = 2'd1;
localparam UPDATE = 2'd2;
localparam FINISH = 2'd3;

reg [1:0] state;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        state <= IDLE;

        done <= 0;
        fault <= 0;
        mem_req <= 0;

        ppn_out <= 0;
    end

    else
    begin

        case(state)

            IDLE:
            begin

                done <= 0;
                fault <= 0;
                mem_req <= 0;

                if(start)
                begin
                    mem_req <= 1;
                    state <= FETCH;
                end

            end

            FETCH:
            begin

                mem_req <= 0;

                if(pte_valid)
                begin
                    ppn_out <= pte_ppn;
                    state <= UPDATE;
                end
                else
                begin
                    state <= FINISH;
                    fault <= 1;
                end

            end

            UPDATE:
            begin
                state <= FINISH;
            end

            FINISH:
            begin

                done <= 1;
                state <= IDLE;

            end

        endcase

    end

end

endmodule