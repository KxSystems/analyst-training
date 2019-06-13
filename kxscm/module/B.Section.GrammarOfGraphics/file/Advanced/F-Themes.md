## Advanced Theming

Built-in themes bundle several options together. Any aspect of these themes can 
be modified, and whole new themes can be created. Any part of a theme can be
specified in `.qp.theme`, which will override the corresponding settings in the
current theme.

To see the available options, open `.gg.theme.default` in the Visual Inspector.

```q
// A basic chart with default theme
.qp.go[500;300] .qp.histogram[subset; `signal; ::];

// Use clean theme as a template, and override various aspects
.qp.go[500;300] 
    .qp.theme[.gg.theme.clean]
    .qp.theme[`axis_use_x`grid_style_x`grid_style_y`plot_background_fill!(0b; `none; `zebra; 0xffffffff)]
    .qp.title["Custom Chart"]
        .qp.histogram[subset; `signal; ::];

```