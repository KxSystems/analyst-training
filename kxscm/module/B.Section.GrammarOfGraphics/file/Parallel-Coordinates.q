// Load the data
data: raze {
    open:"f"$sums 90?-1 0 1;
    ([]sym:x;date:2015.01.01+til 90;open:open;close:-2.5+open+90?5;high:-2.5+open+90?8;low:-2.5+open+90?8;volume:90?40000000)
    } each `AAPL,50?`4;

// A sample of the data
cs:    cols data;
n:     count cs;

// Initialize a scale for each column and store the breaks and limits
scales: .gg.scale.initBreaks each .gg.scale.init[.gg.scale.default] each data cs;
// Breaks are the ticks of a scale, and limits are the max and min (cleaned)
breaks: scales@\:`breaks;
limits: scales@\:`limits;

// A helper to turn a column name into a pixel coordinate name 
pcol:   `$"p",string@;

// Strategy is to extend the table to display with columns for 0-1 normalized space
xpos:   (pcol each til n)!til n;
points: data ,' flip xpos , (pcol each cs)!{[s;l;x] (.gg.scale.apply[s;x] - l 0) % l[1] - l 0 }'[scales; limits; data cs];

// Pairs of column names for segment geometry (line from p1 to p2)
pairs: cs -1_til[n] ,' next til n;

// A table of text for the axes
text:  {[i;s;b;l] flip `v`x`y!(.gg.scale.inverse[s;b]; i;) (b - l 0) % l[1] - l 0 }'[til count scales; scales; breaks; limits];

// The text geometries for the axes
labels: { 
    .qp.text[x; `x; `y; `v] 
          .qp.s.textalign[`right] 
        , .qp.s.geom[``offsetx!(::; -10)] 
    } each text;

// The vertical lines for the axes
grids: .qp.vline[; ::] each til n;

// Titles for each axes
titles: .qp.text[flip `v`x`y!(cs; til count cs ;0); `x; `y; `v]
      .qp.s.textalign[`middle] 
    , .qp.s.geom[``size`offsety!(::; 12; 20)];

// The *grid* is just the labels and the axes
coordinates: .qp.stack labels , grids , enlist titles;

// A collection of segments for each pair of columns
segments: .qp.stack {[d;i;p]
    .qp.segment[d; pcol i; pcol p 0; pcol i + 1; pcol p 1]
        .qp.s.geom[`fill`alpha!(`orange; 20)]
    }[points]'[til count pairs; pairs];

// Parallel coordinates is just the set of axes and the set of segments
.qp.go[900;500] 
    .qp.theme[.gg.theme.transparent]
    .qp.theme[`canvas_fill`axis_use_x`axis_use_y`padding_left`padding_bottom!(0xffffffff; 0b;0b;60;60)]
    .qp.title["Parallel Coordinates for OHLC"]
    .qp.stack (segments; coordinates)
