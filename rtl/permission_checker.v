module permission_checker (

    input wire read_req,
    input wire write_req,
    input wire exec_req,

    input wire user_mode,

    input wire r_perm,
    input wire w_perm,
    input wire x_perm,

    input wire user_perm,

    output reg access_fault

);

always @(*)
begin

    access_fault = 0;

    if(read_req && !r_perm)
        access_fault = 1;

    else if(write_req && !w_perm)
        access_fault = 1;

    else if(exec_req && !x_perm)
        access_fault = 1;

    else if(user_mode && !user_perm)
        access_fault = 1;

end

endmodule