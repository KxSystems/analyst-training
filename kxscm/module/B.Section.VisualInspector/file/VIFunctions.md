## Visual Functions


Saved Visual Inspections also save as executable functions. If a saved VI
contains one of the Grammar Of Graphics powered visuals, then running the
function will produce the specification for the visual.

```q
// Running with generic null uses the query defined in the UI
ReadingsOverTime[::];

// The result can be displayed in Analyst by passing to .qp.go
.qp.go[800;300] ReadingsOverTime[::];

// Custom data can be given to the function to overwrite the query in the UI
.qp.go[800;300] ReadingsByMachine select from signals where sensor = `temp_a;

```