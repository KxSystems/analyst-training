### Quick Plot


Note, `.qp.go` specifies a width and height for the plot specification.


```q

    // Generate some data
    data: sim.system[];
    
    count data;

    subset : 50000#data;
    
    // No specified columns plots an n*n plot matrix
    
    .qp.go[900;900] .qp.plot[`time`id _ subset; (); ::];
    
    // One column produces a histogram
    
    .qp.go[500;500] .qp.plot[data; `active; ::];
    
    // Two columns produces a plot determined by the type and count of the columns
    
    .qp.go[500;500] .qp.plot[data; `time`signal; ::];
    
    // More than two columns produces a plot matrix of the specified columns
    
    .qp.go[500;500] .qp.plot[data; `active`signal`ma; ::];

```
