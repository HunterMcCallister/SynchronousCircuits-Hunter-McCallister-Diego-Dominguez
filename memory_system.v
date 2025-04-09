`timescale 1ps/1ps

module memory_system(
    input [7:0] data,
    input store,
    input [1:0] addr,
    output [7:0] memory
);
// This should instantiate 4 instances of
// byte_memory, and then demultiplex
wire [7:0] memory0, memory1, memory2, memory3;
wire [3:0] storeDemux;
wire [3:0] outWire;
wire [7:0] dataDemuxOutBundle[3:0];
wire [7:0] memoryBundle[3:0];



    // data and store into the one selected by
    // addr
demultiplexer storeDemuxInst (
    .data(store),
    .sel(addr),
    .A(storeDemux[0]),
    .B(storeDemux[1]),
    .C(storeDemux[2]),
    .D(storeDemux[3])
    );
    
    
demultiplexer dataDemux (
    .data(data),
    .sel(addr),
    .A(dataDemuxOutBundle[0]),
    .B(dataDemuxOutBundle[1]),
    .C(dataDemuxOutBundle[2]),
    .D(dataDemuxOutBundle[3])
);



    // It should then multiplex the output of the
    // memory specified by addr into the memory
    // output for display on the LEDs
byte_memory memInst0 (
    .data(data),
    .store(storeDemux[0]),
    .memory(memoryBundle[0])
);

byte_memory memInst1 (
    .data(data),
    .store(storeDemux[1]),
    .memory(memoryBundle[1])
);

byte_memory memInst2 (
    .data(data),
    .store(storeDemux[2]),
    .memory(memoryBundle[2])
);

byte_memory memInst3 (
    .data(data),
    .store(storeDemux[3]),
    .memory(memoryBundle[3])
);

    // and one multiplexer:
    // 1. Multiplex selected byte -> memory
    
    byte_mux mux_inst (
    .mem0(memoryBundle[0]),
    .mem1(memoryBundle[1]),
    .mem2(memoryBundle[2]),
    .mem3(memoryBundle[3]),
    .sel(addr),
    .out(memory)
);

// demultiplexer mux (
//     .data(data),
//     .sel(addr),
//     .A(memInst0),
//     .B(memInst1),
//     .C(memInst2),
//     .D(memInst3)
//     );
    
    

endmodule