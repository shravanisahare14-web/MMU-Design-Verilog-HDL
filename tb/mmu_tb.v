`timescale 1ns/1ps

module mmu_tb;

reg clk;
reg rst;

reg [31:0] virtual_address;

reg [7:0] asid;

reg read_req;
reg write_req;
reg exec_req;

reg user_mode;

wire [31:0] physical_address;

wire tlb_hit;
wire page_fault;
wire access_fault;

mmu_top DUT (

    .clk(clk),
    .rst(rst),

    .virtual_address(virtual_address),

    .asid(asid),

    .read_req(read_req),
    .write_req(write_req),
    .exec_req(exec_req),

    .user_mode(user_mode),

    .physical_address(physical_address),

    .tlb_hit(tlb_hit),
    .page_fault(page_fault),
    .access_fault(access_fault)

);

// Clock

always #5 clk = ~clk;

initial
begin

    clk = 0;
    rst = 1;

    virtual_address = 0;
    asid = 8'h01;

    read_req = 0;
    write_req = 0;
    exec_req = 0;

    user_mode = 1;

    #20;

    rst = 0;

    //-------------------------------------------------
    // Test 1
    // Translation Request
    //-------------------------------------------------

    virtual_address = 32'h00001005;

    read_req = 1;

    #20;

    read_req = 0;

    //-------------------------------------------------
    // Test 2
    // Write Request
    //-------------------------------------------------

    virtual_address = 32'h00002010;

    write_req = 1;

    #20;

    write_req = 0;

    //-------------------------------------------------
    // Test 3
    // Execute Request
    //-------------------------------------------------

    virtual_address = 32'h00003020;

    exec_req = 1;

    #20;

    exec_req = 0;

    //-------------------------------------------------
    // Test 4
    // User Mode Access
    //-------------------------------------------------

    user_mode = 1;

    virtual_address = 32'h00003050;

    read_req = 1;

    #20;

    read_req = 0;

    //-------------------------------------------------
    // Test 5
    // Invalid Page
    //-------------------------------------------------

    virtual_address = 32'h00F00000;

    read_req = 1;

    #20;

    read_req = 0;

    //-------------------------------------------------
    // Finish
    //-------------------------------------------------

    #100;

    $finish;

end

endmodule