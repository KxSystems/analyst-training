## Statistical Transforms


Statistical transforms apply a function to the data *before* plotting it.

Some geometries come bundled with a default stat transform.

```q
// A histogram is a bar geometry paired with a 1D binning transform
.qp.go[500;200] .qp.histogram[subset; `signal; ::];

// This can be recreated as...
.qp.go[500;200] .qp.bar[subset; `signal; `count__]
    .qp.s.stat[ .gg.stat.bin1d[`signal; ::; .st.a.count[]; ::] ];
    
// The `histogram` wrapper takes care of setting sizes and scales for you   
.qp.go[500;200] .qp.bar[subset; `signal; `count__]
      .qp.s.stat[ .gg.stat.bin1d[`signal; (`w;100;0); .st.a.count[]; ::] ]
    , .qp.s.geom[enlist[`size]!enlist 100]
    , .qp.s.scale[`y; .gg.scale.linear];
    
```

A stat transform can be applied to any layer. The available built-in transforms
exist under `.gg.stat`, and more information about these is available in
*Analyst Function Reference* under *Help*.

In general, n-dimensional binning is supported. 3D binning can be useful paired
with a tile geometry which can take advantage of this. The plot below is a 2D
grid, where each grid cell is split further into a series of segments depicting
the duration distribution within the cell.

```q
.qp.go[500;500] .qp.tile[subset; `signal; `sensor]
      .qp.s.stat[ .gg.stat.binNd[`ma`sensor`signal; ((`c;50;0); (`w;1;0); (`c;50;0)); .st.a.count[]; ::] ]
    , .qp.s.aes     [`group; `signal]
    , .qp.s.geom    [`width`height`position!(50; 50; `dodge)]
    , .qp.s.aes     [`fill; `ma]
    , .qp.s.scale   [`fill; .gg.scale.colour.gradient . .gg.colour`SteelBlue`FireBrick]
    , .qp.s.aes     [`alpha; `count__]
    , .qp.s.scale   [`alpha; .gg.scale.alpha[50; 255]];
```
