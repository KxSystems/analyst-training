## Advanced Settings


All plot-level settings exist under `.qp.s`. Some useful settings that have not
yet been discussed are introduced here.

```q

// Grouping can split categories into separate subplots

.qp.go[700;400] .qp.area[subset; `time; `signal; ::];


.qp.go[700;400] .qp.area[subset; `time; `signal]
      .qp.s.aes[`group`fill; `sensor`sensor]
    , .qp.s.scale[`fill; .gg.scale.colour.cat20];
    
// When grouping, many geometries provide the ability to accommodate the groups by
// stacking or dodging (bars, area, etc)

.qp.go[700;400] .qp.area[subset; `time; `signal]
      .qp.s.aes[`group`fill; `sensor`sensor]
    , .qp.s.scale[`fill; .gg.scale.colour.cat20]
    , .qp.s.geom[enlist[`position]!enlist `stack];

// Any frame can be converted to polar coordinates to produce new plots
          
.qp.go[700;400] .qp.point[subset; `signal; `time; ]
      .qp.s.aes[`group`fill; `sensor`sensor]
    , .qp.s.scale[`fill; .gg.scale.colour.cat20];

// ... by just choosing polar coordinates

.qp.go[700;400] .qp.point[subset; `signal; `time; ]
      .qp.s.aes[`group`fill; `sensor`sensor]
    , .qp.s.scale[`fill; .gg.scale.colour.cat20]
    , .qp.s.coord[.gg.coords.polar];
    
// ... when doing this, keeping the frame aspect ratio as a square is a good idea
    
.qp.go[700;400] 
    .qp.theme[enlist[`aspect_ratio]!enlist `square]
    .qp.point[subset; `signal; `time; ]
          .qp.s.aes[`group`fill; `sensor`sensor]
        , .qp.s.scale[`fill; .gg.scale.colour.cat20]
        , .qp.s.coord[.gg.coords.polar];
        
// With a bit of cleverness, it is possible to create standard charts such as pie charts
        
.qp.go[700;400] 
    .qp.theme[enlist[`aspect_ratio]!enlist `square]
    .qp.bar[select y:0, count i by sensor from subset; `y; `x]
          .qp.s.coord[.gg.coords.polar]
        , .qp.s.geom[`size`position!(1000; `stack)]
        , .qp.s.aes[`group; `sensor]
        , .qp.s.aes[`fill; `sensor]
        , .qp.s.scale[`fill; .gg.scale.colour.cat10]
        , .qp.s.scale[`y; .gg.scale.extend[0b] .gg.scale.limits[0 0N] .gg.scale.linear];
        
// But we are not *limited* to only pies 
        
.qp.go[700;400] 
    .qp.theme[enlist[`aspect_ratio]!enlist `square]
    .qp.hbar[select y:0, avg signal by sensor from subset; `signal; `sensor]
          .qp.s.coord[.gg.coords.polar]
        , .qp.s.aes[`fill; `sensor]
        , .qp.s.scale[`fill; .gg.scale.colour.cat10];
      
```

Other settings have already been discussed in the Basic sections, or will
be introduced in later sections as follows:

- `link`, `primary`, and `secondary` will be introduced in Advanced/Composing
- `stat` will be introduced in Advanced/StatisticalTransforms
- `theme` will be introduced in Advanced/Themes
