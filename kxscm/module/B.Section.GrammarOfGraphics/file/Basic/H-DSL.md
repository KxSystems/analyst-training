## Dedicated Visualization Language


A dedicated language exists for specifying visuals for users who do not 
wich to learn q. The dedicated language maps one to one with the Grammar
of Graphics library. Most things can be done in the dedicated language
except for advanced features that require a full programming language.

All of the examples below must be run within a special editor. Any file 
ending in .gg will work correctly. A file called `DSL.gg` is included for use.
Copy and paste the following examples into `DSL.gg` and press the `play` arrow 
button.


```gg

    go 500 500
        point cells date dest
        
```

In certain instances, q values need to be referenced (colours, numbers, etc). In
these cases, a q expression surrounded by `<<` and `>>` will result in the value
expressed.

```gg

    go 500 500
        point cells date dest
            geom size << 1 >> fill << .gg.colour.FireBrick >>

```

Rather than referring to a table in particular, the table can be abstracted so that
flipping between tables and reusing the DSL script is easier. In this case, a UI
element will appear to choose a table from the kdb+ process to use for the parameter.
All instances of the parameter will map to the same table.

```gg

    go 500 500
        point param(cells) date dest

```

Stacks, titles, and themes work the same as in the underlying library, with similar 
syntax.

```gg

    go 500 500
    
        theme clean
        
        title "My Plot"
        
        stack {
            point param(cells) date dest
                geom fill << .gg.colour.Gold >>
            point param(cells) date source
                geom fill << .gg.colour.FireBrick >>
        }

```

Queries can be run inline as data sources within the DSL

```gg

    go 500 500
        stack {
            point << select from cells where tower = 20 >> date dest
            vline << 2006.06.08D >>
                geom fill << .gg.colour.SteelBlue >>
        }
        
```