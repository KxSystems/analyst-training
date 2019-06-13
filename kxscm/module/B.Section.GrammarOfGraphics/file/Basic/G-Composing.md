## Composing


### Stacking

A plot is defined by frames and layers. A frame consists of one or more layers plotted
on a single pair of axes. Each layer is defined by a single geometry. Layers are composed
into a single frame by *stacking* them together.

```q
summary : select
        minDuration:    min signal,
        maxDuration:    max signal,
        avgDuration:    avg signal,
        maxLabel:       max signal,
        avgLabel:       avg signal,
        sensorLabel:    first sensor
    by sensor from subset;

// Any number of layers can be stacked together
.qp.go[500;500]
    .qp.stack (
        .qp.interval[summary; `sensor; `minDuration; `maxDuration; ::];
        .qp.point[summary; `sensor; `avgDuration; ::]);

// Layers within a stack can be arbitrarily customized 
.qp.go[500;500]
    .qp.stack (
        .qp.interval[summary; `sensor; `minDuration; `maxDuration]
            .qp.s.geom[`fill`colour!.gg.colour`Grey`Black];
        .qp.point[summary; `sensor; `avgDuration; ::]);
        
// Text geometries are a good way of annotating plot      
.qp.go[500;500]
    .qp.stack (
        .qp.interval[summary; `sensor; `minDuration; `maxDuration]
            .qp.s.geom[`fill`colour!.gg.colour`Grey`Black];
        .qp.point[summary; `sensor; `avgDuration; ::];
        .qp.text[summary; `sensor; `maxLabel; `sensor]
            .qp.s.textalign[`middle] ,
            .qp.s.geom[``offsety!(::;-10)]);
       
// By stacking multiple layers, custom plots can be expressed     
.qp.go[500;500]
    .qp.stack (
        .qp.interval[summary; `sensor; `minDuration; `maxDuration]
              .qp.s.geom[`fill`colour!.gg.colour`Grey`Black];
        .qp.interval[summary; `sensor; `avgDuration; `avgDuration]
              .qp.s.geom[enlist[`colour]!enlist .gg.colour.Gold];
        .qp.text[summary; `sensor; `maxLabel; `sensor]
              .qp.s.textalign[`middle] ,
            .qp.s.geom[``offsety!(::;-10)];
        .qp.text[summary; `sensorLabel; `avgLabel; `avgDuration]
              .qp.s.textalign[`left] ,
              .qp.s.geom[`angle`size`offsety`fill!(-90; 8; -10; `white)]);
            
// The boxplot geometry is itself a stack of several layers          
.qp.go[500;500] .qp.boxplot[subset; `sensor; `signal; ::];

```

### Arranging

Beyond stacking, frames can be arranged to create visual summaries.

```q
// Horizontal arrangements
.qp.go[500;500] .qp.horizontal (
    .qp.point[subset; `time; `signal; ::];
    .qp.point[subset; `time; `ma; ::]);
    
// Vertical arrangements
.qp.go[500;500] .qp.vertical (
    .qp.point[subset; `time; `signal; ::];
    .qp.point[subset; `time; `ma; ::]);
    
// Horizontal or vertical arrangements can be weighted  
.qp.go[1000;500] .qp.layout[`hori_w; 2 1] (
    .qp.point[subset; `time; `signal; ::];
    .qp.point[subset; `time; `ma; ::]);
    
.qp.go[1000;500] .qp.layout[`vert_w; 2 1] (
    .qp.point[subset; `time; `signal; ::];
    .qp.point[subset; `time; `ma; ::]);
    
// ... or nested 
.qp.go[500;500] .qp.vertical (
    .qp.title["Destinations"] .qp.point[subset; `time; `signal; ::];
    .qp.horizontal (
        .qp.point[subset; `time; `ma; ::];
        .qp.histogram[subset; `signal; ::]));
        
// Any number of plots can be arranged in a grid 
.qp.go[800;500]
    .qp.theme[.gg.theme.clean]
    .qp.title["Distributions of major columns"]
    .qp.grid[3 0N] (
        .qp.histogram[subset; `time; ::];
        .qp.histogram[subset; `ma; ::];
        .qp.histogram[subset; `signal; ::];
        .qp.histogram[subset; `sensor; ::];
        .qp.histogram[subset; `active; ::]);

```