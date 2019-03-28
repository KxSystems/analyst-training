## Visual Functions


Saved Visual Inspections also save as executable functions. If a saved VI
contains one of the Grammar Of Graphics powered visuals, then running the
function will produce the specification for the visual.

```q

    // Running with generic null uses the query defined in the UI

    D_IsolatedScatterInteraction[]
    
    
    // The result can be displayed in Analyst by passing to .qp.go
    
    .qp.go[500;500] D_IsolatedScatterInteraction[]
    
    
    // Custom data can be given to the function to overwrite the query in the UI
    
    .qp.go[500;500] D_IsolatedScatterInteraction select from cells where tower = 1
    
```


Saved visual functions can be used directly from Dashboards for Kx by connecting
to the process and setting the Data Source to the following


```q

    // Note - commented out since running this creates a cache entry. Only run
    // from within Dashboards for Kx

    / .gg.dash.go D_IsolatedScatterInteraction[]

```