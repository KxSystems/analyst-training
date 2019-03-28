## Scales


Scales are used for governing mappings as in the previous section, as 
well as manipulating axes.


```q

    // Default scales
    
    .qp.go[500;500] .qp.point[subset; `time; `signal; ::];
    
    // Linear scales are used by default for numeric data
    
    .qp.go[500;500] .qp.point[subset; `time; `signal]
        .qp.s.scale[`y; .gg.scale.linear];
        
    // But log or power scales could be used instead
        
    .qp.go[500;500] .qp.point[subset; `time; `signal]
        .qp.s.scale[`y; .gg.scale.log];
        
    .qp.go[500;500] .qp.point[subset; `time; `signal]
        .qp.s.scale[`y; .gg.scale.power 2];
        
    // Limits can be set within or beyond the data to limit the range of view
        
    .qp.go[500;500] .qp.point[subset; `time; `signal]
        .qp.s.scale[`y; .gg.scale.limits[0 10] .gg.scale.linear];

    // Custom break points can be set

    .qp.go[500;500] .qp.point[subset; `time; `signal]
        .qp.s.scale[`y; .gg.scale.breaks[0 1 5 8 10] .gg.scale.limits[0 10] .gg.scale.linear];
        
    // Padding/axis extension can be set
        
    .qp.go[500;500] .qp.point[subset; `time; `signal]
        .qp.s.scale[`y; .gg.scale.extension[0.5] .gg.scale.breaks[0 1 5 8 10] .gg.scale.limits[0 10] .gg.scale.linear];
        
    // Both axes can be manipulated by joining the settings together
    
    .qp.go[500;500] .qp.point[subset; `sensor; `signal]
          .qp.s.scale[`y; .gg.scale.extension[0.5] .gg.scale.breaks[0 1 5 8 10] .gg.scale.limits[0 10] .gg.scale.linear]
        , .qp.s.scale[`x; .gg.scale.categorical[]];
        
    // Categorical scales can adjust the ordering of the axis by taking an ordering function
        
    .qp.go[500;500] .qp.point[subset; `sensor; `signal]
          .qp.s.scale[`y; .gg.scale.extension[0.5] .gg.scale.breaks[0 1 5 8 10] .gg.scale.limits[0 10] .gg.scale.linear]
        , .qp.s.scale[`x; .gg.scale.extension[0.5] .gg.scale.categorical desc];
        
```