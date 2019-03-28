
// Available options:

.gg.cheat.sheet[]


// Create some data:

diamonds10M: 10000000#diamonds;


// Time for a simple histogram (1 dimension)

\ts .qp.go[500;500] .qp.plot[diamonds10M; `carat; ::]

// Time for a histogram with many bins

\ts .qp.go[600;300] .qp.plot[diamonds10M; `price] .qp.s.binx[`c;200;0]

// Time for a heatmap (2 dimensions)

\ts .qp.go[500;500] .qp.plot[diamonds10M; `carat`price; ::]



// Custom settings:

settings: .qp.s.binx  [`c;100;0]
        , .qp.s.biny  [`c;100;0]
        , .qp.s.aggr  [.st.a.count[] , .st.a.custom[`avgdepth; `depth; avg]]
        , .qp.s.aes   [`fill; `avgdepth]
        , .qp.s.scale [`fill; .gg.scale.colour.gradient . .gg.colour`SteelBlue`FireBrick]
        , .qp.s.scale [`x; .gg.scale.log]
        , .qp.s.scale [`y; .gg.scale.log];

// Time for a heatmap with custom settings (3 dimensions, 2 log scales):

\ts .qp.go[500;500] .qp.heatmap[diamonds10M;`carat; `price; settings]
      

