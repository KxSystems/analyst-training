## Geometries


Beyond the basic `.qp` API, each geometry in the grammar of graphics is split into
a function. Some examples are below:

```q

    // Simple 2D point takes x and y
    
    .qp.go[500;500] .qp.point[subset; `time; `signal; ::];
    
    // Bar takes x and y
    
    .qp.go[500;500] .qp.bar[select count i by sensor from subset; `sensor; `x; ::];
    
    // Most geometries have a horizontal counterpart
    
    .qp.go[500;500] .qp.hbar[select count i by sensor from subset; `x; `sensor; ::];
    
    // Some geometries take more than just an (x,y) coordinate, such as (xmin, xmax, y)
    
    .qp.go[500;500] .qp.interval[select minimum:min signal, average:avg signal by sensor from subset; `sensor; `minimum; `average; ::];
    
    // All current geometries are listed in the *Analyst Function Reference* page (under *Help*) or using the cheat sheet
    
    .gg.cheat.sheet[];
    
```

Some geometry functions pair a basic geometry with a statistical transform. The parameters
of the transform functions can be modified (revisited later), and a transform function
can be added to any geometry to modify it's behaviour (also revisted later).


```q

    .qp.go[500;500] .qp.bar[select count i by sensor from subset; `sensor; `x; ::];
    
    // A histogram pairs a 1D binning transform with a bar geometry
    
    .qp.go[500;500] .qp.histogram[subset; `sensor; ::];
    
    // A heatmap pairs a tile geometry with a 2D binning transform
    
    .qp.go[500;500] .qp.heatmap[subset; `time; `signal; ::];
    
```