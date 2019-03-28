## Faceting

Facets are useful to split a plot into subplots.

In the following, we can see large spikes in the low range until the
8th, when the spikes move to the mid range, and the low range drops out.

```q

    .qp.go[900;500] .qp.facet[update date:date.date from cells; `date]
        .qp.histogram[; `dest; .qp.s.binx[`w;1;0]];

```