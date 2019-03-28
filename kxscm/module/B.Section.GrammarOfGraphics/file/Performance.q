
// Available options:

.gg.cheat.sheet[]


// Create some data:
data:    sim.system[];
data10M: 10000000#data;


// Time for a simple histogram (1 dimension)

\ts .qp.go[500;500] .qp.plot[data10M; `signal; ::]

// Time for a histogram with many bins

\ts .qp.go[600;300] .qp.plot[data10M; `signal] .qp.s.binx[`c;200;0]

// Time for a heatmap (2 dimensions)

\ts .qp.go[500;500] .qp.plot[data10M; `signal`ma; ::]



// Custom settings:

settings: .qp.s.binx  [`c;100;0]
        , .qp.s.biny  [`c;100;0]
        , .qp.s.aggr  [.st.a.count[] , .st.a.custom[`avgactive; `active; avg]]
        , .qp.s.aes   [`fill; `avgactive]
        , .qp.s.scale [`fill; .gg.scale.colour.gradient . `steelblue`firebrick];

// Time for a heatmap with custom settings (3 dimensions, 2 log scales):

\ts .qp.go[500;500] .qp.heatmap[data10M; `signal; `ma; settings]
      

