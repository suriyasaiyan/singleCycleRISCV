# singleCycleRISCV
- Single clock cycle implementation of RISC V

- scalability

- Using a lookup table is a feasible way to optimize this code,especially when the number of instruction types is relatively small

- the following suggestions can be made to optimize the register file usage:

    Avoid using more registers than are necessary. This can be done by grouping related variables together in memory and by using a compiler that supports register allocation and optimization.
    Use the most frequently used registers first. This will reduce the number of register loads and stores that are required.
    Try to avoid writing to registers that are going to be used in the next instruction. This can be done by reordering the instructions or by using a register allocator.
    Use a register allocator to keep the most frequently used registers in the register file. This can improve performance by reducing the number of times that registers need to be spilled to memory.
    
- defines.vh 

- `defualt_nettpe none can help catch errors in your Verilog code because it forces you to explicitly specify the data type for each net
