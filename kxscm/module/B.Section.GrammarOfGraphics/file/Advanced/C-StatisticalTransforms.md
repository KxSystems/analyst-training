## Statistical Transforms


Statistical transforms apply a function to the data *before* plotting it.

Some geometries come bundled with a default stat transform.

```q
    
    // A histogram is a bar geometry paired with a 1D binning transform
    
    .qp.go[500;200] .qp.histogram[cells; `duration; ::];
    
    // This can be recreated as...

    .qp.go[500;200] .qp.bar[cells; `duration; `count__]
        .qp.s.stat[ .gg.stat.bin1d[`duration; ::; .st.a.count[]; ::] ];
        
    // The `histogram` wrapper takes care of setting sizes and scales for you
        
    .qp.go[500;200] .qp.bar[cells; `duration; `count__]
          .qp.s.stat[ .gg.stat.bin1d[`duration; (`w;100;0); .st.a.count[]; ::] ]
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

    .qp.go[500;500] .qp.tile[cells; `dest; `source]
          .qp.s.stat[ .gg.stat.binNd[`dest`source`duration; ((`w;50;0); (`w;50;0); (`c;5;0)); .st.a.count[]; ::] ]
        , .qp.s.aes     [`group; `duration]
        , .qp.s.geom    [`width`height`position!(50; 50; `dodge)]
        , .qp.s.aes     [`fill; `duration]
        , .qp.s.scale   [`fill; .gg.scale.colour.gradient . .gg.colour`SteelBlue`FireBrick]
        , .qp.s.aes     [`alpha; `count__]
        , .qp.s.scale   [`alpha; .gg.scale.alpha[50; 255]];

```
