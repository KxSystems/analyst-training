## Faceting

Facets are useful to split a plot into subplots. Each subplot will only contain data
relating to one distinct value of the facet column.

The facet below shows individual signal distributions for each sensor.

```q
.qp.go[1000;500] .qp.facet[update date:time.minute from subset; `sensor]
    .qp.histogram[; `signal; .qp.s.binx[`c;200;0]];
```