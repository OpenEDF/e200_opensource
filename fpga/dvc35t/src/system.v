`timescale 1ns/1ps

module system
(
  input wire CLK50MHZ, //GCLK-W19
  input wire fpga_rst, //FPGA_RESET-T6
  input wire mcu_rst,  //MCU_RESET-P20

  // Dedicated QSPI interface
  output wire qspi_cs,
  output wire qspi_sck,
  inout wire [3:0] qspi_dq,

  //gpio
  inout wire [31:0] gpio,//GPIO00~GPIO031

  // JD (used for JTAG connection)
  inout wire mcu_TDO,//MCU_TDO-N17
  inout wire mcu_TCK,//MCU_TCK-P15
  inout wire mcu_TDI,//MCU_TDI-T18
  inout wire mcu_TMS,//MCU_TMS-P17

  //pmu_wakeup
  inout wire pmu_paden,  //PMU_VDDPADEN-U15
  inout wire pmu_padrst,  //PMU_VADDPARST_V15
  inout wire mcu_wakeup,  //MCU_WAKE-N15

  output wire clk_16m,
  output wire clk_32768hz

);

  wire clk_out1;
  wire mmcm_locked;
  wire reset_periph;
  wire ck_rst;

  // All wires connected to the chip top
  wire dut_clock;
  wire dut_reset;
  wire dut_io_pads_jtag_TCK_i_ival;
  wire dut_io_pads_jtag_TMS_i_ival;
  wire dut_io_pads_jtag_TMS_o_oval;
  wire dut_io_pads_jtag_TMS_o_oe;
  wire dut_io_pads_jtag_TMS_o_ie;
  wire dut_io_pads_jtag_TMS_o_pue;
  wire dut_io_pads_jtag_TMS_o_ds;
  wire dut_io_pads_jtag_TDI_i_ival;
  wire dut_io_pads_jtag_TDO_o_oval;
  wire dut_io_pads_jtag_TDO_o_oe;
  wire dut_io_pads_gpio_0_i_ival;
  wire dut_io_pads_gpio_0_o_oval;
  wire dut_io_pads_gpio_0_o_oe;
  wire dut_io_pads_gpio_0_o_ie;
  wire dut_io_pads_gpio_0_o_pue;
  wire dut_io_pads_gpio_0_o_ds;
  wire dut_io_pads_gpio_1_i_ival;
  wire dut_io_pads_gpio_1_o_oval;
  wire dut_io_pads_gpio_1_o_oe;
  wire dut_io_pads_gpio_1_o_ie;
  wire dut_io_pads_gpio_1_o_pue;
  wire dut_io_pads_gpio_1_o_ds;
  wire dut_io_pads_gpio_2_i_ival;
  wire dut_io_pads_gpio_2_o_oval;
  wire dut_io_pads_gpio_2_o_oe;
  wire dut_io_pads_gpio_2_o_ie;
  wire dut_io_pads_gpio_2_o_pue;
  wire dut_io_pads_gpio_2_o_ds;
  wire dut_io_pads_gpio_3_i_ival;
  wire dut_io_pads_gpio_3_o_oval;
  wire dut_io_pads_gpio_3_o_oe;
  wire dut_io_pads_gpio_3_o_ie;
  wire dut_io_pads_gpio_3_o_pue;
  wire dut_io_pads_gpio_3_o_ds;
  wire dut_io_pads_gpio_4_i_ival;
  wire dut_io_pads_gpio_4_o_oval;
  wire dut_io_pads_gpio_4_o_oe;
  wire dut_io_pads_gpio_4_o_ie;
  wire dut_io_pads_gpio_4_o_pue;
  wire dut_io_pads_gpio_4_o_ds;
  wire dut_io_pads_gpio_5_i_ival;
  wire dut_io_pads_gpio_5_o_oval;
  wire dut_io_pads_gpio_5_o_oe;
  wire dut_io_pads_gpio_5_o_ie;
  wire dut_io_pads_gpio_5_o_pue;
  wire dut_io_pads_gpio_5_o_ds;
  wire dut_io_pads_gpio_6_i_ival;
  wire dut_io_pads_gpio_6_o_oval;
  wire dut_io_pads_gpio_6_o_oe;
  wire dut_io_pads_gpio_6_o_ie;
  wire dut_io_pads_gpio_6_o_pue;
  wire dut_io_pads_gpio_6_o_ds;
  wire dut_io_pads_gpio_7_i_ival;
  wire dut_io_pads_gpio_7_o_oval;
  wire dut_io_pads_gpio_7_o_oe;
  wire dut_io_pads_gpio_7_o_ie;
  wire dut_io_pads_gpio_7_o_pue;
  wire dut_io_pads_gpio_7_o_ds;
  wire dut_io_pads_gpio_8_i_ival;
  wire dut_io_pads_gpio_8_o_oval;
  wire dut_io_pads_gpio_8_o_oe;
  wire dut_io_pads_gpio_8_o_ie;
  wire dut_io_pads_gpio_8_o_pue;
  wire dut_io_pads_gpio_8_o_ds;
  wire dut_io_pads_gpio_9_i_ival;
  wire dut_io_pads_gpio_9_o_oval;
  wire dut_io_pads_gpio_9_o_oe;
  wire dut_io_pads_gpio_9_o_ie;
  wire dut_io_pads_gpio_9_o_pue;
  wire dut_io_pads_gpio_9_o_ds;
  wire dut_io_pads_gpio_10_i_ival;
  wire dut_io_pads_gpio_10_o_oval;
  wire dut_io_pads_gpio_10_o_oe;
  wire dut_io_pads_gpio_10_o_ie;
  wire dut_io_pads_gpio_10_o_pue;
  wire dut_io_pads_gpio_10_o_ds;
  wire dut_io_pads_gpio_11_i_ival;
  wire dut_io_pads_gpio_11_o_oval;
  wire dut_io_pads_gpio_11_o_oe;
  wire dut_io_pads_gpio_11_o_ie;
  wire dut_io_pads_gpio_11_o_pue;
  wire dut_io_pads_gpio_11_o_ds;
  wire dut_io_pads_gpio_12_i_ival;
  wire dut_io_pads_gpio_12_o_oval;
  wire dut_io_pads_gpio_12_o_oe;
  wire dut_io_pads_gpio_12_o_ie;
  wire dut_io_pads_gpio_12_o_pue;
  wire dut_io_pads_gpio_12_o_ds;
  wire dut_io_pads_gpio_13_i_ival;
  wire dut_io_pads_gpio_13_o_oval;
  wire dut_io_pads_gpio_13_o_oe;
  wire dut_io_pads_gpio_13_o_ie;
  wire dut_io_pads_gpio_13_o_pue;
  wire dut_io_pads_gpio_13_o_ds;
  wire dut_io_pads_gpio_14_i_ival;
  wire dut_io_pads_gpio_14_o_oval;
  wire dut_io_pads_gpio_14_o_oe;
  wire dut_io_pads_gpio_14_o_ie;
  wire dut_io_pads_gpio_14_o_pue;
  wire dut_io_pads_gpio_14_o_ds;
  wire dut_io_pads_gpio_15_i_ival;
  wire dut_io_pads_gpio_15_o_oval;
  wire dut_io_pads_gpio_15_o_oe;
  wire dut_io_pads_gpio_15_o_ie;
  wire dut_io_pads_gpio_15_o_pue;
  wire dut_io_pads_gpio_15_o_ds;
  wire dut_io_pads_gpio_16_i_ival;
  wire dut_io_pads_gpio_16_o_oval;
  wire dut_io_pads_gpio_16_o_oe;
  wire dut_io_pads_gpio_16_o_ie;
  wire dut_io_pads_gpio_16_o_pue;
  wire dut_io_pads_gpio_16_o_ds;
  wire dut_io_pads_gpio_17_i_ival;
  wire dut_io_pads_gpio_17_o_oval;
  wire dut_io_pads_gpio_17_o_oe;
  wire dut_io_pads_gpio_17_o_ie;
  wire dut_io_pads_gpio_17_o_pue;
  wire dut_io_pads_gpio_17_o_ds;
  wire dut_io_pads_gpio_18_i_ival;
  wire dut_io_pads_gpio_18_o_oval;
  wire dut_io_pads_gpio_18_o_oe;
  wire dut_io_pads_gpio_18_o_ie;
  wire dut_io_pads_gpio_18_o_pue;
  wire dut_io_pads_gpio_18_o_ds;
  wire dut_io_pads_gpio_19_i_ival;
  wire dut_io_pads_gpio_19_o_oval;
  wire dut_io_pads_gpio_19_o_oe;
  wire dut_io_pads_gpio_19_o_ie;
  wire dut_io_pads_gpio_19_o_pue;
  wire dut_io_pads_gpio_19_o_ds;
  wire dut_io_pads_gpio_20_i_ival;
  wire dut_io_pads_gpio_20_o_oval;
  wire dut_io_pads_gpio_20_o_oe;
  wire dut_io_pads_gpio_20_o_ie;
  wire dut_io_pads_gpio_20_o_pue;
  wire dut_io_pads_gpio_20_o_ds;
  wire dut_io_pads_gpio_21_i_ival;
  wire dut_io_pads_gpio_21_o_oval;
  wire dut_io_pads_gpio_21_o_oe;
  wire dut_io_pads_gpio_21_o_ie;
  wire dut_io_pads_gpio_21_o_pue;
  wire dut_io_pads_gpio_21_o_ds;
  wire dut_io_pads_gpio_22_i_ival;
  wire dut_io_pads_gpio_22_o_oval;
  wire dut_io_pads_gpio_22_o_oe;
  wire dut_io_pads_gpio_22_o_ie;
  wire dut_io_pads_gpio_22_o_pue;
  wire dut_io_pads_gpio_22_o_ds;
  wire dut_io_pads_gpio_23_i_ival;
  wire dut_io_pads_gpio_23_o_oval;
  wire dut_io_pads_gpio_23_o_oe;
  wire dut_io_pads_gpio_23_o_ie;
  wire dut_io_pads_gpio_23_o_pue;
  wire dut_io_pads_gpio_23_o_ds;
  wire dut_io_pads_gpio_24_i_ival;
  wire dut_io_pads_gpio_24_o_oval;
  wire dut_io_pads_gpio_24_o_oe;
  wire dut_io_pads_gpio_24_o_ie;
  wire dut_io_pads_gpio_24_o_pue;
  wire dut_io_pads_gpio_24_o_ds;
  wire dut_io_pads_gpio_25_i_ival;
  wire dut_io_pads_gpio_25_o_oval;
  wire dut_io_pads_gpio_25_o_oe;
  wire dut_io_pads_gpio_25_o_ie;
  wire dut_io_pads_gpio_25_o_pue;
  wire dut_io_pads_gpio_25_o_ds;
  wire dut_io_pads_gpio_26_i_ival;
  wire dut_io_pads_gpio_26_o_oval;
  wire dut_io_pads_gpio_26_o_oe;
  wire dut_io_pads_gpio_26_o_ie;
  wire dut_io_pads_gpio_26_o_pue;
  wire dut_io_pads_gpio_26_o_ds;
  wire dut_io_pads_gpio_27_i_ival;
  wire dut_io_pads_gpio_27_o_oval;
  wire dut_io_pads_gpio_27_o_oe;
  wire dut_io_pads_gpio_27_o_ie;
  wire dut_io_pads_gpio_27_o_pue;
  wire dut_io_pads_gpio_27_o_ds;
  wire dut_io_pads_gpio_28_i_ival;
  wire dut_io_pads_gpio_28_o_oval;
  wire dut_io_pads_gpio_28_o_oe;
  wire dut_io_pads_gpio_28_o_ie;
  wire dut_io_pads_gpio_28_o_pue;
  wire dut_io_pads_gpio_28_o_ds;
  wire dut_io_pads_gpio_29_i_ival;
  wire dut_io_pads_gpio_29_o_oval;
  wire dut_io_pads_gpio_29_o_oe;
  wire dut_io_pads_gpio_29_o_ie;
  wire dut_io_pads_gpio_29_o_pue;
  wire dut_io_pads_gpio_29_o_ds;
  wire dut_io_pads_gpio_30_i_ival;
  wire dut_io_pads_gpio_30_o_oval;
  wire dut_io_pads_gpio_30_o_oe;
  wire dut_io_pads_gpio_30_o_ie;
  wire dut_io_pads_gpio_30_o_pue;
  wire dut_io_pads_gpio_30_o_ds;
  wire dut_io_pads_gpio_31_i_ival;
  wire dut_io_pads_gpio_31_o_oval;
  wire dut_io_pads_gpio_31_o_oe;
  wire dut_io_pads_gpio_31_o_ie;
  wire dut_io_pads_gpio_31_o_pue;
  wire dut_io_pads_gpio_31_o_ds;
  wire dut_io_pads_qspi_sck_o_oval;
  wire dut_io_pads_qspi_dq_0_i_ival;
  wire dut_io_pads_qspi_dq_0_o_oval;
  wire dut_io_pads_qspi_dq_0_o_oe;
  wire dut_io_pads_qspi_dq_0_o_ie;
  wire dut_io_pads_qspi_dq_0_o_pue;
  wire dut_io_pads_qspi_dq_0_o_ds;
  wire dut_io_pads_qspi_dq_1_i_ival;
  wire dut_io_pads_qspi_dq_1_o_oval;
  wire dut_io_pads_qspi_dq_1_o_oe;
  wire dut_io_pads_qspi_dq_1_o_ie;
  wire dut_io_pads_qspi_dq_1_o_pue;
  wire dut_io_pads_qspi_dq_1_o_ds;
  wire dut_io_pads_qspi_dq_2_i_ival;
  wire dut_io_pads_qspi_dq_2_o_oval;
  wire dut_io_pads_qspi_dq_2_o_oe;
  wire dut_io_pads_qspi_dq_2_o_ie;
  wire dut_io_pads_qspi_dq_2_o_pue;
  wire dut_io_pads_qspi_dq_2_o_ds;
  wire dut_io_pads_qspi_dq_3_i_ival;
  wire dut_io_pads_qspi_dq_3_o_oval;
  wire dut_io_pads_qspi_dq_3_o_oe;
  wire dut_io_pads_qspi_dq_3_o_ie;
  wire dut_io_pads_qspi_dq_3_o_pue;
  wire dut_io_pads_qspi_dq_3_o_ds;
  wire dut_io_pads_qspi_cs_0_o_oval;
  wire dut_io_pads_aon_erst_n_i_ival;
  wire dut_io_pads_aon_pmu_dwakeup_n_i_ival;
  wire dut_io_pads_aon_pmu_vddpaden_o_oval;
  wire dut_io_pads_aon_pmu_padrst_o_oval ;
  wire dut_io_pads_bootrom_n_i_ival;
  wire dut_io_pads_dbgmode0_n_i_ival;
  wire dut_io_pads_dbgmode1_n_i_ival;
  wire dut_io_pads_dbgmode2_n_i_ival;

  //=================================================
  // Clock & Reset
  wire clk_8388;
  wire clk_16M;

  mmcm ip_mmcm
  (
    .resetn(ck_rst),
    .clk_in1(CLK50MHZ),
    .clk_out1(clk_8388), // 8.388 MHz = 32.768 KHz * 256

    .clk_out2(clk_16M),  // 16 MHz, this clock we set to 16MHz
    .locked(mmcm_locked)
  );

  wire slowclk;
  clkdivider slowclkgen 
  (
    .clk(clk_8388),
    .reset(~mmcm_locked),
    .clk_out(slowclk)   // 32.768KHz
  );

  assign clk_16m = clk_16M;
  assign clk_32768hz = slowclk;

  assign ck_rst = fpga_rst & mcu_rst;

  reset_sys ip_reset_sys
  (
    .slowest_sync_clk(clk_16M),
    .ext_reset_in(ck_rst), // Active-low
    .aux_reset_in(1'b1),
    .mb_debug_sys_rst(1'b0),
    .dcm_locked(mmcm_locked),
    .mb_reset(),
    .bus_struct_reset(),
    .peripheral_reset(reset_periph),
    .interconnect_aresetn(),
    .peripheral_aresetn()
  );

  //=================================================
  // SPI Interface

  wire [3:0] qspi_ui_dq_o, qspi_ui_dq_oe;
  wire [3:0] qspi_ui_dq_i;

  PULLUP qspi_pullup[3:0]
  (
    .O(qspi_dq)
  );

  IOBUF qspi_iobuf[3:0]
  (
    .IO(qspi_dq),
    .O(qspi_ui_dq_i),
    .I(qspi_ui_dq_o),
    .T(~qspi_ui_dq_oe)
  );

  //=================================================
  // IOBUF instantiation for GPIOs

  wire iobuf_gpio_0_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_0
  (
    .O(iobuf_gpio_0_o),
    .IO(gpio[0]),
    .I(dut_io_pads_gpio_0_o_oval),
    .T(~dut_io_pads_gpio_0_o_oe)
  );
  assign dut_io_pads_gpio_0_i_ival = iobuf_gpio_0_o & dut_io_pads_gpio_0_o_ie;

  wire iobuf_gpio_1_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_1
  (
    .O(iobuf_gpio_1_o),
    .IO(gpio[1]),
    .I(dut_io_pads_gpio_1_o_oval),
    .T(~dut_io_pads_gpio_1_o_oe)
  );
  assign dut_io_pads_gpio_1_i_ival = iobuf_gpio_1_o & dut_io_pads_gpio_1_o_ie;

  wire iobuf_gpio_2_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_2
  (
    .O(iobuf_gpio_2_o),
    .IO(gpio[2]),
    .I(dut_io_pads_gpio_2_o_oval),
    .T(~dut_io_pads_gpio_2_o_oe)
  );
  assign dut_io_pads_gpio_2_i_ival = iobuf_gpio_2_o & dut_io_pads_gpio_2_o_ie;

  wire iobuf_gpio_3_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_3
  (
    .O(iobuf_gpio_3_o),
    .IO(gpio[3]),
    .I(dut_io_pads_gpio_3_o_oval),
    .T(~dut_io_pads_gpio_3_o_oe)
  );
  assign dut_io_pads_gpio_3_i_ival = iobuf_gpio_3_o & dut_io_pads_gpio_3_o_ie;

  wire iobuf_gpio_4_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_4
  (
    .O(iobuf_gpio_4_o),
    .IO(gpio[4]),
    .I(dut_io_pads_gpio_4_o_oval),
    .T(~dut_io_pads_gpio_4_o_oe)
  );
  assign dut_io_pads_gpio_4_i_ival = iobuf_gpio_4_o & dut_io_pads_gpio_4_o_ie;

  wire iobuf_gpio_5_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_5
  (
    .O(iobuf_gpio_5_o),
    .IO(gpio[5]),
    .I(dut_io_pads_gpio_5_o_oval),
    .T(~dut_io_pads_gpio_5_o_oe)
  );
  assign dut_io_pads_gpio_5_i_ival = iobuf_gpio_5_o & dut_io_pads_gpio_5_o_ie;

  wire iobuf_gpio_6_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_6
  (
    .O(iobuf_gpio_6_o),
    .IO(gpio[6]),
    .I(dut_io_pads_gpio_6_o_oval),
    .T(~dut_io_pads_gpio_6_o_oe)
  );
  assign dut_io_pads_gpio_6_i_ival = iobuf_gpio_6_o & dut_io_pads_gpio_6_o_ie;

  wire iobuf_gpio_7_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_7
  (
    .O(iobuf_gpio_7_o),
    .IO(gpio[7]),
    .I(dut_io_pads_gpio_7_o_oval),
    .T(~dut_io_pads_gpio_7_o_oe)
  );
  assign dut_io_pads_gpio_7_i_ival = iobuf_gpio_7_o & dut_io_pads_gpio_7_o_ie;

  wire iobuf_gpio_8_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_8
  (
    .O(iobuf_gpio_8_o),
    .IO(gpio[8]),
    .I(dut_io_pads_gpio_8_o_oval),
    .T(~dut_io_pads_gpio_8_o_oe)
  );
  assign dut_io_pads_gpio_8_i_ival = iobuf_gpio_8_o & dut_io_pads_gpio_8_o_ie;


  wire iobuf_gpio_9_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_9
  (
    .O(iobuf_gpio_9_o),
    .IO(gpio[9]),
    .I(dut_io_pads_gpio_9_o_oval),
    .T(~dut_io_pads_gpio_9_o_oe)
  );
  assign dut_io_pads_gpio_9_i_ival = iobuf_gpio_9_o & dut_io_pads_gpio_9_o_ie;

  wire iobuf_gpio_10_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_10
  (
    .O(iobuf_gpio_10_o),
    .IO(gpio[10]),
    .I(dut_io_pads_gpio_10_o_oval),
    .T(~dut_io_pads_gpio_10_o_oe)
  );
  assign dut_io_pads_gpio_10_i_ival = iobuf_gpio_10_o & dut_io_pads_gpio_10_o_ie;

  wire iobuf_gpio_11_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_11
  (
    .O(iobuf_gpio_11_o),
    .IO(gpio[11]),
    .I(dut_io_pads_gpio_11_o_oval),
    .T(~dut_io_pads_gpio_11_o_oe)
  );
  assign dut_io_pads_gpio_11_i_ival = iobuf_gpio_11_o & dut_io_pads_gpio_11_o_ie;

  wire iobuf_gpio_12_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_12
  (
    .O(iobuf_gpio_12_o),
    .IO(gpio[12]),
    .I(dut_io_pads_gpio_12_o_oval),
    .T(~dut_io_pads_gpio_12_o_oe)
  );
  assign dut_io_pads_gpio_12_i_ival = iobuf_gpio_12_o & dut_io_pads_gpio_12_o_ie;

  wire iobuf_gpio_13_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_13
  (
    .O(iobuf_gpio_13_o),
    .IO(gpio[13]),
    .I(dut_io_pads_gpio_13_o_oval),
    .T(~dut_io_pads_gpio_13_o_oe)
  );
  assign dut_io_pads_gpio_13_i_ival = iobuf_gpio_13_o & dut_io_pads_gpio_13_o_ie;

  wire iobuf_gpio_14_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_14
  (
    .O(iobuf_gpio_14_o),
    .IO(gpio[14]),
    .I(dut_io_pads_gpio_14_o_oval),
    .T(~dut_io_pads_gpio_14_o_oe)
  );
  assign dut_io_pads_gpio_14_i_ival = iobuf_gpio_14_o & dut_io_pads_gpio_14_o_ie;

  wire iobuf_gpio_15_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_15
  (
    .O(iobuf_gpio_15_o),
    .IO(gpio[15]),
    .I(dut_io_pads_gpio_15_o_oval),
    .T(~dut_io_pads_gpio_15_o_oe)
  );
  assign dut_io_pads_gpio_15_i_ival = iobuf_gpio_15_o & dut_io_pads_gpio_15_o_ie;

  wire iobuf_gpio_16_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_16
  (
    .O(iobuf_gpio_16_o),
    .IO(gpio[16]),
    .I(dut_io_pads_gpio_16_o_oval),
    .T(~dut_io_pads_gpio_16_o_oe)
  );
  assign dut_io_pads_gpio_16_i_ival = (iobuf_gpio_16_o & dut_io_pads_gpio_16_o_ie);


  wire iobuf_gpio_17_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_17
  (
    .O(iobuf_gpio_17_o),
    .IO(gpio[17]),
    .I(dut_io_pads_gpio_17_o_oval),
    .T(~dut_io_pads_gpio_17_o_oe)
  );
  assign dut_io_pads_gpio_17_i_ival = iobuf_gpio_17_o & dut_io_pads_gpio_17_o_ie;

  wire iobuf_gpio_18_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_18
  (
    .O(iobuf_gpio_18_o),
    .IO(gpio[18]),
    .I(dut_io_pads_gpio_18_o_oval),
    .T(~dut_io_pads_gpio_18_o_oe)
  );
  assign dut_io_pads_gpio_18_i_ival = iobuf_gpio_18_o & dut_io_pads_gpio_18_o_ie;

  wire iobuf_gpio_19_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_19
  (
    .O(iobuf_gpio_19_o),
    .IO(gpio[19]),
    .I(dut_io_pads_gpio_19_o_oval),
    .T(~dut_io_pads_gpio_19_o_oe)
  );
  assign dut_io_pads_gpio_19_i_ival = iobuf_gpio_19_o & dut_io_pads_gpio_19_o_ie;

  wire iobuf_gpio_20_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_20
  (
    .O(iobuf_gpio_20_o),
    .IO(gpio[20]),
    .I(dut_io_pads_gpio_20_o_oval),
    .T(~dut_io_pads_gpio_20_o_oe)
  );
  assign dut_io_pads_gpio_20_i_ival = iobuf_gpio_20_o & dut_io_pads_gpio_20_o_ie;

  wire iobuf_gpio_21_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_21
  (
    .O(iobuf_gpio_21_o),
    .IO(gpio[21]),
    .I(dut_io_pads_gpio_21_o_oval),
    .T(~dut_io_pads_gpio_21_o_oe)
  );
  assign dut_io_pads_gpio_21_i_ival = iobuf_gpio_21_o & dut_io_pads_gpio_21_o_ie;

  wire iobuf_gpio_22_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_22
  (
    .O(iobuf_gpio_22_o),
    .IO(gpio[22]),
    .I(dut_io_pads_gpio_22_o_oval),
    .T(~dut_io_pads_gpio_22_o_oe)
  );
  assign dut_io_pads_gpio_22_i_ival = iobuf_gpio_22_o & dut_io_pads_gpio_22_o_ie;

  wire iobuf_gpio_23_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_23
  (
    .O(iobuf_gpio_23_o),
    .IO(gpio[23]),
    .I(dut_io_pads_gpio_23_o_oval),
    .T(~dut_io_pads_gpio_23_o_oe)
  );
  assign dut_io_pads_gpio_23_i_ival = iobuf_gpio_23_o & dut_io_pads_gpio_23_o_ie;

  wire iobuf_gpio_24_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_24
  (
    .O(iobuf_gpio_24_o),
    .IO(gpio[24]),
    .I(dut_io_pads_gpio_24_o_oval),
    .T(~dut_io_pads_gpio_24_o_oe)
  );
  assign dut_io_pads_gpio_24_i_ival = iobuf_gpio_24_o & dut_io_pads_gpio_24_o_ie;

  wire iobuf_gpio_25_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_25
  (
    .O(iobuf_gpio_25_o),
    .IO(gpio[25]),
    .I(dut_io_pads_gpio_25_o_oval),
    .T(~dut_io_pads_gpio_25_o_oe)
  );
  assign dut_io_pads_gpio_25_i_ival = iobuf_gpio_25_o & dut_io_pads_gpio_25_o_ie;

  wire iobuf_gpio_26_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_26
  (
    .O(iobuf_gpio_26_o),
    .IO(gpio[26]),
    .I(dut_io_pads_gpio_26_o_oval),
    .T(~dut_io_pads_gpio_26_o_oe)
  );
  assign dut_io_pads_gpio_26_i_ival = iobuf_gpio_26_o & dut_io_pads_gpio_26_o_ie;

  wire iobuf_gpio_27_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_27
  (
    .O(iobuf_gpio_27_o),
    .IO(gpio[27]),
    .I(dut_io_pads_gpio_27_o_oval),
    .T(~dut_io_pads_gpio_27_o_oe)
  );
  assign dut_io_pads_gpio_27_i_ival = iobuf_gpio_27_o & dut_io_pads_gpio_27_o_ie;

  wire iobuf_gpio_28_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_28
  (
    .O(iobuf_gpio_28_o),
    .IO(gpio[28]),
    .I(dut_io_pads_gpio_28_o_oval),
    .T(~dut_io_pads_gpio_28_o_oe)
  );
  assign dut_io_pads_gpio_28_i_ival = iobuf_gpio_28_o & dut_io_pads_gpio_28_o_ie;

  wire iobuf_gpio_29_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_29
  (
    .O(iobuf_gpio_29_o),
    .IO(gpio[29]),
    .I(dut_io_pads_gpio_29_o_oval),
    .T(~dut_io_pads_gpio_29_o_oe)
  );
  assign dut_io_pads_gpio_29_i_ival = iobuf_gpio_29_o & dut_io_pads_gpio_29_o_ie;

  wire iobuf_gpio_30_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_30
  (
    .O(iobuf_gpio_30_o),
    .IO(gpio[30]),
    .I(dut_io_pads_gpio_30_o_oval),
    .T(~dut_io_pads_gpio_30_o_oe)
  );
  assign dut_io_pads_gpio_30_i_ival = iobuf_gpio_30_o & dut_io_pads_gpio_30_o_ie;

  wire iobuf_gpio_31_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_gpio_31
  (
    .O(iobuf_gpio_31_o),
    .IO(gpio[31]),
    .I(dut_io_pads_gpio_31_o_oval),
    .T(~dut_io_pads_gpio_31_o_oe)
  );
  assign dut_io_pads_gpio_31_i_ival = iobuf_gpio_31_o & dut_io_pads_gpio_31_o_ie;

  //=================================================
  // JTAG IOBUFs

  wire iobuf_jtag_TCK_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TCK
  (
    .O(iobuf_jtag_TCK_o),
    .IO(mcu_TCK),
    .I(1'b0),
    .T(1'b1)
  );
  assign dut_io_pads_jtag_TCK_i_ival = iobuf_jtag_TCK_o ;
  PULLUP pullup_TCK (.O(mcu_TCK));

  wire iobuf_jtag_TMS_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TMS
  (
    .O(iobuf_jtag_TMS_o),
    .IO(mcu_TMS),
    .I(1'b0),
    .T(1'b1)
  );
  assign dut_io_pads_jtag_TMS_i_ival = iobuf_jtag_TMS_o;
  PULLUP pullup_TMS (.O(mcu_TMS));

  wire iobuf_jtag_TDI_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TDI
  (
    .O(iobuf_jtag_TDI_o),
    .IO(mcu_TDI),
    .I(1'b0),
    .T(1'b1)
  );
  assign dut_io_pads_jtag_TDI_i_ival = iobuf_jtag_TDI_o;
  PULLUP pullup_TDI (.O(mcu_TDI));

  wire iobuf_jtag_TDO_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_jtag_TDO
  (
    .O(iobuf_jtag_TDO_o),
    .IO(mcu_TDO),
    .I(dut_io_pads_jtag_TDO_o_oval),
    .T(~dut_io_pads_jtag_TDO_o_oe)
  );

  //wire iobuf_jtag_TRST_n_o;
  //IOBUF
  //#(
  //  .DRIVE(12),
  //  .IBUF_LOW_PWR("TRUE"),
  //  .IOSTANDARD("DEFAULT"),
  //  .SLEW("SLOW")
  //)

  //=================================================
  // Assignment of IOBUF "IO" pins to package pins

  // Pins IO0-IO13
  // Shield header row 0: PD0-PD7

  // Use the LEDs for some more useful debugging things.
  assign pmu_paden  = dut_io_pads_aon_pmu_vddpaden_o_oval;
  assign pmu_padrst = dut_io_pads_aon_pmu_padrst_o_oval;

  // model select
  assign dut_io_pads_bootrom_n_i_ival  = 1'b1;
  assign dut_io_pads_dbgmode0_n_i_ival = 1'b1;
  assign dut_io_pads_dbgmode1_n_i_ival = 1'b1;
  assign dut_io_pads_dbgmode2_n_i_ival = 1'b1;

  e200_soc_top dut
  (
    .hfextclk(clk_16M),
    .hfxoscen(),

    .lfextclk(slowclk),
    .lfxoscen(),

       // Note: this is the real SoC top AON domain slow clock
    .io_pads_jtag_TCK_i_ival(dut_io_pads_jtag_TCK_i_ival),
    .io_pads_jtag_TMS_i_ival(dut_io_pads_jtag_TMS_i_ival),
    .io_pads_jtag_TDI_i_ival(dut_io_pads_jtag_TDI_i_ival),
    .io_pads_jtag_TDO_o_oval(dut_io_pads_jtag_TDO_o_oval),
    .io_pads_jtag_TDO_o_oe(dut_io_pads_jtag_TDO_o_oe),
    .io_pads_gpio_0_i_ival(dut_io_pads_gpio_0_i_ival),
    .io_pads_gpio_0_o_oval(dut_io_pads_gpio_0_o_oval),
    .io_pads_gpio_0_o_oe(dut_io_pads_gpio_0_o_oe),
    .io_pads_gpio_0_o_ie(dut_io_pads_gpio_0_o_ie),
    .io_pads_gpio_0_o_pue(dut_io_pads_gpio_0_o_pue),
    .io_pads_gpio_0_o_ds(dut_io_pads_gpio_0_o_ds),
    .io_pads_gpio_1_i_ival(dut_io_pads_gpio_1_i_ival),
    .io_pads_gpio_1_o_oval(dut_io_pads_gpio_1_o_oval),
    .io_pads_gpio_1_o_oe(dut_io_pads_gpio_1_o_oe),
    .io_pads_gpio_1_o_ie(dut_io_pads_gpio_1_o_ie),
    .io_pads_gpio_1_o_pue(dut_io_pads_gpio_1_o_pue),
    .io_pads_gpio_1_o_ds(dut_io_pads_gpio_1_o_ds),
    .io_pads_gpio_2_i_ival(dut_io_pads_gpio_2_i_ival),
    .io_pads_gpio_2_o_oval(dut_io_pads_gpio_2_o_oval),
    .io_pads_gpio_2_o_oe(dut_io_pads_gpio_2_o_oe),
    .io_pads_gpio_2_o_ie(dut_io_pads_gpio_2_o_ie),
    .io_pads_gpio_2_o_pue(dut_io_pads_gpio_2_o_pue),
    .io_pads_gpio_2_o_ds(dut_io_pads_gpio_2_o_ds),
    .io_pads_gpio_3_i_ival(dut_io_pads_gpio_3_i_ival),
    .io_pads_gpio_3_o_oval(dut_io_pads_gpio_3_o_oval),
    .io_pads_gpio_3_o_oe(dut_io_pads_gpio_3_o_oe),
    .io_pads_gpio_3_o_ie(dut_io_pads_gpio_3_o_ie),
    .io_pads_gpio_3_o_pue(dut_io_pads_gpio_3_o_pue),
    .io_pads_gpio_3_o_ds(dut_io_pads_gpio_3_o_ds),
    .io_pads_gpio_4_i_ival(dut_io_pads_gpio_4_i_ival),
    .io_pads_gpio_4_o_oval(dut_io_pads_gpio_4_o_oval),
    .io_pads_gpio_4_o_oe(dut_io_pads_gpio_4_o_oe),
    .io_pads_gpio_4_o_ie(dut_io_pads_gpio_4_o_ie),
    .io_pads_gpio_4_o_pue(dut_io_pads_gpio_4_o_pue),
    .io_pads_gpio_4_o_ds(dut_io_pads_gpio_4_o_ds),
    .io_pads_gpio_5_i_ival(dut_io_pads_gpio_5_i_ival),
    .io_pads_gpio_5_o_oval(dut_io_pads_gpio_5_o_oval),
    .io_pads_gpio_5_o_oe(dut_io_pads_gpio_5_o_oe),
    .io_pads_gpio_5_o_ie(dut_io_pads_gpio_5_o_ie),
    .io_pads_gpio_5_o_pue(dut_io_pads_gpio_5_o_pue),
    .io_pads_gpio_5_o_ds(dut_io_pads_gpio_5_o_ds),
    .io_pads_gpio_6_i_ival(dut_io_pads_gpio_6_i_ival),
    .io_pads_gpio_6_o_oval(dut_io_pads_gpio_6_o_oval),
    .io_pads_gpio_6_o_oe(dut_io_pads_gpio_6_o_oe),
    .io_pads_gpio_6_o_ie(dut_io_pads_gpio_6_o_ie),
    .io_pads_gpio_6_o_pue(dut_io_pads_gpio_6_o_pue),
    .io_pads_gpio_6_o_ds(dut_io_pads_gpio_6_o_ds),
    .io_pads_gpio_7_i_ival(dut_io_pads_gpio_7_i_ival),
    .io_pads_gpio_7_o_oval(dut_io_pads_gpio_7_o_oval),
    .io_pads_gpio_7_o_oe(dut_io_pads_gpio_7_o_oe),
    .io_pads_gpio_7_o_ie(dut_io_pads_gpio_7_o_ie),
    .io_pads_gpio_7_o_pue(dut_io_pads_gpio_7_o_pue),
    .io_pads_gpio_7_o_ds(dut_io_pads_gpio_7_o_ds),
    .io_pads_gpio_8_i_ival(dut_io_pads_gpio_8_i_ival),
    .io_pads_gpio_8_o_oval(dut_io_pads_gpio_8_o_oval),
    .io_pads_gpio_8_o_oe(dut_io_pads_gpio_8_o_oe),
    .io_pads_gpio_8_o_ie(dut_io_pads_gpio_8_o_ie),
    .io_pads_gpio_8_o_pue(dut_io_pads_gpio_8_o_pue),
    .io_pads_gpio_8_o_ds(dut_io_pads_gpio_8_o_ds),
    .io_pads_gpio_9_i_ival(dut_io_pads_gpio_9_i_ival),
    .io_pads_gpio_9_o_oval(dut_io_pads_gpio_9_o_oval),
    .io_pads_gpio_9_o_oe(dut_io_pads_gpio_9_o_oe),
    .io_pads_gpio_9_o_ie(dut_io_pads_gpio_9_o_ie),
    .io_pads_gpio_9_o_pue(dut_io_pads_gpio_9_o_pue),
    .io_pads_gpio_9_o_ds(dut_io_pads_gpio_9_o_ds),
    .io_pads_gpio_10_i_ival(dut_io_pads_gpio_10_i_ival),
    .io_pads_gpio_10_o_oval(dut_io_pads_gpio_10_o_oval),
    .io_pads_gpio_10_o_oe(dut_io_pads_gpio_10_o_oe),
    .io_pads_gpio_10_o_ie(dut_io_pads_gpio_10_o_ie),
    .io_pads_gpio_10_o_pue(dut_io_pads_gpio_10_o_pue),
    .io_pads_gpio_10_o_ds(dut_io_pads_gpio_10_o_ds),
    .io_pads_gpio_11_i_ival(dut_io_pads_gpio_11_i_ival),
    .io_pads_gpio_11_o_oval(dut_io_pads_gpio_11_o_oval),
    .io_pads_gpio_11_o_oe(dut_io_pads_gpio_11_o_oe),
    .io_pads_gpio_11_o_ie(dut_io_pads_gpio_11_o_ie),
    .io_pads_gpio_11_o_pue(dut_io_pads_gpio_11_o_pue),
    .io_pads_gpio_11_o_ds(dut_io_pads_gpio_11_o_ds),
    .io_pads_gpio_12_i_ival(dut_io_pads_gpio_12_i_ival),
    .io_pads_gpio_12_o_oval(dut_io_pads_gpio_12_o_oval),
    .io_pads_gpio_12_o_oe(dut_io_pads_gpio_12_o_oe),
    .io_pads_gpio_12_o_ie(dut_io_pads_gpio_12_o_ie),
    .io_pads_gpio_12_o_pue(dut_io_pads_gpio_12_o_pue),
    .io_pads_gpio_12_o_ds(dut_io_pads_gpio_12_o_ds),
    .io_pads_gpio_13_i_ival(dut_io_pads_gpio_13_i_ival),
    .io_pads_gpio_13_o_oval(dut_io_pads_gpio_13_o_oval),
    .io_pads_gpio_13_o_oe(dut_io_pads_gpio_13_o_oe),
    .io_pads_gpio_13_o_ie(dut_io_pads_gpio_13_o_ie),
    .io_pads_gpio_13_o_pue(dut_io_pads_gpio_13_o_pue),
    .io_pads_gpio_13_o_ds(dut_io_pads_gpio_13_o_ds),
    .io_pads_gpio_14_i_ival(dut_io_pads_gpio_14_i_ival),
    .io_pads_gpio_14_o_oval(dut_io_pads_gpio_14_o_oval),
    .io_pads_gpio_14_o_oe(dut_io_pads_gpio_14_o_oe),
    .io_pads_gpio_14_o_ie(dut_io_pads_gpio_14_o_ie),
    .io_pads_gpio_14_o_pue(dut_io_pads_gpio_14_o_pue),
    .io_pads_gpio_14_o_ds(dut_io_pads_gpio_14_o_ds),
    .io_pads_gpio_15_i_ival(dut_io_pads_gpio_15_i_ival),
    .io_pads_gpio_15_o_oval(dut_io_pads_gpio_15_o_oval),
    .io_pads_gpio_15_o_oe(dut_io_pads_gpio_15_o_oe),
    .io_pads_gpio_15_o_ie(dut_io_pads_gpio_15_o_ie),
    .io_pads_gpio_15_o_pue(dut_io_pads_gpio_15_o_pue),
    .io_pads_gpio_15_o_ds(dut_io_pads_gpio_15_o_ds),
    .io_pads_gpio_16_i_ival(dut_io_pads_gpio_16_i_ival),
    .io_pads_gpio_16_o_oval(dut_io_pads_gpio_16_o_oval),
    .io_pads_gpio_16_o_oe(dut_io_pads_gpio_16_o_oe),
    .io_pads_gpio_16_o_ie(dut_io_pads_gpio_16_o_ie),
    .io_pads_gpio_16_o_pue(dut_io_pads_gpio_16_o_pue),
    .io_pads_gpio_16_o_ds(dut_io_pads_gpio_16_o_ds),
    .io_pads_gpio_17_i_ival(dut_io_pads_gpio_17_i_ival),
    .io_pads_gpio_17_o_oval(dut_io_pads_gpio_17_o_oval),
    .io_pads_gpio_17_o_oe(dut_io_pads_gpio_17_o_oe),
    .io_pads_gpio_17_o_ie(dut_io_pads_gpio_17_o_ie),
    .io_pads_gpio_17_o_pue(dut_io_pads_gpio_17_o_pue),
    .io_pads_gpio_17_o_ds(dut_io_pads_gpio_17_o_ds),
    .io_pads_gpio_18_i_ival(dut_io_pads_gpio_18_i_ival),
    .io_pads_gpio_18_o_oval(dut_io_pads_gpio_18_o_oval),
    .io_pads_gpio_18_o_oe(dut_io_pads_gpio_18_o_oe),
    .io_pads_gpio_18_o_ie(dut_io_pads_gpio_18_o_ie),
    .io_pads_gpio_18_o_pue(dut_io_pads_gpio_18_o_pue),
    .io_pads_gpio_18_o_ds(dut_io_pads_gpio_18_o_ds),
    .io_pads_gpio_19_i_ival(dut_io_pads_gpio_19_i_ival),
    .io_pads_gpio_19_o_oval(dut_io_pads_gpio_19_o_oval),
    .io_pads_gpio_19_o_oe(dut_io_pads_gpio_19_o_oe),
    .io_pads_gpio_19_o_ie(dut_io_pads_gpio_19_o_ie),
    .io_pads_gpio_19_o_pue(dut_io_pads_gpio_19_o_pue),
    .io_pads_gpio_19_o_ds(dut_io_pads_gpio_19_o_ds),
    .io_pads_gpio_20_i_ival(dut_io_pads_gpio_20_i_ival),
    .io_pads_gpio_20_o_oval(dut_io_pads_gpio_20_o_oval),
    .io_pads_gpio_20_o_oe(dut_io_pads_gpio_20_o_oe),
    .io_pads_gpio_20_o_ie(dut_io_pads_gpio_20_o_ie),
    .io_pads_gpio_20_o_pue(dut_io_pads_gpio_20_o_pue),
    .io_pads_gpio_20_o_ds(dut_io_pads_gpio_20_o_ds),
    .io_pads_gpio_21_i_ival(dut_io_pads_gpio_21_i_ival),
    .io_pads_gpio_21_o_oval(dut_io_pads_gpio_21_o_oval),
    .io_pads_gpio_21_o_oe(dut_io_pads_gpio_21_o_oe),
    .io_pads_gpio_21_o_ie(dut_io_pads_gpio_21_o_ie),
    .io_pads_gpio_21_o_pue(dut_io_pads_gpio_21_o_pue),
    .io_pads_gpio_21_o_ds(dut_io_pads_gpio_21_o_ds),
    .io_pads_gpio_22_i_ival(dut_io_pads_gpio_22_i_ival),
    .io_pads_gpio_22_o_oval(dut_io_pads_gpio_22_o_oval),
    .io_pads_gpio_22_o_oe(dut_io_pads_gpio_22_o_oe),
    .io_pads_gpio_22_o_ie(dut_io_pads_gpio_22_o_ie),
    .io_pads_gpio_22_o_pue(dut_io_pads_gpio_22_o_pue),
    .io_pads_gpio_22_o_ds(dut_io_pads_gpio_22_o_ds),
    .io_pads_gpio_23_i_ival(dut_io_pads_gpio_23_i_ival),
    .io_pads_gpio_23_o_oval(dut_io_pads_gpio_23_o_oval),
    .io_pads_gpio_23_o_oe(dut_io_pads_gpio_23_o_oe),
    .io_pads_gpio_23_o_ie(dut_io_pads_gpio_23_o_ie),
    .io_pads_gpio_23_o_pue(dut_io_pads_gpio_23_o_pue),
    .io_pads_gpio_23_o_ds(dut_io_pads_gpio_23_o_ds),
    .io_pads_gpio_24_i_ival(dut_io_pads_gpio_24_i_ival),
    .io_pads_gpio_24_o_oval(dut_io_pads_gpio_24_o_oval),
    .io_pads_gpio_24_o_oe(dut_io_pads_gpio_24_o_oe),
    .io_pads_gpio_24_o_ie(dut_io_pads_gpio_24_o_ie),
    .io_pads_gpio_24_o_pue(dut_io_pads_gpio_24_o_pue),
    .io_pads_gpio_24_o_ds(dut_io_pads_gpio_24_o_ds),
    .io_pads_gpio_25_i_ival(dut_io_pads_gpio_25_i_ival),
    .io_pads_gpio_25_o_oval(dut_io_pads_gpio_25_o_oval),
    .io_pads_gpio_25_o_oe(dut_io_pads_gpio_25_o_oe),
    .io_pads_gpio_25_o_ie(dut_io_pads_gpio_25_o_ie),
    .io_pads_gpio_25_o_pue(dut_io_pads_gpio_25_o_pue),
    .io_pads_gpio_25_o_ds(dut_io_pads_gpio_25_o_ds),
    .io_pads_gpio_26_i_ival(dut_io_pads_gpio_26_i_ival),
    .io_pads_gpio_26_o_oval(dut_io_pads_gpio_26_o_oval),
    .io_pads_gpio_26_o_oe(dut_io_pads_gpio_26_o_oe),
    .io_pads_gpio_26_o_ie(dut_io_pads_gpio_26_o_ie),
    .io_pads_gpio_26_o_pue(dut_io_pads_gpio_26_o_pue),
    .io_pads_gpio_26_o_ds(dut_io_pads_gpio_26_o_ds),
    .io_pads_gpio_27_i_ival(dut_io_pads_gpio_27_i_ival),
    .io_pads_gpio_27_o_oval(dut_io_pads_gpio_27_o_oval),
    .io_pads_gpio_27_o_oe(dut_io_pads_gpio_27_o_oe),
    .io_pads_gpio_27_o_ie(dut_io_pads_gpio_27_o_ie),
    .io_pads_gpio_27_o_pue(dut_io_pads_gpio_27_o_pue),
    .io_pads_gpio_27_o_ds(dut_io_pads_gpio_27_o_ds),
    .io_pads_gpio_28_i_ival(dut_io_pads_gpio_28_i_ival),
    .io_pads_gpio_28_o_oval(dut_io_pads_gpio_28_o_oval),
    .io_pads_gpio_28_o_oe(dut_io_pads_gpio_28_o_oe),
    .io_pads_gpio_28_o_ie(dut_io_pads_gpio_28_o_ie),
    .io_pads_gpio_28_o_pue(dut_io_pads_gpio_28_o_pue),
    .io_pads_gpio_28_o_ds(dut_io_pads_gpio_28_o_ds),
    .io_pads_gpio_29_i_ival(dut_io_pads_gpio_29_i_ival),
    .io_pads_gpio_29_o_oval(dut_io_pads_gpio_29_o_oval),
    .io_pads_gpio_29_o_oe(dut_io_pads_gpio_29_o_oe),
    .io_pads_gpio_29_o_ie(dut_io_pads_gpio_29_o_ie),
    .io_pads_gpio_29_o_pue(dut_io_pads_gpio_29_o_pue),
    .io_pads_gpio_29_o_ds(dut_io_pads_gpio_29_o_ds),
    .io_pads_gpio_30_i_ival(dut_io_pads_gpio_30_i_ival),
    .io_pads_gpio_30_o_oval(dut_io_pads_gpio_30_o_oval),
    .io_pads_gpio_30_o_oe(dut_io_pads_gpio_30_o_oe),
    .io_pads_gpio_30_o_ie(dut_io_pads_gpio_30_o_ie),
    .io_pads_gpio_30_o_pue(dut_io_pads_gpio_30_o_pue),
    .io_pads_gpio_30_o_ds(dut_io_pads_gpio_30_o_ds),
    .io_pads_gpio_31_i_ival(dut_io_pads_gpio_31_i_ival),
    .io_pads_gpio_31_o_oval(dut_io_pads_gpio_31_o_oval),
    .io_pads_gpio_31_o_oe(dut_io_pads_gpio_31_o_oe),
    .io_pads_gpio_31_o_ie(dut_io_pads_gpio_31_o_ie),
    .io_pads_gpio_31_o_pue(dut_io_pads_gpio_31_o_pue),
    .io_pads_gpio_31_o_ds(dut_io_pads_gpio_31_o_ds),
    .io_pads_qspi_sck_o_oval(dut_io_pads_qspi_sck_o_oval),
    .io_pads_qspi_dq_0_i_ival(dut_io_pads_qspi_dq_0_i_ival),
    .io_pads_qspi_dq_0_o_oval(dut_io_pads_qspi_dq_0_o_oval),
    .io_pads_qspi_dq_0_o_oe(dut_io_pads_qspi_dq_0_o_oe),
    .io_pads_qspi_dq_0_o_ie(dut_io_pads_qspi_dq_0_o_ie),
    .io_pads_qspi_dq_0_o_pue(dut_io_pads_qspi_dq_0_o_pue),
    .io_pads_qspi_dq_0_o_ds(dut_io_pads_qspi_dq_0_o_ds),
    .io_pads_qspi_dq_1_i_ival(dut_io_pads_qspi_dq_1_i_ival),
    .io_pads_qspi_dq_1_o_oval(dut_io_pads_qspi_dq_1_o_oval),
    .io_pads_qspi_dq_1_o_oe(dut_io_pads_qspi_dq_1_o_oe),
    .io_pads_qspi_dq_1_o_ie(dut_io_pads_qspi_dq_1_o_ie),
    .io_pads_qspi_dq_1_o_pue(dut_io_pads_qspi_dq_1_o_pue),
    .io_pads_qspi_dq_1_o_ds(dut_io_pads_qspi_dq_1_o_ds),
    .io_pads_qspi_dq_2_i_ival(dut_io_pads_qspi_dq_2_i_ival),
    .io_pads_qspi_dq_2_o_oval(dut_io_pads_qspi_dq_2_o_oval),
    .io_pads_qspi_dq_2_o_oe(dut_io_pads_qspi_dq_2_o_oe),
    .io_pads_qspi_dq_2_o_ie(dut_io_pads_qspi_dq_2_o_ie),
    .io_pads_qspi_dq_2_o_pue(dut_io_pads_qspi_dq_2_o_pue),
    .io_pads_qspi_dq_2_o_ds(dut_io_pads_qspi_dq_2_o_ds),
    .io_pads_qspi_dq_3_i_ival(dut_io_pads_qspi_dq_3_i_ival),
    .io_pads_qspi_dq_3_o_oval(dut_io_pads_qspi_dq_3_o_oval),
    .io_pads_qspi_dq_3_o_oe(dut_io_pads_qspi_dq_3_o_oe),
    .io_pads_qspi_dq_3_o_ie(dut_io_pads_qspi_dq_3_o_ie),
    .io_pads_qspi_dq_3_o_pue(dut_io_pads_qspi_dq_3_o_pue),
    .io_pads_qspi_dq_3_o_ds(dut_io_pads_qspi_dq_3_o_ds),
    .io_pads_qspi_cs_0_o_oval(dut_io_pads_qspi_cs_0_o_oval),
       // Note: this is the real SoC top level reset signal
    .io_pads_aon_erst_n_i_ival(ck_rst),
    .io_pads_aon_pmu_dwakeup_n_i_ival(dut_io_pads_aon_pmu_dwakeup_n_i_ival),
    .io_pads_aon_pmu_vddpaden_o_oval(dut_io_pads_aon_pmu_vddpaden_o_oval),

    .io_pads_aon_pmu_padrst_o_oval    (dut_io_pads_aon_pmu_padrst_o_oval ),

    .io_pads_bootrom_n_i_ival        (dut_io_pads_bootrom_n_i_ival),

    .io_pads_dbgmode0_n_i_ival       (dut_io_pads_dbgmode0_n_i_ival),
    .io_pads_dbgmode1_n_i_ival       (dut_io_pads_dbgmode1_n_i_ival),
    .io_pads_dbgmode2_n_i_ival       (dut_io_pads_dbgmode2_n_i_ival)
  );

  // Assign reasonable values to otherwise unconnected inputs to chip top

  wire iobuf_dwakeup_o;
  IOBUF
  #(
    .DRIVE(12),
    .IBUF_LOW_PWR("TRUE"),
    .IOSTANDARD("DEFAULT"),
    .SLEW("SLOW")
  )
  IOBUF_dwakeup_n
  (
    .O(iobuf_dwakeup_o),
    .IO(mcu_wakeup),
    .I(1'b1),
    .T(1'b1)
  );
  assign dut_io_pads_aon_pmu_dwakeup_n_i_ival = (~iobuf_dwakeup_o);

  assign dut_io_pads_aon_pmu_vddpaden_i_ival = 1'b1;

  assign qspi_cs = dut_io_pads_qspi_cs_0_o_oval;
  assign qspi_ui_dq_o = {
    dut_io_pads_qspi_dq_3_o_oval,
    dut_io_pads_qspi_dq_2_o_oval,
    dut_io_pads_qspi_dq_1_o_oval,
    dut_io_pads_qspi_dq_0_o_oval
  };
  assign qspi_ui_dq_oe = {
    dut_io_pads_qspi_dq_3_o_oe,
    dut_io_pads_qspi_dq_2_o_oe,
    dut_io_pads_qspi_dq_1_o_oe,
    dut_io_pads_qspi_dq_0_o_oe
  };
  assign dut_io_pads_qspi_dq_0_i_ival = qspi_ui_dq_i[0];
  assign dut_io_pads_qspi_dq_1_i_ival = qspi_ui_dq_i[1];
  assign dut_io_pads_qspi_dq_2_i_ival = qspi_ui_dq_i[2];
  assign dut_io_pads_qspi_dq_3_i_ival = qspi_ui_dq_i[3];
  assign qspi_sck = dut_io_pads_qspi_sck_o_oval;

endmodule
