////////////////////////////////////////////////////////////////////////////////
// Purpose : synthesizable CRC function
//   * polynomial: (0 1 4)
//   * data width: 16
//
////////////////////////////////////////////////////////////////////////////////
module CRC4_D16 (

  // polynomial: (0 1 4)
  // data width: 16
  // convention: the first serial bit is D[15]

    input [15:0] Data,
    input [3:0]  crc,
    output[3:0]  nextCRC4_D16
    
    );
    wire [15:0] d;
    wire [3:0] c;
    wire [3:0] newcrc;
    
    assign d = Data;
    assign c = crc;

    assign newcrc[0] = d[15] ^ d[11] ^ d[10] ^ d[9] ^ d[8] ^ d[6] ^ d[4] ^ d[3] ^ d[0] ^ c[3];
    assign newcrc[1] = d[15] ^ d[12] ^ d[8] ^ d[7] ^ d[6] ^ d[5] ^ d[3] ^ d[1] ^ d[0] ^ c[0] ^ c[3];
    assign newcrc[2] = d[13] ^ d[9] ^ d[8] ^ d[7] ^ d[6] ^ d[4] ^ d[2] ^ d[1] ^ c[1];
    assign newcrc[3] = d[14] ^ d[10] ^ d[9] ^ d[8] ^ d[7] ^ d[5] ^ d[3] ^ d[2] ^ c[2];
    assign nextCRC4_D16 = newcrc;

endmodule
