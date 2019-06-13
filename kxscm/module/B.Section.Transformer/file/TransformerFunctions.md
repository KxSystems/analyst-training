# Running a Transform


First, delete the table from memory, and note that it is really gone.

```q
delete signals from `.;
`signals in tables[];
/=> 0b
```

Each transform is saved as a function which takes inputs and outputs. If
called with generic null `(::)`, the defaults as specified in the Transformer
UI are used. 

The return value will be a table of nodes and generated errors.

```q
ImportSensors[::;::];

/=> name              type  | error message
/=> ------------------------| -------------
/=> Graphic           gg    | 0     ""     
/=> aggregate-signals action| 0     ""     
/=> cleanup-pressure  action| 0     ""     
/=> cleanup-temp      action| 0     ""     
/=> cleanup-weight    action| 0     ""     
/=> filter-signals    action| 0     ""     
/=> pressure          source| 0     ""     
/=> pressure_temp     join  | 0     ""     
/=> signals           join  | 0     ""     
/=> signals           output| 0     ""     
/=> summarize         op    | 0     ""     
/=> summary           output| 0     ""     
/=> temp              source| 0     ""     
/=> weight            source| 0     ""     
```

Note now that the cells table has been created in memory.

```q
`signals in tables[]
/=> 1b
```

Display the function to read possible formats for inputs and outputs.

```q
// Replace the formatting characters and print the function to stdout
-1 "\n" sv ssr[;","; ""] each ssr[;"\""; ""] each 1 _ "\n" vs string ImportSensors;
/=> Usage
/=> 
/=>    Arguments:
/=>       - inputs:   (::) to use inputs from the UI
/=>                or a dictionary from node names to IO configurations
/=>                or a path to a new data source to use the schema set in the UI
/=>       - outputs:  (::) to use inputs from the UI
/=>                or a dictionary from node names to IO configurations
/=>                or a path to a new data source to use the schema set in the UI
/=>  
/=>    Examples:
/=>       dataflow[::; ::] // To use defaults defined via the UI
/=>  
/=>       dataflow[enlist[`srcnode]!enlist `:/path/t.csv; ::]
/=>          // To use default output and redefine the source node to be a CSV file
/=>  
/=>       dataflow[enlist[`srcnode]!enlist .im.io.with.target[`:/path/t.csv] .im.io.create`dsv; ::]
/=>          // To use default output and redefine the source node and reset the schema
/=>  
/=>       dataflow[::; enlist[`outnode]!enlist .im.io.with.target[`:/path/t2.csv] .im.io.create`dsv]
```

For example,

```q
// Example with explicit input and output locations
ImportSensors[
    `temp`pressure!(`:A.Tutorial.Data/temp.csv; `:A.Tutorial.Data/pressure.csv);
    
    // Output to a csv file called `signals.csv` - we need to change the output format
    // from a kdb+ table to a csv file by creating a new `.im.io` source descriptor 
    enlist[`signals]!enlist .im.io.with.target[`:signals_out.csv] .im.io.create `csv
    ];
    
/=> name              type  | error message
/=> ------------------------| -------------
/=> Graphic           gg    | 0     ""     
/=> aggregate-signals action| 0     ""     
/=> cleanup-pressure  action| 0     ""     
/=> cleanup-temp      action| 0     ""     
/=> cleanup-weight    action| 0     ""     
/=> filter-signals    action| 0     ""     
/=> pressure          source| 0     ""     
/=> pressure_temp     join  | 0     ""     
/=> signals           join  | 0     ""     
/=> signals           output| 0     ""     
/=> summarize         op    | 0     ""     
/=> summary           output| 0     ""     
/=> temp              source| 0     ""     
/=> weight            source| 0     ""   

```