module testbench();

    logic        clk;
    logic        reset;
    logic [31:0] WriteData, DataAdr;
    logic        MemWrite;

    // instantiate device to be tested
    top dut(clk, reset, WriteData, DataAdr, MemWrite);

    // initialize test
    initial begin
        reset <= 1; # 22; reset <= 0;
    end

    initial begin
        $dumpfile("processor.vcd");
        $dumpvars(0, testbench);
    end
    // generate clock to sequence tests
    always begin
        clk <= 1; # 5; clk <= 0; # 5;
    end

    // check results
    always @(negedge clk)
        begin
            if (MemWrite) begin
                // if (DataAdr === 32 & WriteData === 25) begin
                //     $display("Simulation succeeded");
                //     $stop;
                // end else if (DataAdr === 96 & WriteData === 7) begin
                //     $display("Pass checkpoint-1");
                // end else if (DataAdr === 96 & WriteData !== 7) begin
                //     $display("DataAdr: %d", DataAdr);
                //     $display("WriteData: %d", WriteData);
                //     $display("Simulation failed at sw x7");
                //     // $stop;
                // end else if (DataAdr !== 96) begin
                //     $display("DataAdr: %d", DataAdr);
                //     $display("WriteData: %d", WriteData);
                //     $display("Simulation failed");
                //     $stop;
                // end
                if (DataAdr === 32 && WriteData === 1) begin
                    $display("PASS");
                    $finish;
                end else if (DataAdr === 32 && WriteData === 0) begin
                    $display("FAIL");
                    $finish;
                end else begin
                    $display("Unknown MemWrite");
                    $display("DataAdr: %d", DataAdr);
                    $display("WriteData: %d", WriteData);
                    $display("FAIL");
                    $finish;
                end
            end
        end
endmodule
