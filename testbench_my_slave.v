//                              -*- Mode: Verilog -*-
// Filename        : testbench_axi_master_bfm.v
// Description     : Testbench for AXI Master BFM
// Author          : Philip Tracton
// Created On      : Fri Dec  9 20:36:20 2016
// Last Modified By: Philip Tracton
// Last Modified On: Fri Dec  9 20:36:20 2016
// Update Count    : 0
// Status          : Unknown, Use with caution!
`timescale 1 ns / 1 ps
module testbench_my_slave (/*AUTOARG*/) ;

   //
   // Free running clock
   //
   reg aclk;
   initial begin
      aclk <= 0;
      forever #5 aclk<=~aclk;      
   end

   //
   // Reset
   //
   reg aresetn;
   initial begin
      aresetn <= 1;
      #11;
      aresetn <= 0;
      repeat (10) @(posedge aclk);
      aresetn <= 1;            
   end

   /*AUTOREG*/
   reg test_passed;
   
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [31:0]          araddr;                 // From master of axi_master_bfm.v
   wire [3:0]           arcache;                // From master of axi_master_bfm.v
   wire [3:0]           arid;                   // From master of axi_master_bfm.v
   wire [7:0]           arlen;                  // From master of axi_master_bfm.v
   wire [1:0]           arlock;                 // From master of axi_master_bfm.v
   wire [2:0]           arprot;                 // From master of axi_master_bfm.v
   wire                 arready;                // From slave of axi_slave_generic.v
   wire [2:0]           arsize;                 // From master of axi_master_bfm.v
   wire                 arvalid;                // From master of axi_master_bfm.v
   wire [31:0]          awadr;                  // From master of axi_master_bfm.v
   wire [1:0]           awburst;                // From master of axi_master_bfm.v
   wire [3:0]           awcache;                // From master of axi_master_bfm.v
   wire [3:0]           awid;                   // From master of axi_master_bfm.v
   wire [7:0]           awlen;                  // From master of axi_master_bfm.v
   wire [1:0]           awlock;                 // From master of axi_master_bfm.v
   wire [2:0]           awprot;                 // From master of axi_master_bfm.v
   wire                 awready;                // From slave of axi_slave_generic.v
   wire [2:0]           awsize;                 // From master of axi_master_bfm.v
   wire                 awvalid;                // From master of axi_master_bfm.v
   wire [3:0]           bid;                    // From master of axi_master_bfm.v, ...
   wire [1:0]           bresp;                  // From master of axi_master_bfm.v, ...
   wire                 bvalid;                 // From master of axi_master_bfm.v, ...
   wire [31:0]          rdata;                  // From slave of axi_slave_generic.v
   wire [3:0]           rid;                    // From slave of axi_slave_generic.v
   wire                 rlast;                  // From slave of axi_slave_generic.v
   wire                 rready;                 // From master of axi_master_bfm.v
   wire [1:0]           rresp;                  // From slave of axi_slave_generic.v
   wire                 rvalid;                 // From slave of axi_slave_generic.v
   wire                 test_fail;              // From master of axi_master_bfm.v
   wire [3:0]           wid;                    // From master of axi_master_bfm.v
   wire                 wlast;                  // From master of axi_master_bfm.v
   wire [31:0]          wrdata;                 // From master of axi_master_bfm.v
   wire                 wready;                 // From slave of axi_slave_generic.v
   wire [3:0]           wstrb;                  // From master of axi_master_bfm.v
   wire                 wvalid;                 // From master of axi_master_bfm.v
   // End of automatics

   axi_master_bfm master(/*AUTOINST*/
                         // Outputs
                         .awid                  (awid[3:0]),
                         .awadr                 (awadr[31:0]),
                         .awlen                 (awlen[7:0]),
                         .awsize                (awsize[2:0]),
                         .awburst               (awburst[1:0]),
                         .awlock                (awlock[1:0]),
                         .awcache               (awcache[3:0]),
                         .awprot                (awprot[2:0]),
                         .awvalid               (awvalid),
                         .wid                   (wid[3:0]),
                         .wrdata                (wrdata[31:0]),
                         .wstrb                 (wstrb[3:0]),
                         .wlast                 (wlast),
                         .wvalid                (wvalid),
                         .bid                   (bid[3:0]),
                         .bresp                 (bresp[1:0]),
                         .bvalid                (bvalid),
                         .arid                  (arid[3:0]),
                         .araddr                (araddr[31:0]),
                         .arlen                 (arlen[7:0]),
                         .arsize                (arsize[2:0]),
                         .arlock                (arlock[1:0]),
                         .arcache               (arcache[3:0]),
                         .arprot                (arprot[2:0]),
                         .arvalid               (arvalid),
                         .rready                (rready),
                         .test_fail             (test_fail),
                         // Inputs
                         .aclk                  (aclk),
                         .aresetn               (aresetn),
                         .awready               (awready),
                         .wready                (wready),
                         .bready                (bready),
                         .arready               (arready),
                         .rid                   (rid[3:0]),
                         .rdata                 (rdata[31:0]),
                         .rresp                 (rresp[1:0]),
                         .rlast                 (rlast),
                         .rvalid                (rvalid)					 
						 );
   
   my_full_ip_v1_0 slave (/*AUTOINST*/
                            // Outputs
                            .s00_axi_awready            (awready),
                            .s00_axi_wready             (wready),
                            .s00_axi_bid                (bid[3:0]),
                            .s00_axi_bresp              (bresp[1:0]),
                            .s00_axi_bvalid             (bvalid),
                            .s00_axi_arready            (arready),
                            .s00_axi_rid                (rid[3:0]),
                            .s00_axi_rdata              (rdata[31:0]),
                            .s00_axi_rresp              (rresp[1:0]),
                            .s00_axi_rlast              (rlast),
                            .s00_axi_rvalid             (rvalid),
                            // Inputs
                            .s00_axi_aclk               (aclk),
                            .s00_axi_aresetn            (aresetn),
                            .s00_axi_awid               (awid[3:0]),
                            .s00_axi_awaddr              (awadr[31:0]),
                            .s00_axi_awlen              (awlen[7:0]),
                            .s00_axi_awsize             (awsize[2:0]),
                            .s00_axi_awburst            (awburst[1:0]),
                            .s00_axi_awlock             (awlock[1:0]),
                            .s00_axi_awcache            (awcache[3:0]),
                            .s00_axi_awprot             (awprot[2:0]),
                            .s00_axi_awvalid            (awvalid),
                            //.s00_axi_awid                (wid[3:0]),
                            .s00_axi_wdata             (wrdata[31:0]),
                            .s00_axi_wstrb              (wstrb[3:0]),
                            .s00_axi_wlast              (wlast),
                            .s00_axi_wvalid             (wvalid),
                            .s00_axi_bready             (bready),
                            .s00_axi_arid               (arid[3:0]),
                            .s00_axi_araddr             (araddr[31:0]),
                            .s00_axi_arlen              (arlen[7:0]),
                            .s00_axi_arsize             (arsize[2:0]),
                            .s00_axi_arlock             (arlock[1:0]),
                            .s00_axi_arcache            (arcache[3:0]),
                            .s00_axi_arprot             (arprot[2:0]),
                            .s00_axi_arvalid            (arvalid),
                            .s00_axi_rready             (rready),
							 .s00_axi_awqos			( ),
							 .s00_axi_awregion		( ),
							 .s00_axi_awuser		( ),
							 .s00_axi_wuser			( ),
							 .s00_axi_buser			( ),
							 .s00_axi_arburst		( 2'b10 ),//AXI_BURST_TYPE_FIXED 2'b00
							 .s00_axi_arqos			( ),
							 .s00_axi_arregion		( ),
							 .s00_axi_aruser		( ),
							 .s00_axi_ruser			( )	
						 );
   

   test_case test();
   initial begin
      @(posedge test_fail);      
      $display("TEST FAIL @ %d", $time);
      repeat (10) @(posedge aclk);
      $finish;            
   end

   initial begin
      test_passed <= 0;      
      @(posedge test_passed);
      $display("TEST PASSED: @ %d", $time);      
      repeat (10) @(posedge aclk);
      $finish;      
   end
   
endmodule // testbench_axi_master_bfm
