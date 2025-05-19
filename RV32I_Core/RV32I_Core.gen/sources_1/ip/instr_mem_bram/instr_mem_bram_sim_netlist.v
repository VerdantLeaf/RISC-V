// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Mon May 19 14:24:12 2025
// Host        : OmenK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/kyle3/Documents/VivadoProjects/RISC-V/RV32I_Core/RV32I_Core.gen/sources_1/ip/instr_mem_bram/instr_mem_bram_sim_netlist.v
// Design      : instr_mem_bram
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7s25csga324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "instr_mem_bram,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module instr_mem_bram
   (clka,
    ena,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [9:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;

  wire [9:0]addra;
  wire clka;
  wire [31:0]douta;
  wire ena;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_doutb_UNCONNECTED;
  wire [9:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [9:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "10" *) 
  (* C_ADDRB_WIDTH = "10" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.622 mW" *) 
  (* C_FAMILY = "spartan7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "instr_mem_bram.mem" *) 
  (* C_INIT_FILE_NAME = "instr_mem_bram.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1024" *) 
  (* C_READ_DEPTH_B = "1024" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1024" *) 
  (* C_WRITE_DEPTH_B = "1024" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "spartan7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  instr_mem_bram_blk_mem_gen_v8_4_9 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[31:0]),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[9:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[9:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27424)
`pragma protect data_block
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
QNBkMTW2vg==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
