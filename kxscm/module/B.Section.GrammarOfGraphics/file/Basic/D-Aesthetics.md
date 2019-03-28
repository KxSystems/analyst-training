## Aesthetics


A custom plot is created by mapping columns to visual attributes. The last
argument of each geometry is used for this mapping. If null, as in the 
previous examples, a plot with no additional mappings or settings is created.

The aesthetics that can be mapped are determined by the geometry. Information
on each geometry can be found in the *Analyst Function Reference* under *Help*.

```q

    // Basic plot

    .qp.go[500;500] .qp.point[cells; `date; `dest; ::];
    
    // A mapping with no scale will *try* to produce something
    
    .qp.go[500;500] .qp.point[cells; `date; `dest]
        .qp.s.aes   [`fill; `duration];
        
    // A mapping with a scale is much better
        
    .qp.go[500;500] .qp.point[cells; `date; `dest]
          .qp.s.aes   [`fill; `duration]
        , .qp.s.scale [`fill; .gg.scale.colour.gradient[.gg.colour.FireBrick; .gg.colour.SteelBlue] ];
        
    // More mappings can be joined together
        
    .qp.go[500;500] .qp.point[cells; `date; `dest]
          .qp.s.aes   [`fill; `duration]
        , .qp.s.scale [`fill; .gg.scale.colour.gradient[.gg.colour.FireBrick; .gg.colour.SteelBlue] ]
        , .qp.s.aes   [`alpha; `duration]
        , .qp.s.scale [`alpha; .gg.scale.alpha[50; 255] ];
        
    // And more...
        
    .qp.go[500;500] .qp.point[cells; `date; `dest]
          .qp.s.aes   [`fill; `duration]
        , .qp.s.scale [`fill; .gg.scale.colour.gradient[.gg.colour.FireBrick; .gg.colour.SteelBlue] ]
        , .qp.s.aes   [`alpha; `duration]
        , .qp.s.scale [`alpha; .gg.scale.alpha[50; 255] ]
        , .qp.s.aes   [`size; `duration]
        , .qp.s.scale [`size; .gg.scale.circle.area[1; 20] ];
        
```

Static attributes are assigned using a `.qp.s.geom[]` setting. The static attributes that can be 
assigned are determined by the particular geometry. Individual geometry information is available
in the *Analyst Function Reference* under *Help*.

```q
        
    // Set the size and fill colour of a point geometry
        
    .qp.go[500;500] .qp.point[cells; `date; `dest]
        .qp.s.geom[`fill`size!(.gg.colour.FireBrick; 0.5)]
        
    // In general, `fill refers to fill colour and `colour refers to stroke colour
        
    .qp.go[500;500] .qp.point[cells; `date; `dest]
        .qp.s.geom[`fill`colour`size!(.gg.colour.Gold; .gg.colour.Black; 2)]
        
    // Alpha (opacity) only applies to the fill colour
    
    .qp.go[500;500] .qp.point[cells; `date; `dest]
        .qp.s.geom[`alpha`colour`size!(0x00; .gg.colour.Black; 5)]
        
```