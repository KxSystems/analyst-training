Table Importer
==============

When saving an import configuration, a function is also saved as in below.
Executing the function returns an instance of `.im.io` with the source 
type/location and import schema set.

To save an import configuration, open the table importer using
`Tools > Table Importer`. Select the import format of `CSV` and click `Browse`
on the file path to open the file browser. In the file browser, click the `WS`
button in the top toolbar to navigate to the workspace directory. Next,
select `A.Tutorial.Data` and choose the `pressure.csv` file. Your configuration
should look like the configuration below.


    Table Importer
    -------------------------------------------------------------------------------
                      Source Format: CSV - Comma Separated Value
                      
        File Path       : A.Tutorial.Data/pressure.csv
        Delimiter       : Comma ,
        Include Columns : ☑
        Lines to Skip   : 0
        Escape Newlines : ☐


With the file selected, the bottom region of the table importer will display a 
preview of the data. With the view option set to `Table`, a tabular view of the
data is presented. To see the underlying textual data, switch the view to `Text`.

Pressing `Next` takes you to the *Schema* tab where the column names and types
can be manipulated before importing. Here, we can to change the types for 
the columns or rename them.

Pressing `Next` takes you to the *Import* tab where a final action can be selected.
To save this import, click the `Save Configuration` button to bring up the module
selector. Select a module to save the configuration under and enter a name.
Now that the import is saved, we can use it as a data source. 

We can use saved imports as q functions. A configuration was already saved under
the `A.Tutorial.IO` module called `ImportTemperature`

    └── training
        └── A.Tutorial.IO
            └── ImportTemperature



```q
// To execute the import as it was defined saved, we can invoke .im.execute.
// This will return a symbolic name of the table that the result of this import was
// saved under.
.im.execute ImportTemperature;

// To import the content of the table directly, add an invocation to the configuration
temp: .im.execute ImportTemperature[];
```

