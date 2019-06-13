## Aesthetics


A custom plot is created by mapping columns to visual attributes. The last
argument of each geometry is used for this mapping. If null, as in the 
previous examples, a plot with no additional mappings or settings is created.

The aesthetics that can be mapped are determined by the geometry. Information
on each geometry can be found in the *Analyst Function Reference* under *Help*.

```q
// Basic plot
.qp.go[500;500] .qp.point[subset; `time; `signal; ::];

// A mapping with no scale will *try* to produce something
.qp.go[500;500] .qp.point[subset; `time; `signal]
    .qp.s.aes   [`fill; `active];
    
// A mapping with a scale is much better
.qp.go[500;500] .qp.point[subset; `time; `signal]
      .qp.s.aes   [`fill; `active]
    , .qp.s.scale [`fill; .gg.scale.colour.gradient[`firebrick; `steelblue] ];
    
// More mappings can be joined together 
.qp.go[500;500] .qp.point[subset; `time; `signal]
      .qp.s.aes   [`fill`alpha; `active`ma]
    , .qp.s.scale [`fill; .gg.scale.colour.gradient[`firebrick; `steelblue] ]
    , .qp.s.scale [`alpha; .gg.scale.alpha[50; 255] ];
    
// And more...
.qp.go[500;500] .qp.point[subset; `time; `signal]
      .qp.s.aes   [`fill`alpha`size; `active`ma`ma]
    , .qp.s.scale [`fill; .gg.scale.colour.gradient[`firebrick; `steelblue] ]
    , .qp.s.scale [`alpha; .gg.scale.alpha[50; 255] ]
    , .qp.s.scale [`size; .gg.scale.circle.area[1; 20] ];
    
```

Static attributes are assigned using a `.qp.s.geom[]` setting. The static attributes that can be 
assigned are determined by the particular geometry. Individual geometry information is available
in the *Analyst Function Reference* under *Help*.

```q 
// Set the size and fill colour of a point geometry   
.qp.go[500;500] .qp.point[subset; `time; `signal]
    .qp.s.geom[`fill`size!(`firebrick; 0.5)]
    
// In general, `fill refers to fill colour and `colour refers to stroke colour
.qp.go[500;500] .qp.point[subset; `time; `signal]
    .qp.s.geom[`fill`colour`size!(`gold; `black; 2)]
    
// Alpha (opacity) only applies to the fill colour
.qp.go[500;500] .qp.point[subset; `time; `signal]
    .qp.s.geom[`alpha`colour`size!(0x00; `black; 5)]
    
```