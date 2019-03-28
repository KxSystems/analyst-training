// Mock a data set
ohlc: raze {
    open:"f"$sums 90?-1 0 1;
    ([]sym:x;date:2015.01.01+til 90;open:open;close:-2.5+open+90?5;high:-2.5+open+90?8;low:-2.5+open+90?8;volume:90?40000000)
    } each `abcd,50?`4;
delete from `ohlc where .gg.scale.toWeekday [date] in `Saturday`Sunday;
update gain:close > open from `ohlc;
symbol: rand ohlc`sym;

// Stacked Area Chart showing order volume

.qp.go[900;500] 
    .qp.area[ohlc; `date; `volume]
        .qp.s.aes[`group; `sym]
       ,.qp.s.aes[`fill; `sym]
       ,.qp.s.scale[`fill; .gg.scale.colour.cat20]
       ,.qp.s.geom[enlist[`position]!enlist `stack];

    // For only the largest 5 symbols

.qp.go[900;500] 
    .qp.theme[.gg.theme.clean]
    .qp.theme[enlist[`axis_size_y]!enlist 100]
    .qp.title["Total volume for five symbols"]
    .qp.area[select from ohlc where sym in 5#key desc exec sum volume by sym from ohlc; `date; `volume]
        .qp.s.aes[`group; `sym]
       ,.qp.s.aes[`fill; `sym]
       ,.qp.s.scale[`fill; .gg.scale.colour.cat20]
       ,.qp.s.geom[enlist[`position]!enlist `stack];



// --  1. Basic Candlestick chart

CandlestickChart : {
    fillscale : .gg.scale.colour.cat 01b!(.gg.colour.Red; .gg.colour.Green);
    
    .qp.stack (        
        // Open/Close
       .qp.interval[x; `date; `open; `close]
                y , .qp.s.aes[`fill; `gain]
                , .qp.s.scale[`fill; fillscale]
                , .qp.s.geom[`gap`colour!(0; .gg.colour.White)];        
        // Low/High
        .qp.theme[enlist[`legend_use]!enlist 0b]
            .qp.segment[x; `date; `high; `date; `low]
                y , .qp.s.aes[`fill; `gain]
                , .qp.s.scale[`fill; fillscale]
                , .qp.s.geom[enlist [`size]!enlist 2]
    )};

.qp.go[700;300] 
    .qp.title["90-day candlestick"]
    CandlestickChart[select from ohlc where sym=symbol,date within 2015.01.01 2015.04.01; ()!()];




// -- 2. MACD chart

ma: {[n; c; tt]
    f: n + exec min date from tt;
    a: avg @[;c] tt where tt[`date] < f;
    ma: {[c;n;x;y] (y[c]*2%n+1) + x*(1-2%n+1)}[c;n]\[a;] select from tt where date > f;
    (`date; `$"ma",string n) xcol ([]date: f+til count ma; ma: ma)
    };

snapshot: select from ohlc where sym=symbol,date within 2015.01.01 2015.07.01;
t12:      ma[12; `close; snapshot];
t26:      ma[26; `close; snapshot];
macd:     select date, macd: ma12 - ma26 from t26 lj `date xkey t12;
signal:   ma[9; `macd; macd];
histo:    select zero:0f, date, histo:macd-ma9 from signal lj `date xkey macd;

MACDChart: {[histo; macd; signal; ops]
    dates: -1+@[;`date] histo 1_where not =':[0 < histo`histo];
    overlap: select date,x:ma9 from signal where date in dates; 
    overlap: select date, x, buy:macd<ma9 from (overlap lj `date xkey signal) lj `date xkey macd;
    
    .qp.stack (
        // MACD histogram
        .qp.interval[histo; `date; `zero; `histo]
            ops , .qp.s.geom[`alpha`gap`colour!(0x7f; 0; .gg.colour.White)];
        // MACD and Signal
        .qp.line[macd; `date; `macd]
            ops , .qp.s.geom[`size`fill`alpha!(2; .gg.colour.Gray; 0xaf)];
        .qp.line[signal; `date; `ma9]
            ops , .qp.s.geom[`size`fill`alpha!(2; .gg.colour.FireBrick; 0xaf)];
        .qp.point[overlap; `date; `x]
            ops
            , .qp.s.geom[`size`alpha!(7; 0x50)]
            , .qp.s.aes[`fill; `buy]
            , .qp.s.scale[`fill; .gg.scale.colour.cat 01b!(.gg.colour.LightCoral; .gg.colour.ForestGreen)];
        .qp.text[select date, macd, text:enlist "macd" from macd where date = min date; `date; `macd; `text]
            ops, .qp.s.textalign[`right];
        .qp.text[select date, ma9, text:enlist "signal" from signal where date = min date; `date; `ma9; `text]
            ops,.qp.s.textalign[`right]
        )
    };

MAChart: {
    .qp.stack {[ops;x;y] .qp.line[x; `date; y]
        ops , .qp.s.geom[`size`alpha!(0.5; 0x7f)]}[z]'[x;y]
    };

.qp.go[700;300]
    .qp.stack (
        // CandleStick
        CandlestickChart[snapshot; ()!()];
        // Moving Averages
        MAChart[(t12;t26); `ma12`ma26; ()!()];
        // MACD
        /.qp.theme[enlist[`legend_use]!enlist 0b]
        MACDChart[histo; macd; signal; ()!()]);



// -- 3. Split into separate axes to accentuate the MACD

.qp.go[700;300] 
    .qp.split (
        .qp.stack (
            // CandleStick
            CandlestickChart[snapshot; ()!()];
            // Moving Averages
            MAChart[(t12;t26); `ma12`ma26; ()!()]);
        // MACD
        MACDChart[histo; macd; signal; ()!()]);



// -- 4. Clean up the theme and add a title

.qp.go[800;350] 
    .qp.theme[.gg.theme.clean]
    .qp.title["Stock Chart for Simulated Stock Value"]
    .qp.split (
        .qp.stack (
            // CandleStick
            CandlestickChart[snapshot; .qp.s.labels[`x`y!("Date";"Stock Price")]];
            // Moving Averages
            MAChart[(t12;t26); `ma12`ma26; .qp.s.labels[`x`y!("Date";"Stock Price")]]);
        // MACD
        MACDChart[histo; macd; signal; .qp.s.labels[`x`y`fill!("Date";"MACD";"Buy/Sell")]]);



// -- 5. Split that charts into separate components

xscale: .gg.scale.limits[(min;max)@\:ohlc`date] .gg.scale.format[.gg.fmt.date] .gg.scale.date;

.qp.go[700;400] 
    .qp.theme[.gg.theme.clean]
    .qp.title["Stock Charts"]
    .qp.layout[`vert; ::] (
        .qp.stack (
            // CandleStick
            CandlestickChart[snapshot]
                .qp.s.labels[`x`y!("Date";"Stock Price")]
              , .qp.s.scale[`x; xscale];
            // Moving Averages
            MAChart[(t12;t26); `ma12`ma26; .qp.s.labels[`x`y!("Date";"Stock Price")]]);
        // MACD
        MACDChart[histo; macd; signal]
            .qp.s.labels[`x`y!("Date";"MACD")]
             , .qp.s.scale[`x; xscale]);



