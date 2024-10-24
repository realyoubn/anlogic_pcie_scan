// Verilog netlist created by Tang Dynasty v5.6.71036
// Sat May 11 10:46:42 2024

`timescale 1ns / 1ps
module fifo_generator_0  // fifo_generator_0.v(14)
  (
  clk,
  di,
  re,
  rst,
  we,
  dout,
  empty_flag,
  full_flag,
  rdusedw,
  wrusedw
  );

  input clk;  // fifo_generator_0.v(24)
  input [7:0] di;  // fifo_generator_0.v(23)
  input re;  // fifo_generator_0.v(25)
  input rst;  // fifo_generator_0.v(22)
  input we;  // fifo_generator_0.v(24)
  output [7:0] dout;  // fifo_generator_0.v(27)
  output empty_flag;  // fifo_generator_0.v(28)
  output full_flag;  // fifo_generator_0.v(29)
  output [13:0] rdusedw;  // fifo_generator_0.v(30)
  output [13:0] wrusedw;  // fifo_generator_0.v(31)

  wire logic_ramfifo_syn_1;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_2;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_3;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_4;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_5;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_6;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_7;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_8;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_9;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_10;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_11;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_12;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_13;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_14;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_15;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_16;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_17;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_18;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_19;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_20;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_21;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_22;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_23;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_24;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_25;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_26;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_27;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_28;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_29;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_30;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_31;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_32;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_33;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_34;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_35;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_36;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_37;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_38;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_39;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_40;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_41;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_42;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_57;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_58;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_59;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_60;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_61;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_62;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_63;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_64;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_65;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_66;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_67;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_68;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_69;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_70;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_71;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_72;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_73;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_74;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_75;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_76;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_77;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_78;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_79;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_80;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_81;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_82;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_83;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_84;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_85;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_86;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_87;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_88;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_89;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_90;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_91;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_92;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_93;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_94;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_95;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_96;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_97;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_99;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_100;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_101;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_102;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_103;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_104;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_105;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_106;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_107;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_108;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_109;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_110;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_111;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_112;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_113;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_114;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_115;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_116;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_117;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_118;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_119;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_120;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_121;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_122;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_123;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_124;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_125;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_126;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_127;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_128;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_129;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_130;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_131;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_132;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_133;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_134;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_135;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_136;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_137;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_138;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_139;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_180;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_182;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_186;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_187;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_188;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_189;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_190;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_191;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_192;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_193;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_194;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_195;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_196;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_197;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_198;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_199;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_200;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_204;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_206;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_228;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_248;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_249;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_250;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_251;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_252;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_253;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_254;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_255;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_256;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_257;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_258;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_259;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_260;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_261;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_282;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_284;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_286;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_288;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_290;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_292;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_294;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_296;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_298;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_300;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_302;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_304;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_306;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_311;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_313;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_315;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_317;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_319;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_321;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_323;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_325;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_327;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_329;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_331;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_333;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_337;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_339;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_341;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_343;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_345;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_347;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_349;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_351;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_353;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_355;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_357;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_359;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_361;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_366;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_368;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_370;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_372;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_374;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_376;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_378;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_380;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_382;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_384;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_386;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_388;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_635;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_636;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_637;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_638;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_639;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_640;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_641;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_642;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_643;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_644;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_645;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_646;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_647;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_648;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_649;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_650;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_651;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_652;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_653;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_654;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_655;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_656;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_657;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_658;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_659;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_660;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_661;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_719;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_720;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_721;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_722;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_723;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_724;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_725;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_726;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_727;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_728;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_729;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_730;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_731;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_732;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_733;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_734;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_735;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_736;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_737;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_738;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_739;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_740;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_741;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_742;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_743;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_744;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_745;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_804;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_805;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_806;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_807;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_808;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_809;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_810;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_811;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_812;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_813;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_814;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_815;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_816;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_817;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_877;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_878;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_879;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_880;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_881;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_882;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_883;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_884;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_885;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_886;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_887;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_888;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_889;  // fifo_generator_0.v(39)
  wire logic_ramfifo_syn_890;  // fifo_generator_0.v(39)
  wire clk_syn_1;  // fifo_generator_0.v(24)
  wire clk_syn_2;  // fifo_generator_0.v(24)
  wire clk_syn_3;  // fifo_generator_0.v(24)
  wire clk_syn_4;  // fifo_generator_0.v(24)
  wire clk_syn_5;  // fifo_generator_0.v(24)
  wire clk_syn_6;  // fifo_generator_0.v(24)
  wire clk_syn_7;  // fifo_generator_0.v(24)
  wire clk_syn_8;  // fifo_generator_0.v(24)
  wire clk_syn_9;  // fifo_generator_0.v(24)
  wire clk_syn_10;  // fifo_generator_0.v(24)
  wire clk_syn_11;  // fifo_generator_0.v(24)
  wire clk_syn_12;  // fifo_generator_0.v(24)
  wire clk_syn_13;  // fifo_generator_0.v(24)
  wire clk_syn_14;  // fifo_generator_0.v(24)
  wire clk_syn_15;  // fifo_generator_0.v(24)
  wire clk_syn_17;  // fifo_generator_0.v(24)
  wire clk_syn_19;  // fifo_generator_0.v(24)
  wire clk_syn_21;  // fifo_generator_0.v(24)
  wire clk_syn_23;  // fifo_generator_0.v(24)
  wire clk_syn_25;  // fifo_generator_0.v(24)
  wire clk_syn_27;  // fifo_generator_0.v(24)
  wire clk_syn_29;  // fifo_generator_0.v(24)
  wire clk_syn_31;  // fifo_generator_0.v(24)
  wire clk_syn_33;  // fifo_generator_0.v(24)
  wire clk_syn_35;  // fifo_generator_0.v(24)
  wire clk_syn_37;  // fifo_generator_0.v(24)
  wire clk_syn_39;  // fifo_generator_0.v(24)
  wire clk_syn_41;  // fifo_generator_0.v(24)
  wire clk_syn_43;  // fifo_generator_0.v(24)
  wire clk_syn_49;  // fifo_generator_0.v(24)
  wire clk_syn_51;  // fifo_generator_0.v(24)
  wire clk_syn_53;  // fifo_generator_0.v(24)
  wire clk_syn_55;  // fifo_generator_0.v(24)
  wire clk_syn_57;  // fifo_generator_0.v(24)
  wire clk_syn_59;  // fifo_generator_0.v(24)
  wire clk_syn_61;  // fifo_generator_0.v(24)
  wire clk_syn_63;  // fifo_generator_0.v(24)
  wire clk_syn_65;  // fifo_generator_0.v(24)
  wire clk_syn_67;  // fifo_generator_0.v(24)
  wire clk_syn_69;  // fifo_generator_0.v(24)
  wire clk_syn_71;  // fifo_generator_0.v(24)
  wire clk_syn_73;  // fifo_generator_0.v(24)
  wire clk_syn_75;  // fifo_generator_0.v(24)
  wire clk_syn_77;  // fifo_generator_0.v(24)
  wire clk_syn_79;  // fifo_generator_0.v(24)
  wire clk_syn_81;  // fifo_generator_0.v(24)
  wire clk_syn_83;  // fifo_generator_0.v(24)
  wire clk_syn_85;  // fifo_generator_0.v(24)
  wire clk_syn_87;  // fifo_generator_0.v(24)
  wire clk_syn_89;  // fifo_generator_0.v(24)
  wire clk_syn_91;  // fifo_generator_0.v(24)
  wire clk_syn_93;  // fifo_generator_0.v(24)
  wire clk_syn_95;  // fifo_generator_0.v(24)
  wire clk_syn_97;  // fifo_generator_0.v(24)
  wire clk_syn_99;  // fifo_generator_0.v(24)
  wire clk_syn_101;  // fifo_generator_0.v(24)
  wire clk_syn_102;  // fifo_generator_0.v(24)
  wire clk_syn_103;  // fifo_generator_0.v(24)
  wire clk_syn_104;  // fifo_generator_0.v(24)
  wire clk_syn_105;  // fifo_generator_0.v(24)
  wire clk_syn_106;  // fifo_generator_0.v(24)
  wire clk_syn_107;  // fifo_generator_0.v(24)
  wire clk_syn_108;  // fifo_generator_0.v(24)
  wire clk_syn_109;  // fifo_generator_0.v(24)
  wire clk_syn_110;  // fifo_generator_0.v(24)
  wire clk_syn_111;  // fifo_generator_0.v(24)
  wire clk_syn_112;  // fifo_generator_0.v(24)
  wire clk_syn_113;  // fifo_generator_0.v(24)
  wire clk_syn_114;  // fifo_generator_0.v(24)
  wire clk_syn_115;  // fifo_generator_0.v(24)
  wire clk_syn_116;  // fifo_generator_0.v(24)
  wire clk_syn_118;  // fifo_generator_0.v(24)
  wire clk_syn_119;  // fifo_generator_0.v(24)
  wire clk_syn_120;  // fifo_generator_0.v(24)
  wire clk_syn_121;  // fifo_generator_0.v(24)
  wire clk_syn_122;  // fifo_generator_0.v(24)
  wire clk_syn_123;  // fifo_generator_0.v(24)
  wire clk_syn_124;  // fifo_generator_0.v(24)
  wire clk_syn_125;  // fifo_generator_0.v(24)
  wire clk_syn_126;  // fifo_generator_0.v(24)
  wire clk_syn_127;  // fifo_generator_0.v(24)
  wire clk_syn_128;  // fifo_generator_0.v(24)
  wire clk_syn_129;  // fifo_generator_0.v(24)
  wire clk_syn_130;  // fifo_generator_0.v(24)
  wire clk_syn_131;  // fifo_generator_0.v(24)
  wire clk_syn_132;  // fifo_generator_0.v(24)
  wire clk_syn_134;  // fifo_generator_0.v(24)
  wire clk_syn_136;  // fifo_generator_0.v(24)
  wire clk_syn_138;  // fifo_generator_0.v(24)
  wire clk_syn_140;  // fifo_generator_0.v(24)
  wire clk_syn_142;  // fifo_generator_0.v(24)
  wire clk_syn_144;  // fifo_generator_0.v(24)
  wire clk_syn_146;  // fifo_generator_0.v(24)
  wire clk_syn_148;  // fifo_generator_0.v(24)
  wire clk_syn_150;  // fifo_generator_0.v(24)
  wire clk_syn_152;  // fifo_generator_0.v(24)
  wire clk_syn_154;  // fifo_generator_0.v(24)
  wire clk_syn_156;  // fifo_generator_0.v(24)
  wire clk_syn_158;  // fifo_generator_0.v(24)
  wire clk_syn_160;  // fifo_generator_0.v(24)
  wire clk_syn_166;  // fifo_generator_0.v(24)
  wire clk_syn_168;  // fifo_generator_0.v(24)
  wire clk_syn_170;  // fifo_generator_0.v(24)
  wire clk_syn_172;  // fifo_generator_0.v(24)
  wire clk_syn_174;  // fifo_generator_0.v(24)
  wire clk_syn_176;  // fifo_generator_0.v(24)
  wire clk_syn_178;  // fifo_generator_0.v(24)
  wire clk_syn_180;  // fifo_generator_0.v(24)
  wire clk_syn_182;  // fifo_generator_0.v(24)
  wire clk_syn_184;  // fifo_generator_0.v(24)
  wire clk_syn_186;  // fifo_generator_0.v(24)
  wire clk_syn_188;  // fifo_generator_0.v(24)
  wire clk_syn_190;  // fifo_generator_0.v(24)
  wire clk_syn_192;  // fifo_generator_0.v(24)
  wire clk_syn_194;  // fifo_generator_0.v(24)
  wire clk_syn_196;  // fifo_generator_0.v(24)
  wire clk_syn_198;  // fifo_generator_0.v(24)
  wire clk_syn_200;  // fifo_generator_0.v(24)
  wire clk_syn_202;  // fifo_generator_0.v(24)
  wire clk_syn_204;  // fifo_generator_0.v(24)
  wire clk_syn_206;  // fifo_generator_0.v(24)
  wire clk_syn_208;  // fifo_generator_0.v(24)
  wire clk_syn_210;  // fifo_generator_0.v(24)
  wire clk_syn_212;  // fifo_generator_0.v(24)
  wire clk_syn_214;  // fifo_generator_0.v(24)
  wire clk_syn_216;  // fifo_generator_0.v(24)
  wire clk_syn_218;  // fifo_generator_0.v(24)
  wire clk_syn_219;  // fifo_generator_0.v(24)
  wire clk_syn_220;  // fifo_generator_0.v(24)
  wire clk_syn_221;  // fifo_generator_0.v(24)
  wire clk_syn_222;  // fifo_generator_0.v(24)
  wire clk_syn_223;  // fifo_generator_0.v(24)
  wire clk_syn_224;  // fifo_generator_0.v(24)
  wire clk_syn_225;  // fifo_generator_0.v(24)
  wire clk_syn_226;  // fifo_generator_0.v(24)
  wire clk_syn_227;  // fifo_generator_0.v(24)
  wire clk_syn_228;  // fifo_generator_0.v(24)
  wire clk_syn_229;  // fifo_generator_0.v(24)
  wire clk_syn_230;  // fifo_generator_0.v(24)
  wire clk_syn_231;  // fifo_generator_0.v(24)
  wire clk_syn_232;  // fifo_generator_0.v(24)
  wire clk_syn_233;  // fifo_generator_0.v(24)
  wire re_syn_2;  // fifo_generator_0.v(25)
  wire we_syn_2;  // fifo_generator_0.v(24)
  wire _al_n1_syn_4;
  wire _al_n1_syn_6;
  wire _al_n1_syn_8;
  wire _al_n1_syn_10;
  wire _al_n1_syn_12;
  wire _al_n1_syn_14;
  wire _al_n1_syn_16;
  wire _al_n1_syn_18;
  wire _al_n1_syn_20;
  wire _al_n1_syn_22;
  wire _al_n1_syn_24;
  wire _al_n1_syn_26;
  wire _al_n1_syn_34;
  wire _al_n1_syn_36;
  wire _al_n1_syn_38;
  wire _al_n1_syn_40;
  wire _al_n1_syn_42;
  wire _al_n1_syn_44;
  wire _al_n1_syn_46;
  wire _al_n1_syn_48;
  wire _al_n1_syn_50;
  wire _al_n1_syn_52;
  wire _al_n1_syn_54;
  wire _al_n1_syn_56;

  and _al_n1_syn_11 (_al_n1_syn_12, _al_n1_syn_10, clk_syn_29);
  and _al_n1_syn_13 (_al_n1_syn_14, _al_n1_syn_12, clk_syn_31);
  and _al_n1_syn_15 (_al_n1_syn_16, _al_n1_syn_14, clk_syn_33);
  and _al_n1_syn_17 (_al_n1_syn_18, _al_n1_syn_16, clk_syn_35);
  and _al_n1_syn_19 (_al_n1_syn_20, _al_n1_syn_18, clk_syn_37);
  and _al_n1_syn_21 (_al_n1_syn_22, _al_n1_syn_20, clk_syn_39);
  and _al_n1_syn_23 (_al_n1_syn_24, _al_n1_syn_22, clk_syn_41);
  and _al_n1_syn_25 (_al_n1_syn_26, _al_n1_syn_24, clk_syn_43);
  and _al_n1_syn_3 (_al_n1_syn_4, clk_syn_19, clk_syn_21);
  and _al_n1_syn_33 (_al_n1_syn_34, clk_syn_136, clk_syn_138);
  and _al_n1_syn_35 (_al_n1_syn_36, _al_n1_syn_34, clk_syn_140);
  and _al_n1_syn_37 (_al_n1_syn_38, _al_n1_syn_36, clk_syn_142);
  and _al_n1_syn_39 (_al_n1_syn_40, _al_n1_syn_38, clk_syn_144);
  and _al_n1_syn_41 (_al_n1_syn_42, _al_n1_syn_40, clk_syn_146);
  and _al_n1_syn_43 (_al_n1_syn_44, _al_n1_syn_42, clk_syn_148);
  and _al_n1_syn_45 (_al_n1_syn_46, _al_n1_syn_44, clk_syn_150);
  and _al_n1_syn_47 (_al_n1_syn_48, _al_n1_syn_46, clk_syn_152);
  and _al_n1_syn_49 (_al_n1_syn_50, _al_n1_syn_48, clk_syn_154);
  and _al_n1_syn_5 (_al_n1_syn_6, _al_n1_syn_4, clk_syn_23);
  and _al_n1_syn_51 (_al_n1_syn_52, _al_n1_syn_50, clk_syn_156);
  and _al_n1_syn_53 (_al_n1_syn_54, _al_n1_syn_52, clk_syn_158);
  and _al_n1_syn_55 (_al_n1_syn_56, _al_n1_syn_54, clk_syn_160);
  and _al_n1_syn_7 (_al_n1_syn_8, _al_n1_syn_6, clk_syn_25);
  and _al_n1_syn_9 (_al_n1_syn_10, _al_n1_syn_8, clk_syn_27);
  xor clk_syn_100 (clk_syn_101, clk_syn_15, clk_syn_99);  // fifo_generator_0.v(24)
  or clk_syn_133 (clk_syn_134, clk_syn_132, clk_syn_131);  // fifo_generator_0.v(24)
  not clk_syn_135 (clk_syn_136, clk_syn_118);  // fifo_generator_0.v(24)
  not clk_syn_137 (clk_syn_138, clk_syn_119);  // fifo_generator_0.v(24)
  not clk_syn_139 (clk_syn_140, clk_syn_120);  // fifo_generator_0.v(24)
  not clk_syn_141 (clk_syn_142, clk_syn_121);  // fifo_generator_0.v(24)
  not clk_syn_143 (clk_syn_144, clk_syn_122);  // fifo_generator_0.v(24)
  not clk_syn_145 (clk_syn_146, clk_syn_123);  // fifo_generator_0.v(24)
  not clk_syn_147 (clk_syn_148, clk_syn_124);  // fifo_generator_0.v(24)
  not clk_syn_149 (clk_syn_150, clk_syn_125);  // fifo_generator_0.v(24)
  not clk_syn_151 (clk_syn_152, clk_syn_126);  // fifo_generator_0.v(24)
  not clk_syn_153 (clk_syn_154, clk_syn_127);  // fifo_generator_0.v(24)
  not clk_syn_155 (clk_syn_156, clk_syn_128);  // fifo_generator_0.v(24)
  not clk_syn_157 (clk_syn_158, clk_syn_129);  // fifo_generator_0.v(24)
  not clk_syn_159 (clk_syn_160, clk_syn_130);  // fifo_generator_0.v(24)
  or clk_syn_16 (clk_syn_17, clk_syn_15, clk_syn_14);  // fifo_generator_0.v(24)
  xor clk_syn_165 (clk_syn_166, clk_syn_119, clk_syn_118);  // fifo_generator_0.v(24)
  and clk_syn_167 (clk_syn_168, clk_syn_119, clk_syn_136);  // fifo_generator_0.v(24)
  xor clk_syn_169 (clk_syn_170, clk_syn_120, clk_syn_168);  // fifo_generator_0.v(24)
  and clk_syn_171 (clk_syn_172, clk_syn_120, _al_n1_syn_34);  // fifo_generator_0.v(24)
  xor clk_syn_173 (clk_syn_174, clk_syn_121, clk_syn_172);  // fifo_generator_0.v(24)
  and clk_syn_175 (clk_syn_176, clk_syn_121, _al_n1_syn_36);  // fifo_generator_0.v(24)
  xor clk_syn_177 (clk_syn_178, clk_syn_122, clk_syn_176);  // fifo_generator_0.v(24)
  and clk_syn_179 (clk_syn_180, clk_syn_122, _al_n1_syn_38);  // fifo_generator_0.v(24)
  not clk_syn_18 (clk_syn_19, clk_syn_1);  // fifo_generator_0.v(24)
  xor clk_syn_181 (clk_syn_182, clk_syn_123, clk_syn_180);  // fifo_generator_0.v(24)
  and clk_syn_183 (clk_syn_184, clk_syn_123, _al_n1_syn_40);  // fifo_generator_0.v(24)
  xor clk_syn_185 (clk_syn_186, clk_syn_124, clk_syn_184);  // fifo_generator_0.v(24)
  and clk_syn_187 (clk_syn_188, clk_syn_124, _al_n1_syn_42);  // fifo_generator_0.v(24)
  xor clk_syn_189 (clk_syn_190, clk_syn_125, clk_syn_188);  // fifo_generator_0.v(24)
  and clk_syn_191 (clk_syn_192, clk_syn_125, _al_n1_syn_44);  // fifo_generator_0.v(24)
  xor clk_syn_193 (clk_syn_194, clk_syn_126, clk_syn_192);  // fifo_generator_0.v(24)
  and clk_syn_195 (clk_syn_196, clk_syn_126, _al_n1_syn_46);  // fifo_generator_0.v(24)
  xor clk_syn_197 (clk_syn_198, clk_syn_127, clk_syn_196);  // fifo_generator_0.v(24)
  and clk_syn_199 (clk_syn_200, clk_syn_127, _al_n1_syn_48);  // fifo_generator_0.v(24)
  not clk_syn_20 (clk_syn_21, clk_syn_2);  // fifo_generator_0.v(24)
  xor clk_syn_201 (clk_syn_202, clk_syn_128, clk_syn_200);  // fifo_generator_0.v(24)
  and clk_syn_203 (clk_syn_204, clk_syn_128, _al_n1_syn_50);  // fifo_generator_0.v(24)
  xor clk_syn_205 (clk_syn_206, clk_syn_129, clk_syn_204);  // fifo_generator_0.v(24)
  and clk_syn_207 (clk_syn_208, clk_syn_129, _al_n1_syn_52);  // fifo_generator_0.v(24)
  xor clk_syn_209 (clk_syn_210, clk_syn_130, clk_syn_208);  // fifo_generator_0.v(24)
  and clk_syn_211 (clk_syn_212, clk_syn_130, _al_n1_syn_54);  // fifo_generator_0.v(24)
  xor clk_syn_213 (clk_syn_214, clk_syn_131, clk_syn_212);  // fifo_generator_0.v(24)
  and clk_syn_215 (clk_syn_216, clk_syn_134, _al_n1_syn_56);  // fifo_generator_0.v(24)
  xor clk_syn_217 (clk_syn_218, clk_syn_132, clk_syn_216);  // fifo_generator_0.v(24)
  not clk_syn_22 (clk_syn_23, clk_syn_3);  // fifo_generator_0.v(24)
  not clk_syn_24 (clk_syn_25, clk_syn_4);  // fifo_generator_0.v(24)
  not clk_syn_26 (clk_syn_27, clk_syn_5);  // fifo_generator_0.v(24)
  not clk_syn_28 (clk_syn_29, clk_syn_6);  // fifo_generator_0.v(24)
  not clk_syn_30 (clk_syn_31, clk_syn_7);  // fifo_generator_0.v(24)
  not clk_syn_32 (clk_syn_33, clk_syn_8);  // fifo_generator_0.v(24)
  not clk_syn_34 (clk_syn_35, clk_syn_9);  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_352 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_102),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_1));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_353 (
    .ar(1'b0),
    .as(rst),
    .clk(clk),
    .d(clk_syn_103),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_2));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_354 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_104),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_3));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_355 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_105),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_4));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_356 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_106),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_5));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_357 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_107),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_6));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_358 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_108),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_7));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_359 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_109),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_8));  // fifo_generator_0.v(24)
  not clk_syn_36 (clk_syn_37, clk_syn_10);  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_360 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_110),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_9));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_361 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_111),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_10));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_362 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_112),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_11));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_363 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_113),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_12));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_364 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_114),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_13));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_365 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_115),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_14));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_366 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_116),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_15));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_367 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_219),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_118));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_368 (
    .ar(1'b0),
    .as(rst),
    .clk(clk),
    .d(clk_syn_220),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_119));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_369 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_221),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_120));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_370 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_222),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_121));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_371 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_223),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_122));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_372 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_224),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_123));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_373 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_225),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_124));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_374 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_226),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_125));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_375 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_227),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_126));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_376 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_228),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_127));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_377 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_229),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_128));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_378 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_230),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_129));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_379 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_231),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_130));  // fifo_generator_0.v(24)
  not clk_syn_38 (clk_syn_39, clk_syn_11);  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_380 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_232),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_131));  // fifo_generator_0.v(24)
  AL_DFF_X clk_syn_381 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(clk_syn_233),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(clk_syn_132));  // fifo_generator_0.v(24)
  not clk_syn_40 (clk_syn_41, clk_syn_12);  // fifo_generator_0.v(24)
  not clk_syn_42 (clk_syn_43, clk_syn_13);  // fifo_generator_0.v(24)
  xor clk_syn_48 (clk_syn_49, clk_syn_2, clk_syn_1);  // fifo_generator_0.v(24)
  and clk_syn_50 (clk_syn_51, clk_syn_2, clk_syn_19);  // fifo_generator_0.v(24)
  xor clk_syn_52 (clk_syn_53, clk_syn_3, clk_syn_51);  // fifo_generator_0.v(24)
  and clk_syn_54 (clk_syn_55, clk_syn_3, _al_n1_syn_4);  // fifo_generator_0.v(24)
  xor clk_syn_56 (clk_syn_57, clk_syn_4, clk_syn_55);  // fifo_generator_0.v(24)
  and clk_syn_58 (clk_syn_59, clk_syn_4, _al_n1_syn_6);  // fifo_generator_0.v(24)
  xor clk_syn_60 (clk_syn_61, clk_syn_5, clk_syn_59);  // fifo_generator_0.v(24)
  and clk_syn_62 (clk_syn_63, clk_syn_5, _al_n1_syn_8);  // fifo_generator_0.v(24)
  xor clk_syn_64 (clk_syn_65, clk_syn_6, clk_syn_63);  // fifo_generator_0.v(24)
  and clk_syn_66 (clk_syn_67, clk_syn_6, _al_n1_syn_10);  // fifo_generator_0.v(24)
  xor clk_syn_68 (clk_syn_69, clk_syn_7, clk_syn_67);  // fifo_generator_0.v(24)
  and clk_syn_70 (clk_syn_71, clk_syn_7, _al_n1_syn_12);  // fifo_generator_0.v(24)
  xor clk_syn_72 (clk_syn_73, clk_syn_8, clk_syn_71);  // fifo_generator_0.v(24)
  and clk_syn_74 (clk_syn_75, clk_syn_8, _al_n1_syn_14);  // fifo_generator_0.v(24)
  xor clk_syn_76 (clk_syn_77, clk_syn_9, clk_syn_75);  // fifo_generator_0.v(24)
  and clk_syn_78 (clk_syn_79, clk_syn_9, _al_n1_syn_16);  // fifo_generator_0.v(24)
  xor clk_syn_80 (clk_syn_81, clk_syn_10, clk_syn_79);  // fifo_generator_0.v(24)
  and clk_syn_82 (clk_syn_83, clk_syn_10, _al_n1_syn_18);  // fifo_generator_0.v(24)
  xor clk_syn_84 (clk_syn_85, clk_syn_11, clk_syn_83);  // fifo_generator_0.v(24)
  and clk_syn_86 (clk_syn_87, clk_syn_11, _al_n1_syn_20);  // fifo_generator_0.v(24)
  xor clk_syn_88 (clk_syn_89, clk_syn_12, clk_syn_87);  // fifo_generator_0.v(24)
  and clk_syn_90 (clk_syn_91, clk_syn_12, _al_n1_syn_22);  // fifo_generator_0.v(24)
  xor clk_syn_92 (clk_syn_93, clk_syn_13, clk_syn_91);  // fifo_generator_0.v(24)
  and clk_syn_94 (clk_syn_95, clk_syn_13, _al_n1_syn_24);  // fifo_generator_0.v(24)
  xor clk_syn_96 (clk_syn_97, clk_syn_14, clk_syn_95);  // fifo_generator_0.v(24)
  and clk_syn_98 (clk_syn_99, clk_syn_17, _al_n1_syn_26);  // fifo_generator_0.v(24)
  PH1_PHY_CONFIG_V2 #(
    .JTAG_PERSISTN("DISABLE"),
    .SPIX4_PERSISTN("ENABLE"))
    config_inst ();
  not logic_ramfifo_syn_179 (logic_ramfifo_syn_180, logic_ramfifo_syn_69);  // fifo_generator_0.v(39)
  not logic_ramfifo_syn_181 (logic_ramfifo_syn_182, logic_ramfifo_syn_70);  // fifo_generator_0.v(39)
  not logic_ramfifo_syn_185 (logic_ramfifo_syn_186, full_flag);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_203 (logic_ramfifo_syn_204, logic_ramfifo_syn_42, logic_ramfifo_syn_41);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_205 (logic_ramfifo_syn_206, logic_ramfifo_syn_14, logic_ramfifo_syn_13);  // fifo_generator_0.v(39)
  not logic_ramfifo_syn_227 (logic_ramfifo_syn_228, empty_flag);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_281 (logic_ramfifo_syn_282, logic_ramfifo_syn_70, logic_ramfifo_syn_69);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_283 (logic_ramfifo_syn_284, logic_ramfifo_syn_282, logic_ramfifo_syn_68);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_285 (logic_ramfifo_syn_286, logic_ramfifo_syn_284, logic_ramfifo_syn_67);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_287 (logic_ramfifo_syn_288, logic_ramfifo_syn_286, logic_ramfifo_syn_66);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_289 (logic_ramfifo_syn_290, logic_ramfifo_syn_288, logic_ramfifo_syn_65);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_291 (logic_ramfifo_syn_292, logic_ramfifo_syn_290, logic_ramfifo_syn_64);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_293 (logic_ramfifo_syn_294, logic_ramfifo_syn_292, logic_ramfifo_syn_63);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_295 (logic_ramfifo_syn_296, logic_ramfifo_syn_294, logic_ramfifo_syn_62);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_297 (logic_ramfifo_syn_298, logic_ramfifo_syn_296, logic_ramfifo_syn_61);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_299 (logic_ramfifo_syn_300, logic_ramfifo_syn_298, logic_ramfifo_syn_60);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_301 (logic_ramfifo_syn_302, logic_ramfifo_syn_300, logic_ramfifo_syn_59);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_303 (logic_ramfifo_syn_304, logic_ramfifo_syn_302, logic_ramfifo_syn_58);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_305 (logic_ramfifo_syn_306, logic_ramfifo_syn_304, logic_ramfifo_syn_57);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_310 (logic_ramfifo_syn_311, logic_ramfifo_syn_206, logic_ramfifo_syn_12);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_312 (logic_ramfifo_syn_313, logic_ramfifo_syn_311, logic_ramfifo_syn_11);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_314 (logic_ramfifo_syn_315, logic_ramfifo_syn_313, logic_ramfifo_syn_10);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_316 (logic_ramfifo_syn_317, logic_ramfifo_syn_315, logic_ramfifo_syn_9);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_318 (logic_ramfifo_syn_319, logic_ramfifo_syn_317, logic_ramfifo_syn_8);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_320 (logic_ramfifo_syn_321, logic_ramfifo_syn_319, logic_ramfifo_syn_7);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_322 (logic_ramfifo_syn_323, logic_ramfifo_syn_321, logic_ramfifo_syn_6);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_324 (logic_ramfifo_syn_325, logic_ramfifo_syn_323, logic_ramfifo_syn_5);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_326 (logic_ramfifo_syn_327, logic_ramfifo_syn_325, logic_ramfifo_syn_4);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_328 (logic_ramfifo_syn_329, logic_ramfifo_syn_327, logic_ramfifo_syn_3);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_330 (logic_ramfifo_syn_331, logic_ramfifo_syn_329, logic_ramfifo_syn_2);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_332 (logic_ramfifo_syn_333, logic_ramfifo_syn_331, logic_ramfifo_syn_1);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_336 (logic_ramfifo_syn_337, logic_ramfifo_syn_112, logic_ramfifo_syn_111);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_338 (logic_ramfifo_syn_339, logic_ramfifo_syn_337, logic_ramfifo_syn_110);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_340 (logic_ramfifo_syn_341, logic_ramfifo_syn_339, logic_ramfifo_syn_109);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_342 (logic_ramfifo_syn_343, logic_ramfifo_syn_341, logic_ramfifo_syn_108);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_344 (logic_ramfifo_syn_345, logic_ramfifo_syn_343, logic_ramfifo_syn_107);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_346 (logic_ramfifo_syn_347, logic_ramfifo_syn_345, logic_ramfifo_syn_106);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_348 (logic_ramfifo_syn_349, logic_ramfifo_syn_347, logic_ramfifo_syn_105);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_350 (logic_ramfifo_syn_351, logic_ramfifo_syn_349, logic_ramfifo_syn_104);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_352 (logic_ramfifo_syn_353, logic_ramfifo_syn_351, logic_ramfifo_syn_103);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_354 (logic_ramfifo_syn_355, logic_ramfifo_syn_353, logic_ramfifo_syn_102);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_356 (logic_ramfifo_syn_357, logic_ramfifo_syn_355, logic_ramfifo_syn_101);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_358 (logic_ramfifo_syn_359, logic_ramfifo_syn_357, logic_ramfifo_syn_100);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_360 (logic_ramfifo_syn_361, logic_ramfifo_syn_359, logic_ramfifo_syn_99);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_365 (logic_ramfifo_syn_366, logic_ramfifo_syn_204, logic_ramfifo_syn_40);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_367 (logic_ramfifo_syn_368, logic_ramfifo_syn_366, logic_ramfifo_syn_39);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_369 (logic_ramfifo_syn_370, logic_ramfifo_syn_368, logic_ramfifo_syn_38);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_371 (logic_ramfifo_syn_372, logic_ramfifo_syn_370, logic_ramfifo_syn_37);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_373 (logic_ramfifo_syn_374, logic_ramfifo_syn_372, logic_ramfifo_syn_36);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_375 (logic_ramfifo_syn_376, logic_ramfifo_syn_374, logic_ramfifo_syn_35);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_377 (logic_ramfifo_syn_378, logic_ramfifo_syn_376, logic_ramfifo_syn_34);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_379 (logic_ramfifo_syn_380, logic_ramfifo_syn_378, logic_ramfifo_syn_33);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_381 (logic_ramfifo_syn_382, logic_ramfifo_syn_380, logic_ramfifo_syn_32);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_383 (logic_ramfifo_syn_384, logic_ramfifo_syn_382, logic_ramfifo_syn_31);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_385 (logic_ramfifo_syn_386, logic_ramfifo_syn_384, logic_ramfifo_syn_30);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_387 (logic_ramfifo_syn_388, logic_ramfifo_syn_386, logic_ramfifo_syn_29);  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_423 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_187),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_1));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_424 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_188),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_2));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_425 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_189),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_3));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_426 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_190),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_4));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_427 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_191),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_5));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_428 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_192),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_6));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_429 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_193),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_7));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_430 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_194),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_8));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_431 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_195),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_9));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_432 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_196),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_10));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_433 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_197),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_11));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_434 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_198),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_12));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_435 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_199),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_13));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_436 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_200),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_14));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_437 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_1),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_15));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_438 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_2),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_16));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_439 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_3),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_17));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_440 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_4),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_18));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_441 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_5),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_19));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_442 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_6),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_20));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_443 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_7),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_21));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_444 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_8),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_22));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_445 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_9),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_23));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_446 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_10),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_24));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_447 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_11),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_25));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_448 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_12),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_26));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_449 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_13),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_27));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_450 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_14),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_28));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_454 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_248),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_29));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_455 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_249),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_30));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_456 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_250),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_31));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_457 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_251),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_32));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_458 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_252),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_33));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_459 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_253),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_34));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_460 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_254),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_35));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_461 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_255),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_36));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_462 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_256),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_37));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_463 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_257),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_38));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_464 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_258),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_39));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_465 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_259),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_40));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_466 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_260),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_41));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_467 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_261),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_42));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_482 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_29),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_57));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_483 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_30),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_58));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_484 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_31),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_59));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_485 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_32),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_60));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_486 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_33),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_61));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_487 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_34),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_62));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_488 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_35),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_63));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_489 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_36),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_64));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_490 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_37),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_65));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_491 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_38),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_66));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_492 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_39),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_67));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_493 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_40),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_68));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_494 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_41),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_69));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_495 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_42),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_70));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_496 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_306),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_71));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_497 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_304),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_72));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_498 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_302),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_73));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_499 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_300),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_74));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_500 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_298),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_75));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_501 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_296),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_76));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_502 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_294),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_77));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_503 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_292),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_78));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_504 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_290),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_79));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_505 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_288),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_80));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_506 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_286),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_81));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_507 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_284),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_82));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_508 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_282),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_83));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_509 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_70),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_84));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_510 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_333),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_85));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_511 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_331),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_86));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_512 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_329),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_87));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_513 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_327),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_88));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_514 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_325),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_89));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_515 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_323),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_90));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_516 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_321),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_91));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_517 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_319),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_92));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_518 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_317),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_93));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_519 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_315),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_94));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_520 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_313),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_95));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_521 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_311),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_96));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_522 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_206),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_97));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_524 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_15),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_99));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_525 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_16),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_100));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_526 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_17),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_101));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_527 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_18),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_102));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_528 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_19),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_103));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_529 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_20),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_104));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_530 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_21),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_105));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_531 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_22),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_106));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_532 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_23),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_107));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_533 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_24),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_108));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_534 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_25),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_109));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_535 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_26),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_110));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_536 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_27),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_111));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_537 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_28),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_112));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_538 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_361),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_113));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_539 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_359),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_114));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_540 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_357),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_115));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_541 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_355),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_116));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_542 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_353),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_117));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_543 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_351),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_118));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_544 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_349),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_119));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_545 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_347),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_120));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_546 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_345),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_121));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_547 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_343),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_122));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_548 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_341),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_123));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_549 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_339),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_124));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_550 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_337),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_125));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_551 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_112),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_126));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_552 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_388),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_127));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_553 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_386),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_128));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_554 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_384),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_129));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_555 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_382),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_130));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_556 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_380),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_131));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_557 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_378),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_132));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_558 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_376),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_133));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_559 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_374),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_134));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_560 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_372),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_135));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_561 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_370),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_136));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_562 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_368),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_137));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_563 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_366),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_138));  // fifo_generator_0.v(39)
  AL_DFF_X logic_ramfifo_syn_564 (
    .ar(rst),
    .as(1'b0),
    .clk(clk),
    .d(logic_ramfifo_syn_204),
    .en(1'b1),
    .sr(1'b0),
    .ss(1'b0),
    .q(logic_ramfifo_syn_139));  // fifo_generator_0.v(39)
  // address_offset=0;data_offset=0;depth=8192;width=2;num_section=1;width_per_section=2;section_size=8;working_depth=8192;working_width=2;working_numbyte=1;mode_ecc=0;address_step=1;bytes_in_per_section=1;
  // logic_ramfifo_syn_390_8192x8
  PH1_PHY_ERAM #(
    .CSA0("1"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("SIG"),
    .DATA_WIDTH_A("2"),
    .DATA_WIDTH_B("2"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .MODE("DP20K"),
    .OCEAMUX("1"),
    .OCEBMUX("1"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE_A("SYNC"),
    .RESETMODE_B("SYNC"),
    .WEBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    logic_ramfifo_syn_566 (
    .addra({logic_ramfifo_syn_206,logic_ramfifo_syn_12,logic_ramfifo_syn_11,logic_ramfifo_syn_10,logic_ramfifo_syn_9,logic_ramfifo_syn_8,logic_ramfifo_syn_7,logic_ramfifo_syn_6,logic_ramfifo_syn_5,logic_ramfifo_syn_4,logic_ramfifo_syn_3,logic_ramfifo_syn_2,logic_ramfifo_syn_1,1'b1}),
    .addrb({logic_ramfifo_syn_204,logic_ramfifo_syn_40,logic_ramfifo_syn_39,logic_ramfifo_syn_38,logic_ramfifo_syn_37,logic_ramfifo_syn_36,logic_ramfifo_syn_35,logic_ramfifo_syn_34,logic_ramfifo_syn_33,logic_ramfifo_syn_32,logic_ramfifo_syn_31,logic_ramfifo_syn_30,logic_ramfifo_syn_29,1'b1}),
    .clka(clk),
    .clkb(clk),
    .csb({re_syn_2,open_n230,open_n231}),
    .dia({open_n232,open_n233,open_n234,open_n235,open_n236,open_n237,open_n238,open_n239,open_n240,open_n241,open_n242,open_n243,open_n244,open_n245,di[1:0]}),
    .ecc_dbiterrinj(1'b0),
    .ecc_sbiterrinj(1'b0),
    .orsta(rst),
    .orstb(rst),
    .wea(we_syn_2),
    .dob({open_n351,open_n352,open_n353,open_n354,open_n355,open_n356,open_n357,open_n358,open_n359,open_n360,open_n361,open_n362,open_n363,open_n364,dout[1:0]}));  // fifo_generator_0.v(39)
  // address_offset=0;data_offset=2;depth=8192;width=2;num_section=1;width_per_section=2;section_size=8;working_depth=8192;working_width=2;working_numbyte=1;mode_ecc=0;address_step=1;bytes_in_per_section=1;
  // logic_ramfifo_syn_390_8192x8
  PH1_PHY_ERAM #(
    .CSA0("1"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("SIG"),
    .DATA_WIDTH_A("2"),
    .DATA_WIDTH_B("2"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .MODE("DP20K"),
    .OCEAMUX("1"),
    .OCEBMUX("1"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE_A("SYNC"),
    .RESETMODE_B("SYNC"),
    .WEBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    logic_ramfifo_syn_569 (
    .addra({logic_ramfifo_syn_206,logic_ramfifo_syn_12,logic_ramfifo_syn_11,logic_ramfifo_syn_10,logic_ramfifo_syn_9,logic_ramfifo_syn_8,logic_ramfifo_syn_7,logic_ramfifo_syn_6,logic_ramfifo_syn_5,logic_ramfifo_syn_4,logic_ramfifo_syn_3,logic_ramfifo_syn_2,logic_ramfifo_syn_1,1'b1}),
    .addrb({logic_ramfifo_syn_204,logic_ramfifo_syn_40,logic_ramfifo_syn_39,logic_ramfifo_syn_38,logic_ramfifo_syn_37,logic_ramfifo_syn_36,logic_ramfifo_syn_35,logic_ramfifo_syn_34,logic_ramfifo_syn_33,logic_ramfifo_syn_32,logic_ramfifo_syn_31,logic_ramfifo_syn_30,logic_ramfifo_syn_29,1'b1}),
    .clka(clk),
    .clkb(clk),
    .csb({re_syn_2,open_n402,open_n403}),
    .dia({open_n404,open_n405,open_n406,open_n407,open_n408,open_n409,open_n410,open_n411,open_n412,open_n413,open_n414,open_n415,open_n416,open_n417,di[3:2]}),
    .ecc_dbiterrinj(1'b0),
    .ecc_sbiterrinj(1'b0),
    .orsta(rst),
    .orstb(rst),
    .wea(we_syn_2),
    .dob({open_n523,open_n524,open_n525,open_n526,open_n527,open_n528,open_n529,open_n530,open_n531,open_n532,open_n533,open_n534,open_n535,open_n536,dout[3:2]}));  // fifo_generator_0.v(39)
  // address_offset=0;data_offset=4;depth=8192;width=2;num_section=1;width_per_section=2;section_size=8;working_depth=8192;working_width=2;working_numbyte=1;mode_ecc=0;address_step=1;bytes_in_per_section=1;
  // logic_ramfifo_syn_390_8192x8
  PH1_PHY_ERAM #(
    .CSA0("1"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("SIG"),
    .DATA_WIDTH_A("2"),
    .DATA_WIDTH_B("2"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .MODE("DP20K"),
    .OCEAMUX("1"),
    .OCEBMUX("1"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE_A("SYNC"),
    .RESETMODE_B("SYNC"),
    .WEBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    logic_ramfifo_syn_572 (
    .addra({logic_ramfifo_syn_206,logic_ramfifo_syn_12,logic_ramfifo_syn_11,logic_ramfifo_syn_10,logic_ramfifo_syn_9,logic_ramfifo_syn_8,logic_ramfifo_syn_7,logic_ramfifo_syn_6,logic_ramfifo_syn_5,logic_ramfifo_syn_4,logic_ramfifo_syn_3,logic_ramfifo_syn_2,logic_ramfifo_syn_1,1'b1}),
    .addrb({logic_ramfifo_syn_204,logic_ramfifo_syn_40,logic_ramfifo_syn_39,logic_ramfifo_syn_38,logic_ramfifo_syn_37,logic_ramfifo_syn_36,logic_ramfifo_syn_35,logic_ramfifo_syn_34,logic_ramfifo_syn_33,logic_ramfifo_syn_32,logic_ramfifo_syn_31,logic_ramfifo_syn_30,logic_ramfifo_syn_29,1'b1}),
    .clka(clk),
    .clkb(clk),
    .csb({re_syn_2,open_n574,open_n575}),
    .dia({open_n576,open_n577,open_n578,open_n579,open_n580,open_n581,open_n582,open_n583,open_n584,open_n585,open_n586,open_n587,open_n588,open_n589,di[5:4]}),
    .ecc_dbiterrinj(1'b0),
    .ecc_sbiterrinj(1'b0),
    .orsta(rst),
    .orstb(rst),
    .wea(we_syn_2),
    .dob({open_n695,open_n696,open_n697,open_n698,open_n699,open_n700,open_n701,open_n702,open_n703,open_n704,open_n705,open_n706,open_n707,open_n708,dout[5:4]}));  // fifo_generator_0.v(39)
  // address_offset=0;data_offset=6;depth=8192;width=2;num_section=1;width_per_section=2;section_size=8;working_depth=8192;working_width=2;working_numbyte=1;mode_ecc=0;address_step=1;bytes_in_per_section=1;
  // logic_ramfifo_syn_390_8192x8
  PH1_PHY_ERAM #(
    .CSA0("1"),
    .CSA1("1"),
    .CSA2("1"),
    .CSB0("1"),
    .CSB1("1"),
    .CSB2("SIG"),
    .DATA_WIDTH_A("2"),
    .DATA_WIDTH_B("2"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_10(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_11(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_12(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_13(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_14(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_15(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_16(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_17(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_18(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_19(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_1F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_20(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_21(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_22(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_23(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_24(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_25(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_26(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_27(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_28(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_29(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_2F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_30(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_31(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_32(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_33(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_34(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_35(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_36(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_37(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_38(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_39(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_3F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .MODE("DP20K"),
    .OCEAMUX("1"),
    .OCEBMUX("1"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE_A("SYNC"),
    .RESETMODE_B("SYNC"),
    .WEBMUX("0"),
    .WRITEMODE_A("NORMAL"),
    .WRITEMODE_B("NORMAL"))
    logic_ramfifo_syn_575 (
    .addra({logic_ramfifo_syn_206,logic_ramfifo_syn_12,logic_ramfifo_syn_11,logic_ramfifo_syn_10,logic_ramfifo_syn_9,logic_ramfifo_syn_8,logic_ramfifo_syn_7,logic_ramfifo_syn_6,logic_ramfifo_syn_5,logic_ramfifo_syn_4,logic_ramfifo_syn_3,logic_ramfifo_syn_2,logic_ramfifo_syn_1,1'b1}),
    .addrb({logic_ramfifo_syn_204,logic_ramfifo_syn_40,logic_ramfifo_syn_39,logic_ramfifo_syn_38,logic_ramfifo_syn_37,logic_ramfifo_syn_36,logic_ramfifo_syn_35,logic_ramfifo_syn_34,logic_ramfifo_syn_33,logic_ramfifo_syn_32,logic_ramfifo_syn_31,logic_ramfifo_syn_30,logic_ramfifo_syn_29,1'b1}),
    .clka(clk),
    .clkb(clk),
    .csb({re_syn_2,open_n746,open_n747}),
    .dia({open_n748,open_n749,open_n750,open_n751,open_n752,open_n753,open_n754,open_n755,open_n756,open_n757,open_n758,open_n759,open_n760,open_n761,di[7:6]}),
    .ecc_dbiterrinj(1'b0),
    .ecc_sbiterrinj(1'b0),
    .orsta(rst),
    .orstb(rst),
    .wea(we_syn_2),
    .dob({open_n867,open_n868,open_n869,open_n870,open_n871,open_n872,open_n873,open_n874,open_n875,open_n876,open_n877,open_n878,open_n879,open_n880,dout[7:6]}));  // fifo_generator_0.v(39)
  not logic_ramfifo_syn_578 (full_flag, logic_ramfifo_syn_661);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_579 (logic_ramfifo_syn_635, logic_ramfifo_syn_1, logic_ramfifo_syn_57);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_580 (logic_ramfifo_syn_636, logic_ramfifo_syn_2, logic_ramfifo_syn_58);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_581 (logic_ramfifo_syn_637, logic_ramfifo_syn_3, logic_ramfifo_syn_59);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_582 (logic_ramfifo_syn_638, logic_ramfifo_syn_4, logic_ramfifo_syn_60);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_583 (logic_ramfifo_syn_639, logic_ramfifo_syn_5, logic_ramfifo_syn_61);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_584 (logic_ramfifo_syn_640, logic_ramfifo_syn_6, logic_ramfifo_syn_62);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_585 (logic_ramfifo_syn_641, logic_ramfifo_syn_7, logic_ramfifo_syn_63);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_586 (logic_ramfifo_syn_642, logic_ramfifo_syn_8, logic_ramfifo_syn_64);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_587 (logic_ramfifo_syn_643, logic_ramfifo_syn_9, logic_ramfifo_syn_65);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_588 (logic_ramfifo_syn_644, logic_ramfifo_syn_10, logic_ramfifo_syn_66);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_589 (logic_ramfifo_syn_645, logic_ramfifo_syn_11, logic_ramfifo_syn_67);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_590 (logic_ramfifo_syn_646, logic_ramfifo_syn_12, logic_ramfifo_syn_68);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_591 (logic_ramfifo_syn_647, logic_ramfifo_syn_13, logic_ramfifo_syn_180);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_592 (logic_ramfifo_syn_648, logic_ramfifo_syn_14, logic_ramfifo_syn_182);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_593 (logic_ramfifo_syn_649, logic_ramfifo_syn_636, logic_ramfifo_syn_637);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_594 (logic_ramfifo_syn_650, logic_ramfifo_syn_635, logic_ramfifo_syn_649);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_595 (logic_ramfifo_syn_651, logic_ramfifo_syn_638, logic_ramfifo_syn_639);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_596 (logic_ramfifo_syn_652, logic_ramfifo_syn_640, logic_ramfifo_syn_641);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_597 (logic_ramfifo_syn_653, logic_ramfifo_syn_651, logic_ramfifo_syn_652);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_598 (logic_ramfifo_syn_654, logic_ramfifo_syn_650, logic_ramfifo_syn_653);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_599 (logic_ramfifo_syn_655, logic_ramfifo_syn_643, logic_ramfifo_syn_644);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_600 (logic_ramfifo_syn_656, logic_ramfifo_syn_642, logic_ramfifo_syn_655);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_601 (logic_ramfifo_syn_657, logic_ramfifo_syn_645, logic_ramfifo_syn_646);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_602 (logic_ramfifo_syn_658, logic_ramfifo_syn_647, logic_ramfifo_syn_648);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_603 (logic_ramfifo_syn_659, logic_ramfifo_syn_657, logic_ramfifo_syn_658);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_604 (logic_ramfifo_syn_660, logic_ramfifo_syn_656, logic_ramfifo_syn_659);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_605 (logic_ramfifo_syn_661, logic_ramfifo_syn_654, logic_ramfifo_syn_660);  // fifo_generator_0.v(39)
  not logic_ramfifo_syn_662 (empty_flag, logic_ramfifo_syn_745);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_663 (logic_ramfifo_syn_719, logic_ramfifo_syn_99, logic_ramfifo_syn_29);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_664 (logic_ramfifo_syn_720, logic_ramfifo_syn_100, logic_ramfifo_syn_30);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_665 (logic_ramfifo_syn_721, logic_ramfifo_syn_101, logic_ramfifo_syn_31);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_666 (logic_ramfifo_syn_722, logic_ramfifo_syn_102, logic_ramfifo_syn_32);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_667 (logic_ramfifo_syn_723, logic_ramfifo_syn_103, logic_ramfifo_syn_33);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_668 (logic_ramfifo_syn_724, logic_ramfifo_syn_104, logic_ramfifo_syn_34);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_669 (logic_ramfifo_syn_725, logic_ramfifo_syn_105, logic_ramfifo_syn_35);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_670 (logic_ramfifo_syn_726, logic_ramfifo_syn_106, logic_ramfifo_syn_36);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_671 (logic_ramfifo_syn_727, logic_ramfifo_syn_107, logic_ramfifo_syn_37);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_672 (logic_ramfifo_syn_728, logic_ramfifo_syn_108, logic_ramfifo_syn_38);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_673 (logic_ramfifo_syn_729, logic_ramfifo_syn_109, logic_ramfifo_syn_39);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_674 (logic_ramfifo_syn_730, logic_ramfifo_syn_110, logic_ramfifo_syn_40);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_675 (logic_ramfifo_syn_731, logic_ramfifo_syn_111, logic_ramfifo_syn_41);  // fifo_generator_0.v(39)
  xor logic_ramfifo_syn_676 (logic_ramfifo_syn_732, logic_ramfifo_syn_112, logic_ramfifo_syn_42);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_677 (logic_ramfifo_syn_733, logic_ramfifo_syn_720, logic_ramfifo_syn_721);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_678 (logic_ramfifo_syn_734, logic_ramfifo_syn_719, logic_ramfifo_syn_733);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_679 (logic_ramfifo_syn_735, logic_ramfifo_syn_722, logic_ramfifo_syn_723);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_680 (logic_ramfifo_syn_736, logic_ramfifo_syn_724, logic_ramfifo_syn_725);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_681 (logic_ramfifo_syn_737, logic_ramfifo_syn_735, logic_ramfifo_syn_736);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_682 (logic_ramfifo_syn_738, logic_ramfifo_syn_734, logic_ramfifo_syn_737);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_683 (logic_ramfifo_syn_739, logic_ramfifo_syn_727, logic_ramfifo_syn_728);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_684 (logic_ramfifo_syn_740, logic_ramfifo_syn_726, logic_ramfifo_syn_739);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_685 (logic_ramfifo_syn_741, logic_ramfifo_syn_729, logic_ramfifo_syn_730);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_686 (logic_ramfifo_syn_742, logic_ramfifo_syn_731, logic_ramfifo_syn_732);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_687 (logic_ramfifo_syn_743, logic_ramfifo_syn_741, logic_ramfifo_syn_742);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_688 (logic_ramfifo_syn_744, logic_ramfifo_syn_740, logic_ramfifo_syn_743);  // fifo_generator_0.v(39)
  or logic_ramfifo_syn_689 (logic_ramfifo_syn_745, logic_ramfifo_syn_738, logic_ramfifo_syn_744);  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    logic_ramfifo_syn_746 (
    .a(1'b0),
    .o({logic_ramfifo_syn_804,open_n889}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_747 (
    .a(logic_ramfifo_syn_85),
    .b(logic_ramfifo_syn_71),
    .c(logic_ramfifo_syn_804),
    .o({logic_ramfifo_syn_805,wrusedw[0]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_748 (
    .a(logic_ramfifo_syn_86),
    .b(logic_ramfifo_syn_72),
    .c(logic_ramfifo_syn_805),
    .o({logic_ramfifo_syn_806,wrusedw[1]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_749 (
    .a(logic_ramfifo_syn_87),
    .b(logic_ramfifo_syn_73),
    .c(logic_ramfifo_syn_806),
    .o({logic_ramfifo_syn_807,wrusedw[2]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_750 (
    .a(logic_ramfifo_syn_88),
    .b(logic_ramfifo_syn_74),
    .c(logic_ramfifo_syn_807),
    .o({logic_ramfifo_syn_808,wrusedw[3]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_751 (
    .a(logic_ramfifo_syn_89),
    .b(logic_ramfifo_syn_75),
    .c(logic_ramfifo_syn_808),
    .o({logic_ramfifo_syn_809,wrusedw[4]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_752 (
    .a(logic_ramfifo_syn_90),
    .b(logic_ramfifo_syn_76),
    .c(logic_ramfifo_syn_809),
    .o({logic_ramfifo_syn_810,wrusedw[5]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_753 (
    .a(logic_ramfifo_syn_91),
    .b(logic_ramfifo_syn_77),
    .c(logic_ramfifo_syn_810),
    .o({logic_ramfifo_syn_811,wrusedw[6]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_754 (
    .a(logic_ramfifo_syn_92),
    .b(logic_ramfifo_syn_78),
    .c(logic_ramfifo_syn_811),
    .o({logic_ramfifo_syn_812,wrusedw[7]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_755 (
    .a(logic_ramfifo_syn_93),
    .b(logic_ramfifo_syn_79),
    .c(logic_ramfifo_syn_812),
    .o({logic_ramfifo_syn_813,wrusedw[8]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_756 (
    .a(logic_ramfifo_syn_94),
    .b(logic_ramfifo_syn_80),
    .c(logic_ramfifo_syn_813),
    .o({logic_ramfifo_syn_814,wrusedw[9]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_757 (
    .a(logic_ramfifo_syn_95),
    .b(logic_ramfifo_syn_81),
    .c(logic_ramfifo_syn_814),
    .o({logic_ramfifo_syn_815,wrusedw[10]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_758 (
    .a(logic_ramfifo_syn_96),
    .b(logic_ramfifo_syn_82),
    .c(logic_ramfifo_syn_815),
    .o({logic_ramfifo_syn_816,wrusedw[11]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_759 (
    .a(logic_ramfifo_syn_97),
    .b(logic_ramfifo_syn_83),
    .c(logic_ramfifo_syn_816),
    .o({logic_ramfifo_syn_817,wrusedw[12]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_760 (
    .a(logic_ramfifo_syn_28),
    .b(logic_ramfifo_syn_84),
    .c(logic_ramfifo_syn_817),
    .o({open_n890,wrusedw[13]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB_CARRY"))
    logic_ramfifo_syn_819 (
    .a(1'b0),
    .o({logic_ramfifo_syn_877,open_n893}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_820 (
    .a(logic_ramfifo_syn_113),
    .b(logic_ramfifo_syn_127),
    .c(logic_ramfifo_syn_877),
    .o({logic_ramfifo_syn_878,rdusedw[0]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_821 (
    .a(logic_ramfifo_syn_114),
    .b(logic_ramfifo_syn_128),
    .c(logic_ramfifo_syn_878),
    .o({logic_ramfifo_syn_879,rdusedw[1]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_822 (
    .a(logic_ramfifo_syn_115),
    .b(logic_ramfifo_syn_129),
    .c(logic_ramfifo_syn_879),
    .o({logic_ramfifo_syn_880,rdusedw[2]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_823 (
    .a(logic_ramfifo_syn_116),
    .b(logic_ramfifo_syn_130),
    .c(logic_ramfifo_syn_880),
    .o({logic_ramfifo_syn_881,rdusedw[3]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_824 (
    .a(logic_ramfifo_syn_117),
    .b(logic_ramfifo_syn_131),
    .c(logic_ramfifo_syn_881),
    .o({logic_ramfifo_syn_882,rdusedw[4]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_825 (
    .a(logic_ramfifo_syn_118),
    .b(logic_ramfifo_syn_132),
    .c(logic_ramfifo_syn_882),
    .o({logic_ramfifo_syn_883,rdusedw[5]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_826 (
    .a(logic_ramfifo_syn_119),
    .b(logic_ramfifo_syn_133),
    .c(logic_ramfifo_syn_883),
    .o({logic_ramfifo_syn_884,rdusedw[6]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_827 (
    .a(logic_ramfifo_syn_120),
    .b(logic_ramfifo_syn_134),
    .c(logic_ramfifo_syn_884),
    .o({logic_ramfifo_syn_885,rdusedw[7]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_828 (
    .a(logic_ramfifo_syn_121),
    .b(logic_ramfifo_syn_135),
    .c(logic_ramfifo_syn_885),
    .o({logic_ramfifo_syn_886,rdusedw[8]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_829 (
    .a(logic_ramfifo_syn_122),
    .b(logic_ramfifo_syn_136),
    .c(logic_ramfifo_syn_886),
    .o({logic_ramfifo_syn_887,rdusedw[9]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_830 (
    .a(logic_ramfifo_syn_123),
    .b(logic_ramfifo_syn_137),
    .c(logic_ramfifo_syn_887),
    .o({logic_ramfifo_syn_888,rdusedw[10]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_831 (
    .a(logic_ramfifo_syn_124),
    .b(logic_ramfifo_syn_138),
    .c(logic_ramfifo_syn_888),
    .o({logic_ramfifo_syn_889,rdusedw[11]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_832 (
    .a(logic_ramfifo_syn_125),
    .b(logic_ramfifo_syn_139),
    .c(logic_ramfifo_syn_889),
    .o({logic_ramfifo_syn_890,rdusedw[12]}));  // fifo_generator_0.v(39)
  AL_MAP_ADDER #(
    .ALUTYPE("SUB"))
    logic_ramfifo_syn_833 (
    .a(logic_ramfifo_syn_126),
    .b(logic_ramfifo_syn_70),
    .c(logic_ramfifo_syn_890),
    .o({open_n894,rdusedw[13]}));  // fifo_generator_0.v(39)
  and re_syn_1 (re_syn_2, re, logic_ramfifo_syn_228);  // fifo_generator_0.v(25)
  AL_MUX re_syn_163 (
    .i0(clk_syn_118),
    .i1(clk_syn_136),
    .sel(re_syn_2),
    .o(clk_syn_219));  // fifo_generator_0.v(25)
  AL_MUX re_syn_168 (
    .i0(clk_syn_119),
    .i1(clk_syn_166),
    .sel(re_syn_2),
    .o(clk_syn_220));  // fifo_generator_0.v(25)
  AL_MUX re_syn_173 (
    .i0(clk_syn_120),
    .i1(clk_syn_170),
    .sel(re_syn_2),
    .o(clk_syn_221));  // fifo_generator_0.v(25)
  AL_MUX re_syn_178 (
    .i0(clk_syn_121),
    .i1(clk_syn_174),
    .sel(re_syn_2),
    .o(clk_syn_222));  // fifo_generator_0.v(25)
  AL_MUX re_syn_183 (
    .i0(clk_syn_122),
    .i1(clk_syn_178),
    .sel(re_syn_2),
    .o(clk_syn_223));  // fifo_generator_0.v(25)
  AL_MUX re_syn_188 (
    .i0(clk_syn_123),
    .i1(clk_syn_182),
    .sel(re_syn_2),
    .o(clk_syn_224));  // fifo_generator_0.v(25)
  AL_MUX re_syn_193 (
    .i0(clk_syn_124),
    .i1(clk_syn_186),
    .sel(re_syn_2),
    .o(clk_syn_225));  // fifo_generator_0.v(25)
  AL_MUX re_syn_198 (
    .i0(clk_syn_125),
    .i1(clk_syn_190),
    .sel(re_syn_2),
    .o(clk_syn_226));  // fifo_generator_0.v(25)
  AL_MUX re_syn_203 (
    .i0(clk_syn_126),
    .i1(clk_syn_194),
    .sel(re_syn_2),
    .o(clk_syn_227));  // fifo_generator_0.v(25)
  AL_MUX re_syn_208 (
    .i0(clk_syn_127),
    .i1(clk_syn_198),
    .sel(re_syn_2),
    .o(clk_syn_228));  // fifo_generator_0.v(25)
  AL_MUX re_syn_213 (
    .i0(clk_syn_128),
    .i1(clk_syn_202),
    .sel(re_syn_2),
    .o(clk_syn_229));  // fifo_generator_0.v(25)
  AL_MUX re_syn_218 (
    .i0(clk_syn_129),
    .i1(clk_syn_206),
    .sel(re_syn_2),
    .o(clk_syn_230));  // fifo_generator_0.v(25)
  AL_MUX re_syn_223 (
    .i0(clk_syn_130),
    .i1(clk_syn_210),
    .sel(re_syn_2),
    .o(clk_syn_231));  // fifo_generator_0.v(25)
  AL_MUX re_syn_228 (
    .i0(clk_syn_131),
    .i1(clk_syn_214),
    .sel(re_syn_2),
    .o(clk_syn_232));  // fifo_generator_0.v(25)
  AL_MUX re_syn_233 (
    .i0(clk_syn_132),
    .i1(clk_syn_218),
    .sel(re_syn_2),
    .o(clk_syn_233));  // fifo_generator_0.v(25)
  AL_MUX re_syn_238 (
    .i0(logic_ramfifo_syn_29),
    .i1(clk_syn_119),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_248));  // fifo_generator_0.v(25)
  AL_MUX re_syn_243 (
    .i0(logic_ramfifo_syn_30),
    .i1(clk_syn_120),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_249));  // fifo_generator_0.v(25)
  AL_MUX re_syn_248 (
    .i0(logic_ramfifo_syn_31),
    .i1(clk_syn_121),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_250));  // fifo_generator_0.v(25)
  AL_MUX re_syn_253 (
    .i0(logic_ramfifo_syn_32),
    .i1(clk_syn_122),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_251));  // fifo_generator_0.v(25)
  AL_MUX re_syn_258 (
    .i0(logic_ramfifo_syn_33),
    .i1(clk_syn_123),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_252));  // fifo_generator_0.v(25)
  AL_MUX re_syn_263 (
    .i0(logic_ramfifo_syn_34),
    .i1(clk_syn_124),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_253));  // fifo_generator_0.v(25)
  AL_MUX re_syn_268 (
    .i0(logic_ramfifo_syn_35),
    .i1(clk_syn_125),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_254));  // fifo_generator_0.v(25)
  AL_MUX re_syn_273 (
    .i0(logic_ramfifo_syn_36),
    .i1(clk_syn_126),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_255));  // fifo_generator_0.v(25)
  AL_MUX re_syn_278 (
    .i0(logic_ramfifo_syn_37),
    .i1(clk_syn_127),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_256));  // fifo_generator_0.v(25)
  AL_MUX re_syn_283 (
    .i0(logic_ramfifo_syn_38),
    .i1(clk_syn_128),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_257));  // fifo_generator_0.v(25)
  AL_MUX re_syn_288 (
    .i0(logic_ramfifo_syn_39),
    .i1(clk_syn_129),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_258));  // fifo_generator_0.v(25)
  AL_MUX re_syn_293 (
    .i0(logic_ramfifo_syn_40),
    .i1(clk_syn_130),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_259));  // fifo_generator_0.v(25)
  AL_MUX re_syn_298 (
    .i0(logic_ramfifo_syn_41),
    .i1(clk_syn_131),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_260));  // fifo_generator_0.v(25)
  AL_MUX re_syn_303 (
    .i0(logic_ramfifo_syn_42),
    .i1(clk_syn_132),
    .sel(re_syn_2),
    .o(logic_ramfifo_syn_261));  // fifo_generator_0.v(25)
  and we_syn_1 (we_syn_2, we, logic_ramfifo_syn_186);  // fifo_generator_0.v(24)
  AL_MUX we_syn_104 (
    .i0(clk_syn_15),
    .i1(clk_syn_101),
    .sel(we_syn_2),
    .o(clk_syn_116));  // fifo_generator_0.v(24)
  AL_MUX we_syn_109 (
    .i0(logic_ramfifo_syn_1),
    .i1(clk_syn_2),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_187));  // fifo_generator_0.v(24)
  AL_MUX we_syn_114 (
    .i0(logic_ramfifo_syn_2),
    .i1(clk_syn_3),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_188));  // fifo_generator_0.v(24)
  AL_MUX we_syn_119 (
    .i0(logic_ramfifo_syn_3),
    .i1(clk_syn_4),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_189));  // fifo_generator_0.v(24)
  AL_MUX we_syn_124 (
    .i0(logic_ramfifo_syn_4),
    .i1(clk_syn_5),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_190));  // fifo_generator_0.v(24)
  AL_MUX we_syn_129 (
    .i0(logic_ramfifo_syn_5),
    .i1(clk_syn_6),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_191));  // fifo_generator_0.v(24)
  AL_MUX we_syn_134 (
    .i0(logic_ramfifo_syn_6),
    .i1(clk_syn_7),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_192));  // fifo_generator_0.v(24)
  AL_MUX we_syn_139 (
    .i0(logic_ramfifo_syn_7),
    .i1(clk_syn_8),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_193));  // fifo_generator_0.v(24)
  AL_MUX we_syn_144 (
    .i0(logic_ramfifo_syn_8),
    .i1(clk_syn_9),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_194));  // fifo_generator_0.v(24)
  AL_MUX we_syn_149 (
    .i0(logic_ramfifo_syn_9),
    .i1(clk_syn_10),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_195));  // fifo_generator_0.v(24)
  AL_MUX we_syn_154 (
    .i0(logic_ramfifo_syn_10),
    .i1(clk_syn_11),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_196));  // fifo_generator_0.v(24)
  AL_MUX we_syn_159 (
    .i0(logic_ramfifo_syn_11),
    .i1(clk_syn_12),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_197));  // fifo_generator_0.v(24)
  AL_MUX we_syn_164 (
    .i0(logic_ramfifo_syn_12),
    .i1(clk_syn_13),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_198));  // fifo_generator_0.v(24)
  AL_MUX we_syn_169 (
    .i0(logic_ramfifo_syn_13),
    .i1(clk_syn_14),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_199));  // fifo_generator_0.v(24)
  AL_MUX we_syn_174 (
    .i0(logic_ramfifo_syn_14),
    .i1(clk_syn_15),
    .sel(we_syn_2),
    .o(logic_ramfifo_syn_200));  // fifo_generator_0.v(24)
  AL_MUX we_syn_34 (
    .i0(clk_syn_1),
    .i1(clk_syn_19),
    .sel(we_syn_2),
    .o(clk_syn_102));  // fifo_generator_0.v(24)
  AL_MUX we_syn_39 (
    .i0(clk_syn_2),
    .i1(clk_syn_49),
    .sel(we_syn_2),
    .o(clk_syn_103));  // fifo_generator_0.v(24)
  AL_MUX we_syn_44 (
    .i0(clk_syn_3),
    .i1(clk_syn_53),
    .sel(we_syn_2),
    .o(clk_syn_104));  // fifo_generator_0.v(24)
  AL_MUX we_syn_49 (
    .i0(clk_syn_4),
    .i1(clk_syn_57),
    .sel(we_syn_2),
    .o(clk_syn_105));  // fifo_generator_0.v(24)
  AL_MUX we_syn_54 (
    .i0(clk_syn_5),
    .i1(clk_syn_61),
    .sel(we_syn_2),
    .o(clk_syn_106));  // fifo_generator_0.v(24)
  AL_MUX we_syn_59 (
    .i0(clk_syn_6),
    .i1(clk_syn_65),
    .sel(we_syn_2),
    .o(clk_syn_107));  // fifo_generator_0.v(24)
  AL_MUX we_syn_64 (
    .i0(clk_syn_7),
    .i1(clk_syn_69),
    .sel(we_syn_2),
    .o(clk_syn_108));  // fifo_generator_0.v(24)
  AL_MUX we_syn_69 (
    .i0(clk_syn_8),
    .i1(clk_syn_73),
    .sel(we_syn_2),
    .o(clk_syn_109));  // fifo_generator_0.v(24)
  AL_MUX we_syn_74 (
    .i0(clk_syn_9),
    .i1(clk_syn_77),
    .sel(we_syn_2),
    .o(clk_syn_110));  // fifo_generator_0.v(24)
  AL_MUX we_syn_79 (
    .i0(clk_syn_10),
    .i1(clk_syn_81),
    .sel(we_syn_2),
    .o(clk_syn_111));  // fifo_generator_0.v(24)
  AL_MUX we_syn_84 (
    .i0(clk_syn_11),
    .i1(clk_syn_85),
    .sel(we_syn_2),
    .o(clk_syn_112));  // fifo_generator_0.v(24)
  AL_MUX we_syn_89 (
    .i0(clk_syn_12),
    .i1(clk_syn_89),
    .sel(we_syn_2),
    .o(clk_syn_113));  // fifo_generator_0.v(24)
  AL_MUX we_syn_94 (
    .i0(clk_syn_13),
    .i1(clk_syn_93),
    .sel(we_syn_2),
    .o(clk_syn_114));  // fifo_generator_0.v(24)
  AL_MUX we_syn_99 (
    .i0(clk_syn_14),
    .i1(clk_syn_97),
    .sel(we_syn_2),
    .o(clk_syn_115));  // fifo_generator_0.v(24)

  // synthesis translate_off
  glbl glbl();
  always @(*) begin
    glbl.gsr <= PH1_PHY_GSR.gsr;
    glbl.gsrn <= PH1_PHY_GSR.gsrn;
    glbl.done_gwe <= PH1_PHY_GSR.done_gwe;
    glbl.usr_gsrn_en <= PH1_PHY_GSR.usr_gsrn_en;
  end
  // synthesis translate_on

endmodule 

