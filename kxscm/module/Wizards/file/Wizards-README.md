Wizards
=======

When saving an import configuration, a function is also
saved as in below. Executing the function returns an
instance of `.im.io` with the source type/location and
import schema set.


```q

    CellsDirty[]
    
```


This `.im.io` instance can be used in conjunction with 
Transforms functions to redefine source nodes.


```q

    CellData[enlist[`cells_dirty]!enlist CellsDirty[]; ::]
    
```


This swaps out the named source node with the information we
have provided. This way, the source type or location can be
set independently of the UI.

The import configuration can be updated with a different path
while keeping the schema definition as defined in the importer.


```q

    {
        CellData[enlist[`cells_dirty]!enlist .im.io.with.target[x] CellsDirty[]; ::]
        } each `:cells_dirty.csv`:cells_dirty.csv
        
```