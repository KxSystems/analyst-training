## Themes and Titles


Prebuilt themes customize the look and feel of a plot.

```q

    .qp.go[500;300] .qp.histogram[subset; `signal; ::];
    
    // No theme definition is the same as using the default theme
    
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.default ]
        .qp.histogram[subset; `signal; ::];
        
    // The theme can be changed to one of the packaged themes, such as clean...
        
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.clean ]
        .qp.histogram[subset; `signal; ::];
        
    // Or dark...
        
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.dark ]
        .qp.histogram[subset; `signal; ::];

```

Any plot or subplot can be given a title.

```q
        
    .qp.go[500;300] 
        .qp.theme[ .gg.theme.dark ]
        .qp.title["Histogram of signal"]
        .qp.histogram[subset; `signal; ::];
        
    // A theme declaration only applies to the subplot it is applied to    
        
    .qp.go[500;300] 
        .qp.title["Histogram of signal"]
        .qp.theme[ .gg.theme.dark ]
        .qp.histogram[subset; `signal; ::];
        
```