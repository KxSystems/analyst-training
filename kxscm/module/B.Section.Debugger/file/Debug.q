// ==================== Simple debugging ==================== //


// Create some random data

n: 100000;
taxRate: .15;
items  : ([] item: `$/:.Q.a; price: count[.Q.a]?100f);
sales  : `date`time xasc ([] 
    id       : n?`5; 
    date     : n?.z.d + til 5; 
    time     : n?24:00:00;
    item     : n?items.item;
    quantity : 1 + n?10
    );

// Create some functions

purchase: {[sales; item; quantity]
    sales upsert `id`date`time`quantity`item!(rand `5; .z.d; "v"$.z.t; quantity; item)
    };

round: {[points; val] 
    (floor val * e) % e: 10 xexp points 
    };

subtotal: {[items; sales]
    update subtotal: round[2] quantity * items.price items.item?item from sales
    };

taxes: {[taxRate; items; sales]
    update tax: round[2] taxRate * subtotal from subtotal[items; sales] 
    };

total: {[taxRate; items; sales]
    update total: round[2] tax + subtotal from taxes[taxRate; items; sales]
    };


total[taxRate; items; sales]






