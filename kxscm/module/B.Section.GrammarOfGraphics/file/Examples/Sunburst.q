// ~~~ generate a binary tree of a given height
n      : sum "j"$xexp[2;]til height: 12;
ps     : `,(,/)2#'(count[ls]-"j"$2 xexp height - 1)#ls: n?`8;;
t      : ([]parent: ps; label: ls; amount: n?50);

// ~~~ custom layout
arrange : {[fill; table; level; a; p; o]
    ra: select from table where parent = p;
    ra[`amount]: ra[`amount] % sum ra`amount;
    ra : `amount xdesc ra;
    if [0 = count ra; : ra];
    if [level = 4; fill: rand .gg.colour.brewer[`Set2;8]];
    if [(level > 4) and .1 > rand 1f; : ()];
    t: ([] parent: p; 
           level : level;
           fill  : (count ra)#enlist fill;
           x1    : "f"$o+0,sums a*-1_ra`amount; 
           w     : a*ra`amount; 
           y1    : level; 
           y2    : level + 1; 
           label : ra`label);
    : t , raze .z.s[fill; table; level + 1]'[t`w; ra`label; t`x1] };

r: arrange[.gg.colour.DarkGray; t; 0f; 1; `; 0f];
r: update x1:"f"$x1, x2: x1 + w from r;
r: update tx: x1+w%2, ty: y1+0.5 from r;



 // ~~~ sunburst chart

.qp.managed[`sunburst;600;600]
    .qp.theme[.gg.theme.transparent]
    .qp.theme[`aspect_ratio`legend_use`axis_use_x`axis_use_y!(`square; 0b; 0b; 0b)]
    .qp.title["Sunburst Chart"] 
    .qp.rect[r; `y1; `x1; `y2; `x2] (::)

          .qp.s.geom  [enlist[`colour]!enlist .gg.colour.White]
        , .qp.s.scale [`y;     .gg.scale.extend[0b] .gg.scale.linear]
        , .qp.s.scale [`x;     .gg.scale.extension[0.3] .gg.scale.linear]
        , .qp.s.aes   [`fill;  `parent]
        , .qp.s.scale [`fill;  .gg.scale.colour.cat r[`parent]!r`fill]
        , .qp.s.aes   [`alpha; `level]
        , .qp.s.scale [`alpha; .gg.scale.alpha[50; 255]]
        , .qp.s.coord [.gg.coords.polarn 20]