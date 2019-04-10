// ==================== Simple debugging ==================== //

// Quick Debugging 
// 
// This example illustrates the quick debugger. In this simple example, we
// will fix a bug using a haversine algorithm. The haversine function gives
// the distance between two points on a great circle. This can be used to 
// calculate the approximate distance between two points on Earth.

// --- Evaluate the following lines

// Converts degrees to radians
// @param x {number} Degrees to convert to radians
// @return {float} Value in radians
deg2rad: { x * PI % 180 };

// Calculates a 2-argument arctangent between two points and
// returns the angle in radians.
// @param x {number} x position of point
// @param y {number} y position of point
// @return {float} Value in radians
atan2: {[x; y]
    $[x > 0x; 
        atan y % x;
      x < 0;
        $[y >= 0;
            atan[y % x] + PI;
            atan[y % x] - PI];
      x = 0;
        $[y > 0;
            PI % 2;
          y < 0;
            neg PI % 2;
            0];
        ]
    };

// Returns the square of the input
// @param x {number} Number to square
// @return {number} x to the power of 2
square: {x*x};

// The haversine function gives the distance between two 
// points on a great circle
//
// @param planet {symbol} Planet to find distance on
// @param start {float[]} Lat-Long tuple
// @param end {float[]} Lat-Long tuple
//
// @return {float} The distance between the points
haversine:{[planet; start; end]

    // Create variables to quickly reference the components 
    // of the two points
    slat    : start 0;
    slong   : start 1;
    elat    : end 0;
    elong   : end 1;
    
    // Fetch the radius of the current planet
    radius : PLANETS[planet; `radius];
    
    // The Haversine function
    deltaLat  : deg2rad elat - slat;
    deltaLong : deg2rad elong - slong;
   
    a: square[sin deltaLat % 2] + 
       square[sin deltaLong % 2] * cos[deg2rad slat] * cos deg2rad elat;  
    
    c: 2 * atan2[sqrt 1 - a; sqrt a]; 
    
    : radius * c;
    };


// --- Debug the following statement

// Now we can calculate the distance between two major cities on earth
//
// Running this line will throw an error - right-click the line and
// select `Quick Debugger`
haversine[`earth; CITIES . `New_York`coordinates; CITIES . `London`coordinates]

// We can see from the quick debugger that the first line in atan2 has a bug
// where it is comparing x to 0x instead of just 0. By removing that x we can
// fix the error and calculate the distance.

// --- Redefine a working version of atan2

// Calculates a 2-argument arctangent between two points and
// returns the angle in radians.
// @param x {number} x position of point
// @param y {number} y position of point
// @return {float} Value in radians
atan2: {[x; y]
    $[x > 0; 
        atan y % x;
      x < 0;
        $[y >= 0;
            atan[y % x] + PI;
            atan[y % x] - PI];
      x = 0;
        $[y > 0;
            PI % 2;
          y < 0;
            neg PI % 2;
            0];
        ]
    };

// Now running the following line returns the distance between New York and London
haversine[`earth; CITIES . `New_York`coordinates; CITIES . `London`coordinates]
/=> 5574.018


