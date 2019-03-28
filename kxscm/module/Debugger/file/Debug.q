
// ==================== Simple debugging ==================== //

// Display the below code to see the result in the console

.analysis.haversine[
    .analysis.CITIES[`Ottawa   ; `coordinates];
    .analysis.CITIES[`London   ; `coordinates]
    ];

// Set the planet to mars

.analysis.Planet: `mars;

// Open the below code in the debugger to step through execution

.analysis.haversine[
    .analysis.CITIES[`Ottawa      ; `coordinates];
    .analysis.CITIES[`London   ; `coordinates]
    ];



// ==================== Recursive debugging ==================== //

// Open the below and step in to see stack frames pile up

.analysis.hailstoneSequence 22;

.analysis.fibonacci 8;



// ==================== Profiling ==================== //

// Click the clock to display per-line run time
// The lines show the run time relative to other lines in the same frame

foo: {
    do[100; cos each til 1000];
    do[100; cos each til 2000];
    do[100; cos each til 3000];
    bar[];
    : `foo;
    };

bar: {
    do[100; cos each til 10000];
    do[100; cos each til 30000];
    do[100; cos each til 20000];
    };

foo[]