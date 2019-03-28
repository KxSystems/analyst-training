## Advanced Settings


All plot-level settings exist under `.qp.s`. Some useful settings that have not
yet been discussed are introduced here.

```q

    // Grouping can split categories into separate subplots
    
    .qp.go[700;400] .qp.area[select count i by date.date, tower from cells; `date; `x; ::];
    
    
    .qp.go[700;400] .qp.area[select count i by date.date, tower from cells; `date; `x]
          .qp.s.aes[`group; `tower]
        , .qp.s.aes[`fill; `tower]
        , .qp.s.scale[`fill; .gg.scale.colour.cat20];
        
    // When grouping, many geometries provide the ability to accommodate the groups by
    // stacking or dodging (bars, area, etc)
    
    .qp.go[700;400] .qp.area[select count i by date.date, tower from cells; `date; `x]
          .qp.s.aes[`group; `tower]
        , .qp.s.aes[`fill; `tower]
        , .qp.s.scale[`fill; .gg.scale.colour.cat20]
        , .qp.s.geom[enlist[`position]!enlist `stack];

    // Any frame can be converted to polar coordinates to produce new plots
              
    .qp.go[700;400] .qp.hbar[select count i by tower from cells; `x; `tower]
          .qp.s.scale[`y; .gg.scale.categorical[]];
    
    // ... by just choosing polar coordinates
    
    .qp.go[700;400] .qp.hbar[select count i by tower from cells; `x; `tower]
          .qp.s.scale[`y; .gg.scale.categorical[]]
        , .qp.s.coord[.gg.coords.polar];
        
    // ... when doing this, keeping the frame aspect ratio as a square is a good idea
        
    .qp.go[700;400] 
        .qp.theme[enlist[`aspect_ratio]!enlist `square]
        .qp.bar[select count i by tower from cells; `tower; `x]
             .qp.s.coord[.gg.coords.polar];
            
    // With a bit of cleverness, it is possible to create standard charts such as pie charts
            
    .qp.go[700;400] 
        .qp.theme[enlist[`aspect_ratio]!enlist `square]
        .qp.bar[select y:0, count i by tower from cells; `y; `x]
              .qp.s.coord[.gg.coords.polar]
            , .qp.s.geom[`size`position!(1000; `stack)]
            , .qp.s.aes[`group; `tower]
            , .qp.s.aes[`fill; `tower]
            , .qp.s.scale[`fill; .gg.scale.colour.cat10]
            , .qp.s.scale[`y; .gg.scale.extend[0b] .gg.scale.linear];
            
    // But we are not *limited* to only pies 
            
    .qp.go[700;400] 
        .qp.theme[enlist[`aspect_ratio]!enlist `square]
        .qp.hbar[select y:0, count i by tower from cells; `x; `tower]
              .qp.s.coord[.gg.coords.polar]
            , .qp.s.aes[`fill; `tower]
            , .qp.s.scale[`fill; .gg.scale.colour.cat10];
          
```

In addition to modifying the visual to identify patterns, settings can
be used to clean up a visual for production or consumption.

```q

    // A default plot with no settings applied

    .qp.go[700;400] .qp.point[cells; `date; `dest; ::];
    
    // Labels can be cleaned up for consumption (adding units is a good idea)
    
    .qp.go[700;400] .qp.point[cells; `date; `dest]
        .qp.s.labels[`x`y!("Date"; "Destination ID")];
        
    // Often, layers will be stacked with a different colour marking each layer
    // as in the below example
    
    .qp.go[700;400] .qp.stack (
        .qp.point[cells; `date; `dest]
              .qp.s.geom[`fill`size!(.gg.colour.FireBrick; 1)];
        .qp.point[cells; `date; `source]
              .qp.s.geom[`fill`size!(.gg.colour.SteelBlue; 1)]);
            
    // The layers can be made explicit by adding a manual legend indicating
    // what the colours represent
            
    .qp.go[700;400] .qp.stack (
        .qp.point[cells; `date; `dest]
              .qp.s.geom[`fill`size!(.gg.colour.FireBrick; 1)]
            , .qp.s.legend["Origin"; `dest`source!.gg.colour`FireBrick`SteelBlue];
        .qp.point[cells; `date; `source]
              .qp.s.geom[`fill`size!(.gg.colour.SteelBlue; 1)]);

```

Other settings have already been discussed in the Basic sections, or will
be introduced in later sections as follows:

- `link`, `primary`, and `secondary` will be introduced in Advanced/Composing
- `stat` will be introduced in Advanced/StatisticalTransforms
- `theme` will be introduced in Advanced/Themes
