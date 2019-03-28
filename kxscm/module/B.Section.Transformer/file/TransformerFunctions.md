# Running a Transform


First, delete the table from memory, and note that it is really gone.

```q

    delete ... from `.;
    tables[];
    
    // `symbol$()

```

Each transform is saved as a function which takes inputs and outputs. If
called with generic null `(::)`, the defaults as specified in the Transformer
UI are used. 

The return value will be a table of nodes and generated errors. If there
are no entries in the table, everything ran without error.

```q

    
    // name type| error
    // ---------| -----

```

Note now that the cells table has been created in memory.

```q
    
    tables[]
    
    // ,`cells

```

Display the function to read possible formats for inputs and outputs.

```q
    
    
```

For example,

```q

    // Pointing an input to a new csv
    
    // Pointing an input to a new IO configuration (including schema)

```