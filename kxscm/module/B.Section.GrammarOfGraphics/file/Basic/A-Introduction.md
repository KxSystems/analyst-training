### Quick Plot

The most basic way to visualize data is to use the high-level `.qp.plot[...]`
API which takes a table, a list of columns to plot, and a dictionary 
of settings (or generic null).

First, generate some data that will be used for our plotting examples. Use
the sensor data from the tutorial walkthrough. For more information on this data,
see `A.Tutorial.Doc/walkthrough.md`.


```q
// Generate some data
sensors:  sim.system[];

count sensors;

// Take a 50,000 record subset 
subset: 50000#sensors;
```

Note, `.qp.go` specifies a width and height for the plot specification.

```q
// No specified columns plots an n*n plot matrix
.qp.go[900;900] .qp.plot[`time`id _ subset; (); ::];

// One column produces a histogram
.qp.go[500;500] .qp.plot[subset; `active; ::];

// Two columns produces a plot determined by the type and count of the columns
.qp.go[500;500] .qp.plot[subset; `time`signal; ::];

// More than two columns produces a plot matrix of the specified columns
.qp.go[500;500] .qp.plot[subset; `active`signal`ma; ::];
```
