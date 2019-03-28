## Advanced Composing

### Splitting

Stacking has been introduced in the Basic instructions. Splitting is another way
of composing layers into a single frame. This splits two frames into a single frame,
both using separate y axes.

```q

    .qp.go[500;300] .qp.split (
        .qp.histogram[cells; `date]
              .qp.s.geom[`alpha`fill!(0x80; .gg.colour.SteelBlue)]
            , .qp.s.binx[`c;50;0];
        .qp.point[cells; `date; `dest]
              .qp.s.geom[`alpha`size`fill!(0x80; 1; .gg.colour.FireBrick)]);

```

### Dependencies

Composed plots can be dependent on one another in two ways.

First, independent frames can rely on one another by `linking` to the same identifier.

In the example below, zoom into either plot and notice the other updates to match.

```q

    .qp.go[600;500] .qp.vertical (
        .qp.histogram[cells; `duration]
            .qp.s.link`myID;
        .qp.point[cells; `date; `dest]
            .qp.s.link`myID);

```

Second, within the same frame, a primary plot can share its data with any number
of secondary plots. This way, whenever the primary plot is zoomed into, 
the secondary plots show the same data. This can be useful to force some
layers to use the same zoom region, despite being a different geometry.
For example, in the example below, the histogram uses a 1D zoom region
on the x axis, and the point would use a 2D region if it had not been
marked as secondary to the histogram.

```q

    .qp.go[500;300] .qp.stack (
        .qp.histogram[cells; `date]
              .qp.s.geom[`alpha`fill!(0x80; .gg.colour.SteelBlue)]
            , .qp.s.binx[`c;50;0]
            , .qp.s.primary`myID;
        .qp.point[cells; `date; `dest]
              .qp.s.geom[`alpha`size`fill!(0x80; 1; .gg.colour.FireBrick)]
            , .qp.s.secondary`myID);
              
```