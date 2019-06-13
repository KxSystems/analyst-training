## Interaction


Evaluate the line below:

```q
.qp.go[500;500] .qp.point[subset; `ma; `signal; ::];
```

Click the a point in the resulting image. Notice a table appears under
the image. This table represents the data associated with the clicked
point.

Hold Control + Click and Drag a region within the axes. A *new* image
will be created showing the zoomed-in region. Closing the new image
will return to the original. This process can be repeated to zoom further
in to the data.

### Zoom Regions

Execute the following histogram and drag a horizontal slice across the image.

```q
.qp.go[500;500] .qp.histogram[data; `ma; ::];

// Settings, like number of bins, can be slotted in as the second argument
.qp.go[500;500] .qp.histogram[data; `ma] 
    .qp.s.binx[`c;200;0]

```

Notice how the entire bar does not need to be selected to zoom. The zoom
region is defined the by the geometry used. A point geometry uses a 2D
area, whereas a histogram zooms only into the x axis.

### Multiple Layers

Execute the following and click on a bar.

```q
.qp.go[500;500] .qp.boxplot[subset; `machine; `signal; ::];
```

Notice that many tables have been created under the image. In general, GG does
not know which layers in a multi-layer graphic the user wishes to inspect, so
information about the closest point in every layer is returned. The layer 
geometry is tagged at the top of each table for reference.
