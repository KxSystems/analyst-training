# Chunking

Note the orange edges between nodes in the CellData tranform, and 
the green edges in the CellDataChunking transform. When a line from
source node to output node is optimized for chunking, the edge from 
source to output will be coloured green. 

If a line is green, all actions between the source and output will be 
performed on small batches of the data at a time as to not exhaust 
memory on large sources.

If a line is orange, the entire source will be read, and actions applied
to the entire source at once rather than in batches.