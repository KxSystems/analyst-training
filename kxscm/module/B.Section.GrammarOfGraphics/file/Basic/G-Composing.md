## Composing


### Stacking

A plot is defined by frames and layers. A frame consists of one or more layers plotted
on a single pair of axes. Each layer is defined by a single geometry. Layers are composed
into a single frame by *stacking* them together.

```q

    summary : select
            minDuration :   min duration,
            maxDuration:    max duration,
            avgDuration:    avg duration,
            maxLabel:       50 + max duration,
            avgLabel:       50 + avg duration,
            towerLabel:     0.25 + first tower
        by tower from cells;

    // Any number of layers can be stacked together
    
    .qp.go[500;500]
        .qp.stack (
            .qp.interval[summary; `tower; `minDuration; `maxDuration; ::];
            .qp.point[summary; `tower; `avgDuration; ::]);
    
    // Layers within a stack can be arbitrarily customized
        
    .qp.go[500;500]
        .qp.stack (
            .qp.interval[summary; `tower; `minDuration; `maxDuration]
                .qp.s.geom[`fill`colour!.gg.colour`Grey`Black];
            .qp.point[summary; `tower; `avgDuration; ::]);
            
    // Text geometries are a good way of annotating plot
            
    .qp.go[500;500]
        .qp.stack (
            .qp.interval[summary; `tower; `minDuration; `maxDuration]
                .qp.s.geom[`fill`colour!.gg.colour`Grey`Black];
            .qp.point[summary; `tower; `avgDuration; ::];
            .qp.text[summary; `tower; `maxLabel; `tower]
                .qp.s.textalign[`middle]);
           
    // By stacking multiple layers, custom plots can be expressed
           
    .qp.go[500;500]
        .qp.stack (
            .qp.interval[summary; `tower; `minDuration; `maxDuration]
                  .qp.s.geom[`fill`colour!.gg.colour`Grey`Black];
            .qp.interval[summary; `tower; `avgDuration; `avgDuration]
                  .qp.s.geom[enlist[`colour]!enlist .gg.colour.Gold];
            .qp.text[summary; `tower; `maxLabel; `tower]
                  .qp.s.textalign[`middle];
            .qp.text[summary; `towerLabel; `avgLabel; `avgDuration]
                  .qp.s.textalign[`left]
                , .qp.s.geom[`angle`size`fill!(-90; 8; .gg.colour.White)]);
                
    // The boxplot geometry is itself a stack of several layers
                
    .qp.go[500;500] .qp.boxplot[cells; `tower; `duration; ::];

```

### Arranging

Beyond stacking, frames can be arranged to create visual summaries.

```q

    // Horizontal arrangements

    .qp.go[500;500] .qp.horizontal (
        .qp.point[cells; `date; `dest; ::];
        .qp.point[cells; `date; `source; ::]);
        
    // Vertical arrangements
        
    .qp.go[500;500] .qp.vertical (
        .qp.point[cells; `date; `dest; ::];
        .qp.point[cells; `date; `source; ::]);
        
    // Horizontal or vertical arrangements can be weighted
        
    .qp.go[1000;500] .qp.layout[`hori_w; 2 1] (
        .qp.point[cells; `date; `dest; ::];
        .qp.point[cells; `date; `source; ::]);
        
    .qp.go[1000;500] .qp.layout[`vert_w; 2 1] (
        .qp.point[cells; `date; `dest; ::];
        .qp.point[cells; `date; `source; ::]);
        
    // ... or nested
        
    .qp.go[500;500] .qp.vertical (
        .qp.title["Destinations"] .qp.point[cells; `date; `dest; ::];
        .qp.horizontal (
            .qp.point[cells; `date; `source; ::];
            .qp.histogram[cells; `duration; ::]));
            
    // Any number of plots can be arranged in a grid
        
    .qp.go[500;500]
        .qp.theme[.gg.theme.clean]
        .qp.title["Distributions of major columns"]
        .qp.grid[3 0N] (
            .qp.histogram[cells; `date; ::];
            .qp.histogram[cells; `source; ::];
            .qp.histogram[cells; `dest; ::];
            .qp.histogram[cells; `tower; ::];
            .qp.histogram[cells; `duration; ::]);

```