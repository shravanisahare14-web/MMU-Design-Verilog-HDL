module mmu_top(

    input clk,
    input rst,

    input [31:0] virtual_address,

    input [7:0] asid,

    input read_req,
    input write_req,
    input exec_req,

    input user_mode,

    output [31:0] physical_address,

    output tlb_hit,
    output page_fault,
    output access_fault

);

wire [19:0] vpn;
wire [11:0] offset;

assign vpn = virtual_address[31:12];
assign offset = virtual_address[11:0];

wire [19:0] tlb_ppn;
wire [19:0] ptw_ppn;

wire r_perm;
wire w_perm;
wire x_perm;
wire user_perm;

wire pte_valid;
wire [19:0] pte_ppn;

wire refill_en;
wire [2:0] victim_index;

wire ptw_done;

assign refill_en = ptw_done;

assign physical_address =
    tlb_hit ?
    {tlb_ppn, offset} :
    {ptw_ppn, offset};

lru LRU0(

    .clk(clk),
    .rst(rst),

    .access(refill_en),

    .victim(victim_index)

);

pte_memory MEM0(

    .vpn(vpn),

    .ppn(pte_ppn),

    .valid(pte_valid),

    .r_perm(),
    .w_perm(),
    .x_perm(),

    .user_perm()

);

tlb TLB0(

    .clk(clk),
    .rst(rst),

    .vpn_in(vpn),
    .asid_in(asid),

    .hit(tlb_hit),

    .ppn_out(tlb_ppn),

    .r_perm(r_perm),
    .w_perm(w_perm),
    .x_perm(x_perm),

    .user_perm(user_perm),

    .refill_en(refill_en),

    .refill_index(victim_index),

    .refill_vpn(vpn),

    .refill_ppn(ptw_ppn),

    .refill_r(1'b1),
    .refill_w(1'b1),
    .refill_x(1'b1),

    .refill_user(1'b1),

    .refill_asid(asid)

);

ptw PTW0(

    .clk(clk),
    .rst(rst),

    .start(~tlb_hit),

    .vpn_in(vpn),

    .pte_valid(pte_valid),
    .pte_ppn(pte_ppn),

    .done(ptw_done),

    .fault(page_fault),

    .ppn_out(ptw_ppn),

    .mem_req()

);

permission_checker PERM0(

    .read_req(read_req),
    .write_req(write_req),
    .exec_req(exec_req),

    .user_mode(user_mode),

    .r_perm(r_perm),
    .w_perm(w_perm),
    .x_perm(x_perm),

    .user_perm(user_perm),

    .access_fault(access_fault)

);

endmodule