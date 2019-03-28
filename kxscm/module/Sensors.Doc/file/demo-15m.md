Sensors Demo
============

This demonstration uses a simulated system of sensors on various machines in a hypothetical
environment. This demo will showcase how Analyst can be used by a data scientist or a developer
to perform some data ingest and ad-hoc analysis.

Data
-----

Let's start with some data. The data for this project was originally simulated and exported
to CSV format. The data can be found under `Sensors.Data` in three files, `temp.csv`,
`pressure.csv`, and `weight.csv`. 

```q
// Navigate to the workspace directory
go.ws[];

// Read a sample of the data to show its contents
contents: 10#read0 `:Sensors.Data/temp.csv;

// Parse that data into a table with string contents
sample: (sum[1b,","=first contents]#"*"; enlist csv) 0: contents;
```

Table Importer
--------------

To import this sensors data, we will load the data from a CSV file. First open 
the *Table Importer* from the `Tools` menu. We will configure the importer to be the 
CSV file format with the temperature data file.

        
    Table Importer
    -------------------------------------------------------------------------------
                      Source Format: CSV - Comma Separated Value
                      
        File Path       : Sensors.Data/temp.csv
        Delimiter       : Comma ,
        Include Columns : ☑
        Lines to Skip   : 0
        Escape Newlines : ☐
        
With the file selected, the bottom region of the table importer will display a 
preview of the data. With the view option set to `Table`, a tabular view of the
data is presented. To see the underlying textual data, switch the view to `Text`.

Pressing `Next` takes you to the *Schema* tab where the column names and types
can be manipulated before importing. Here, we will want to change the types for 
the `machine` and `sensor` columns to `Symbol`. The `signal`, and `active`
columns should be `float`. All of the remaining columns should be set to `Long` .
We perform processing on it in the *Table Transformer*.

Pressing `Next` takes you to the *Import* tab where a final action can be selected.
We could directly import the table but here we want to fix messy columns. To do this,
select `Transform` in the *Import Type* select. Finally, pressing `Finish` will 
launch into the *Table Transformer*.

Table Transformer
-----------------

Using the transformer, we can do more complex data transformations before importing
the data. The transformer works on a sample of the data to build up a workflow of
actions that will transform the data into a usable format. Once the transform
has been built, it can be executed on the current data or saved into a compiled
kdb+ function and parameterized.

For this transform we will add an *Action* node to the transform add a moving 
column. First, right-click the node and select `New > Action`. Now right click the 
`signal` column and select `Add Column...`.
and add the parse expression.


    Add Column
    ------------------------------------------------
           New Column             Value 
              ma               4 mavg signal
     
After pressing `Ok` the add column action will appear in the action list for the
given node. Finally, we can add an output node to the workflow to capture the data. 
Right-click the action node and select `New > Output`. This will open the *Table Exporter* 
to configure the output node. For now, we will import this data into our current process.
To do this, select the `KDB` format with the table type of `Memory` and press `Finish`
       
    Table Exporter
    -------------------------------------------------------------------------------
                         Select: KDB - kdb+ Database
                      
        Table Format    : Memory
        Table Name      : signals
        If Table Exists : ☑ Overwrite  ☐ Append
        
The transformation can now be run using `Transform > Run` or alternatively it can be
saved and executed like a function.

### ImportSensors

To save time, a more complete transformation has already been provided in 
`Sensors.IO/ImportSensors`. Before opening this transform, ensure that the 
process is in the workspace directory by running `go.ws[]`. 

This transform takes three types of sensor data from csv files, reads the contents, joins 
them together, summarizes and writes the data to tables in memory. The table below details 
the different nodes in this transformation.

| Node                | Type     | Description                                                 |
| -----               | ----     | -----------                                                 |
| `temp`              | Source   | Temperature sensor data in a CSV file                       |
| `pressure`          | Source   | Pressure sensor data in a CSV file                          |
| `weight`            | Source   | Weight sensor data in a CSV file                            |
| `cleanup-temp`      | Action   | Add some features to the temperature table                  |
| `cleanup-pressure`  | Action   | Add some features to the pressure table                     |
| `cleanup-weight`    | Action   | Add some features to the weight table                       |
| `pressure_temp`     | Join     | Performs an insert on the pressure and temperature tables   |
| `signals`           | Join     | Performs an insert on the joined table using weight sensors |
| `aggregate-signals` | Action   | Adds some extra aggregations across all sensors             |
| `filter-signals`    | Action   | Filters out signals to a single machine sensor combination  |
| `summarize`         | Function | Performs a custom summary aggregation                       |
| `Graphic`           | Graphic  | Displays a filtered signal reading plot                     | 
| `summary`           | Output   | An output table of the summarized signals                   | 
| `signals`           | Output   | An output table of sensor signal data                       |


Select the `Graphic` node to display the graphs in the transformation. Next select
`Transform > Run` to perform the importer. The transform will take ~30 seconds to ingest
the data on a reasonable laptop. The graphic that has been selected is showing a sensor signal
plot of one sensor.

Alternatively, the transformation can be run as a function by invoking the transform.

```q
go.ws[];

// In a transformation, the first argument is for the inputs to the transform 
// and the last argument is for the outputs. Providing null for both uses the defaults
// that were configured in the UI. A dictionary can be provided for each input or output
// that maps the name of the node in the UI to a new input or output configuration.
// This import takes about 35-40 seconds on a reasonable laptop and far less on a server.
ImportSensors[::;::]
```

Visual Inspector
----------------

Now that the data has been imported, we can start exploring it. We can use the 
*Visual Inspector* to visualize and tumble the data. We can use the *Process View* to see
which tables were imported. Select the `Process` tab in the search pane view to see 
functions and data in our process. Under the global tables tab, we should find the tables
that were just imported.


    └── . (Global)
        └── Tables
            ├── sensors
            ├── signals
            └── summary

Right-click on the `sensors` table and select `Inspect`. Alternatively, right-click
the following line and choose `Inspect` or press CTRL+I (CMD+I on osx).

```q
sensors
```

To get a sense of the distribution of the sensors across their machines, we can plot
a histogram of signal values. To add another dimension to the data, set the `Fill Colour`
to be the average active rate. 

    Visual Inspector
    -------------------------------------------------------------------------------
     query: sensors                                                              
    -------------------------------------------------------------------------------
     Chart Type: Horiz Histogram               | X Axis Column    : machine       
                                               | ...                            
                                               | ✓ Enable Fill Colour  
                                               | Fill Aggregation : Average   
                                               | Fill Column      : active


Now that we understand the distribution of the activity per sensor, we can look at the
average sensor readings over time. A visualization has been saved in 
`Sensors.Plots/ReadingsOverTime`. Double-click the plot to view the readings over time.

    └── demo-sensors
        └── Sensors.Plots
            └── ReadingsOverTime

```q
// View the number of sensor readings in the dataset
count sensors
```


Analysis
--------

Let's turn our focus to the individual sensors readings. Let's look at all the distinct
sensor readings over time. Double-click the `SignalBySensor` plot in `Sensors.Plots` to
view all of the discrete signals. This will be a messy plot but will allow us to visualize
the entire dataset.


    └── demo-sensors
        └── Sensors.Plots
            └── SignalBySensor



In the visual, one signal seems to go above the others. Click on it brings up a tooltip
that indicates the machine and signal as the `id`, that seem to be affected. Let's take 
a closer look at this signal. We can use quick plotting library that included with the
*Grammar of Graphics* to plot the signal for this sensor.

```q
// Select only sensor that is failing. Replace the query keys with the ones from 
// the tooltip in the visual inspector.
failing: select from sensors where machine=`mach_g, sensor=`pressure_a;
.qp.go[800; 500] plotSignal failing
```

This likely signals to us that we need to investigate this sensor further. There may be a 
faulty sensor or an actual issue with the machine itself. We would have expected to see a 
complete signal produced from this sensor. Ideally, something more like the following.
 
```q
// Select the first machine, sensor combo
firstId: select from sensors where id = first id;

// Plot the signal
.qp.go[800;500] plotSignal firstId
```

To clean this plot up and see more of the underlying patterns, we can use a simple smoothing
function to reduce the noise in the data. Here we can use the `smoothReadings` function to help
reduce the noise in the plot.

```q
smooth: smoothReadings[5] firstId
```

Here we have encountered a `type` error. One of the arguments that we gave to the function
is not of the correct type. To debug this further, we can use the built in *Quick Debugger*.
Right-click the line and select `Quick Debugger`. This will open the debugger in a new tab
and will jump to the line that encountered the error.

Notice that in the second stack frame, there are two parameters, one called `factor` and one 
called `signals` but the filter statement is trying to use a value called `sensors`. We can see
that the bug then lies in the `filterReadings` function. Find the function in the workspace 
tree and double-click to open it. 

    └── demo-sensors
        └── Sensors.Analysis
            └── filterReadings

Inside of this function, we can see that the `sensors` value is being used but is not defined 
We should have known that this would not work since there is a linter icon in the left gutter 
of the editor. If we hover over the orange `•` icon in the gutter, we get a message about the
`factor` parameter not being used.

    UNUSED_PARAM: "factor"
      This parameter was declared then never used


Additionally, if we had run the tests for this function, it would have been clear 
that there was an issue. To see the failing test, right-click on the function editor
and select `Test`. This will show the test output in the console.

    2 of 2 tests failed

    Failed Tests : 2 
    feature filterReadings
        should filter out sensor readings
            expect sensor readings to be reduce by a factor of 5 
                Error: type
        property should filter readings of any table
            Counter Example: (1i;+`fibap`bmlpp!(08:29 02:09; "ab"))
            Error: type
                            
To fix this issue, we can use a previous working version of the function. The
function has been version in *git* so we can simply revert to a previous version.
Find the function in the workspace tree, right-click and select `Git > History`

In the function history dialog, select the previously `Published` version of the
function. In the preview area at the bottom, notice that the `sensors` is substituted
with `factor`. Once the working version is selected press `Revert` to get this version of 
the function. 

To confirm this is the working version of the function, run the tests again by 
right-clicking and selecting to `Test` again. If the correct version has been selected,
the tests will pass and the following will be printed in the console
    
    All 2 test passed

Now that the `filterReadings` function has be fixed and the tests have passed, we can continue
the analysis.

```q
smooth: smoothReadings[10] firstId;
.qp.go[800;500] plotSignal smooth;
```

Let's take a look at one last facet of the data. We can use the Grammar of Graphics to
express much more complex visualizations. For example, let's suppose we want to look at
all of the temperature sensors for a given machine in our system. To get a high level
comparison of all of these sensors, we can apply standard aggregations such as max, min,
mean, etc. We can take all of these aggregations and plot them using a parallel line
chart to represent each of the individual sensors. This gives us a high level comparison
of the performance of these sensors and illustrates the complex visuals that can be
generated from GG.

```q
// Select all temperature sensors
allTemp: select from sensors where machine = first machine, sensor like "temp*";

// Plot all temperature sensor values as an aggregated rollup in parallel coordinates
.qp.go[1000;400] plotParallel allTemp
```


Summary
-------

In this quick data analysis project, we took some simulated sensor data and imported it using
using the *Table Transformer*. We then performed some ad-hoc visualizations using Analyst's 
*Visual Inspector*. We then built some custom visualizations using the *Grammar of Graphics*. 

While performing our visualization on the sensors data, we identified a potential issue 
with one of the sensors in the system. We then created some custom visualization to investigate
this further.

And finally, we have taken the first 100 individual sensor signals by machine and plotted
them in a plot matrix in a single visual summary.

```q
// Select the first 100 sensors and filter the time dimension 1:100
first100: 100#value `id xgroup select from sensors where 0 = i mod 100;

// Theme for sensor grid
theme: `legend_use`axis_use_y`axis_use_x`title_fontsize`title_padding!(0b; 0b; 0b; 12; 12);

// Plot the first 100 sensors in a grid with 5 across by 20 down
.qp.go[1000;2000] 
    .qp.title["Sensor Signal by Machine"]
    .qp.theme[theme]
    .qp.grid[5 0N]
        {[sensor]
            .qp.title[" " sv string first each (sensor`machine;sensor`sensor)] 
                plotSignal flip sensor
            } each first100
            
```
