### Quick Plot


Note, `.qp.go` specifies a width and height for the plot specification.


```q
    cells: ([] date: 400?.z.d+til 10; source: 400?400; dest: 400?400; duration: 400?10)


    subset : select date, source, dest, duration from cells;
    
    // No specified columns plots an n*n plot matrix
    
    .qp.go[900;900] .qp.plot[subset; (); ::];
    
    // One column produces a histogram
    
    .qp.go[500;500] .qp.plot[cells; `duration; ::];
    
    // Two columns produces a plot determined by the type and count of the columns
    
    .qp.go[500;500] .qp.plot[cells; `date`dest; ::];
    
    // More than two columns produces a plot matrix of the specified columns
    
    .qp.go[500;500] .qp.plot[cells; `dest`duration; ::];

```
