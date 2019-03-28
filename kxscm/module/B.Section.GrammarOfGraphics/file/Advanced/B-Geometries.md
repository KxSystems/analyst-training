## Geometries

There are a few geometries that deserve to be in the advanced section.

### Straight Lines

Straight lines are useful as guides within a plot. They take a single point,
but are required to be stacked with another layer.

```q

    .qp.go[500;300] .qp.stack (
        .qp.hline[.8;  .qp.s.geom[enlist[`fill]!enlist .gg.colour.Gold]];
        .qp.hline[.5;  .qp.s.geom[enlist[`fill]!enlist .gg.colour.Gold]];
        .qp.vline[0D00:01:11.999; .qp.s.geom[`size`fill!(3; .gg.colour.FireBrick)]];
        .qp.point[subset; `time; `signal]
            .qp.s.geom[`size`alpha!(1; 0xf0)])

```

### Polygons

Polygons can also be used to draw any custom shape. See the examples in the 
*Function Reference* for .qp.polygon.