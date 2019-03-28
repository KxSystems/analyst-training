## Customizing

Aesthetic scales in the Visual Inspector can be overridden by providing 
a Grammar of Graphics scale. For example, to override the fill scale gradient:


```q

    // Set the opacity to start very transparent
    .visgg.setScale[`alpha; .gg.scale.alpha . 5 255];
    
    // Set the fill gradient to compose a power scale
    .visgg.setScale[`fill; 
        .gg.scale.compose[
            .gg.scale.colour.gradient . .gg.colour`Orange`Purple;
            .gg.scale.power 0.5]]; 
    
```

Custom scales can be reset with:

```q

    .visgg.resetScales[]

```