Walkthrough
===========

This walkthrough uses a simulated system of sensors on various machines in a hypothetical
environment. We will use this data to showcase how this tool can be used by a data scientist
or a developer to perform data ingest and ad-hoc analysis.

Setup
-----

The data for this tutorial can be found in our workspace under the `A.Tutorial.Data` module.
When the process is started, its working directory is where the process was started or where
it was moved to. To be able to access this data, we need to move the process to the workspace
directory. Run the following line to move the the process to the workspace.

```q
system "cd ",getenv `AX_WORKSPACE;
```

Data
-----

Let's start with some data. The data for this project was originally simulated and exported
to CSV format. The data can be found under `A.Tutorial.Data` in three files, `temp.csv`,
`pressure.csv`, and `weight.csv`. 

```q
// Read a sample of the data to show its contents
contents: 10#read0 `:A.Tutorial.Data/temp.csv;

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
                      
        File Path       : A.Tutorial.Data/temp.csv
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
columns should be `float`. All of the remaining columns should be set to `Long`.
We perform processing on it in the *Table Transformer*.

Pressing `Next` takes you to the *Import* tab where a final action can be selected.
We could directly import the table but here we want to fix messy columns. To do this,
select `Transform` in the *Import Type* select. Finally, pressing `Finish` will 
launch into the *Table Transformer*.

Table Transformer (*Kx Analyst Only*)
-------------------------------------

> Note if not using Kx Analyst, skip to the `Data Simulation` section to generate 
> the sensors data.

Using the transformer, we can do more complex data transformations before importing
the data. The transformer works on a sample of the data to build up a workflow of
actions that will transform the data into a usable format. Once the transform
has been built, it can be executed on the current data or saved into a compiled
kdb+ function and parameterized.

For this transform we will add an *Action* node to the transform and add a moving
average  column. First, right-click the node and select `New > Action`. Now right 
click the  `signal` column and select `Add Column...`.


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
`A.Tutorial.IO/ImportSensors`. Before opening this transform, ensure that the 
process is in the workspace directory.

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
`Transform > Run` to perform the import. The transform will ingest the data and produce the 
output tables. The graphic node that has been selected is showing a sensor signal
plot of one sensor.

Alternatively, the transformation can be run as a function by invoking the transform.

```q
// In a transformation, the first argument is for the inputs to the transform 
// and the last argument is for the outputs. Providing null for both uses the defaults
// that were configured in the UI. A dictionary can be provided for each input or output
// that maps the name of the node in the UI to a new input or output configuration.
ImportSensors[::;::];

// Example with explicit input and output locations
ImportSensors[
    `temp`pressure!(`:A.Tutorial.Data/temp.csv; `:A.Tutorial.Data/pressure.csv);
    
    // Output to a csv file called `signals.csv` - we need to change the output format
    // from a kdb+ table to a csv file by creating a new `.im.io` source descriptor 
    enlist[`signals]!enlist .im.io.with.target[`:signals_out.csv] .im.io.create `csv
    ];

// Now there is a new file called signals_out.csv
contents: 10#read0 `:signals_out.csv;
```

Data Simulation
---------------

!!! note "Important"
    In the interest of time and space, the data that we have imported is very small so that
    it could easily be shared. For the remainder of the walkthrough, we will switch to using
    a simulated version of the data that is much larger than the data we have just imported.

```q
// Running the simulation will take a bit of time but will produce far more data than
// what was imported. Once complete, there will be around ~10M simulated sensor readings
// in the new `sensors` table.
sensors: sim.system[];

// Check the count of the sensors table
count sensors
```


Visual Inspector
----------------

Now that the data has been generated, we can start exploring it. We can use the 
*Visual Inspector* to visualize and tumble the data. We can use the *Process View* to see
which tables were imported. Select the `Process` tab in the search pane view to see 
functions and data in our process. Under the global tables tab, we should find the tables
that were just imported.


    └── . (Global)
        └── Tables
            ├── sample
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
     Chart Type: Histogram                     | X Axis Column    : machine       
                                               | ...                            
                                               | ✓ Enable Fill Colour  
                                               | Fill Aggregation : Average   
                                               | Fill Column      : active


Now that we understand the distribution of the activity per sensor, we can look at the
average sensor readings over time. A visualization has been saved in 
`A.Tutorial.Plots/ReadingsOverTime`. Double-click the plot to view the readings over time.

    └── training
        └── A.Tutorial.Plots/Plots
            └── ReadingsOverTime


Let's turn our focus to the individual sensors readings. Let's look at all the distinct
sensor readings over time. Double-click the `SignalBySensor` plot in `A.Tutorial.Plots` to
view all of the discrete signals. This will be a messy plot but will allow us to visualize
the entire dataset.


    └── training
        └── A.Tutorial.Plots
            └── SignalBySensor



In the visual, one signal seems to go above the others. Click on it brings up a tooltip
that indicates the machine and signal as the `id`, that seem to be affected. Let's take 
a closer look at this signal. We can use quick plotting library that included with the
*Grammar of Graphics* to plot the signal for this sensor.

```q
// Select only sensor that is failing. Replace the query keys with the ones from 
// the tooltip in the visual inspector.
// 
// Replace the `mach_g` value with the machine name and the `pressure_a` with the 
// sensor name from the tooltip in the Visual Inspector 
failing: select from sensors where machine=`mach_g, sensor=`pressure_a;
.qp.go[800; 500] plotSignal failing
```

This likely indicates to us that we need to investigate this sensor further. There may be a 
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
using the *Table Transformer*. We then performed some ad-hoc visualizations using the
*Visual Inspector* tool. We then built some custom visualizations using the *Grammar of Graphics*. 

While performing our visualization on the sensors data, we identified a potential issue 
with one of the sensors in the system. We then created some custom visualization to investigate
this further.

And finally, we will take the first 100 individual sensor signals by machine and plot
them in a single visual summary.

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
