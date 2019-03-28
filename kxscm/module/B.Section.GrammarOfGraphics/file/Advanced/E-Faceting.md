## Faceting

Facets are useful to split a plot into subplots.

In the following, we can see large spikes in the low range until the
8th, when the spikes move to the mid range, and the low range drops out.

```q

    .qp.go[1000;500] .qp.facet[update date:time.minute from subset; `sensor]
        .qp.histogram[; `signal; .qp.s.binx[`c;200;0]];

```