
module stop_watch_tb;

    // Parameters

    //Ports
    reg Clk;
    reg rst_n;
    reg Clear;
    reg start_stop;
    wire [3:0] hr_h;
    wire [3:0] hr_l;
    wire [3:0] min_h;
    wire [3:0] min_l;
    wire [3:0] sec_h;
    wire [3:0] sec_l;

    stop_watch  stop_watch_inst (
        .Clk(Clk),
        .rst_n(rst_n),
        .Clear(Clear),
        .start_stop(start_stop),
        .hr_h(hr_h),
        .hr_l(hr_l),
        .min_h(min_h),
        .min_l(min_l),
        .sec_h(sec_h),
        .sec_l(sec_l)
    );

    initial begin
        Clk = 1'b0;
        rst_n = 1'b0;
        Clear = 1'b0;
        start_stop = 1'b0;
        # 100 rst_n = 1'b1;
        // 开始
        start_stop = 1'b1;
        # 50 start_stop = 1'b0;
        # 1000000;
        // 暂停
        start_stop = 1'b1;
        # 50 start_stop = 1'b0;
        # 100000;
        // 开始
        start_stop = 1'b1;
        # 50 start_stop = 1'b0;
        # 1000000;
        // 暂停
        // start_stop = 1'b1;
        // # 50 start_stop = 1'b0;
        // # 100000;
        $stop;
    end

    always #50 Clk <= ! Clk ;

endmodule