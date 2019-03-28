## Geometries

There are a few geometries that deserve to be in the advanced section.

### Straight Lines

Straight lines are useful as guides within a plot. They take a single point,
but are required to be stacked with another layer.

```q

    .qp.go[500;300] .qp.stack (
        .qp.hline[360;  .qp.s.geom[enlist[`fill]!enlist .gg.colour.Gold]];
        .qp.hline[309;  .qp.s.geom[enlist[`fill]!enlist .gg.colour.Gold]];
        .qp.vline[2006.06.08D00; .qp.s.geom[`size`fill!(3; .gg.colour.FireBrick)]];
        .qp.point[cells; `date; `dest]
            .qp.s.geom[`size`alpha!(1; 0xf0)])

```

### Polygons

Polygons take a *path* rather than a *point* for each record. This is a list of
x and y coordinates creating a single polygon per record.

```q

    // Try out .gg.h.geojson.polytable/linetable to parse a geojson file containing 
    // the map region
    california: .gg.h.geojson.polytable `$.ws.wsDir[],"/Data/counties.geojson";
    
    data: update r:2000?i from 2000?select raze lon, raze lat from california;
    
    .qp.go[500;500] 
    .qp.theme[.gg.theme.dark]
    
    // Style the canvas - inspect .gg.theme.default for options
    .qp.theme[``axis_use_x`axis_use_y`grid_style_x`grid_style_y!(::;0b;0b;`none;`none)]
    .qp.title["Example Polygon Map"]
    
    // Stack the geometries together
    .qp.stack (
       
        // The polygon is the base layer
        .qp.polygon[california; `lon; `lat]
              .qp.s.geom  [``fill`colour!(::;0x444444; 0x666666)]   // Optional themeing
            , .qp.s.scale [`x; .gg.scale.mercator 0b]               // Set the x,y scales to be mercator
            , .qp.s.scale [`y; .gg.scale.mercator 1b]; 
            
        // The *data* layer (can be any/multiple geometries - see .gg.cheat.sheet[])
        .qp.point[data; `lon; `lat]
              .qp.s.geom  [``size`fill!(::;1;.gg.colour.Yellow)]    // Optional themeing
            , .qp.s.aes   [`alpha; `r]                              // Optional map of aesthetics (see .gg.cheat.sheet[])
            , .qp.s.scale [`alpha; .gg.scale.alpha[50;255]])        //    and Help > Analyst Function Reference

```