## Themes and Titles


Prebuilt themes customize the look and feel of a plot.

```q

    .qp.go[500;300] .qp.histogram[cells; `duration; ::];
    
    // No theme definition is the same as using the default theme
    
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.default ]
        .qp.histogram[cells; `duration; ::];
        
    // The theme can be changed to one of the packaged themes, such as clean...
        
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.clean ]
        .qp.histogram[cells; `duration; ::];
        
    // Or dark...
        
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.dark ]
        .qp.histogram[cells; `duration; ::];

```

Any plot or subplot can be given a title.

```q
        
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.dark ]
        .qp.title["Histogram of duration"]
        .qp.histogram[cells; `duration; ::];
        
    // A theme declaration only applies to the subplot it is applied to    
        
    .qp.go[500;300] 
        .qp.title["Histogram of duration"]
        .qp.theme[ .gg.theme.dark ]
        .qp.histogram[cells; `duration; ::];
        
```