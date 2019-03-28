## QuickCheck

### Generators

The bulk of the work in QuickCheck is in generating random arguments. These
arguments are specified using generator combinators. An element can be forced
from a geneartor by calling `.qch.g.reify` on it.

```q

    // random ints

    .qch.g.reify .qch.g.int[]  
    
    // ints between 0 and 10
    
    .qch.g.reify .qch.g.int 10  
    
    // random booleans
    
    .qch.g.reify .qch.g.bool[]  
    
    // list of booleans
    
    .qch.g.reify .qch.g.list .qch.g.bool[]   
    
    // list of lists of booleans
    
    .qch.g.reify .qch.g.list .qch.g.list .qch.g.bool[]   
    
    // random symbols
    
    .qch.g.reify .qch.g.symbol[]             

    // random dictionaries

    .qch.g.reify .qch.g.dict[]               

    // dictionaries from specification
    
    .qch.g.reify .qch.g.dict `a`b!(.qch.g.int[]; .qch.g.list .qch.g.byte[])   

    // random tables

    .qch.g.reify .qch.g.table[]            
                                    
    // tables from a specification
    
    .qch.g.reify .qch.g.table ([] a: enlist .qch.g.float 5; b: enlist .qch.g.char[])
    
```

### Properties

QuickCheck runs the generators (100 by default) times against a property. For example,
we could assert that all booleans are true, as in the below.

```q

    prop_istrue : { x };

    .qch.summary
        .qch.check
        .qch.forall [.qch.g.bool[]] prop_istrue;

```

This errors and provides a counter-example of `0b`.

A more interesting property would be that the result of a function that increments 
its argument by two is its argument incremented by two.

```q

    intensify : { x + 2 };

    // Want this to hold
    
    prop_intensify : { (x + 2) = intensify x };

    // This is wrong and will fail
    
    prop_intensify2 : { (x + 1) = intensify x };

    // An optional classifier to get random distribution information 
    // on the generated data
    
    classifier: { $[x>0; "positive"; x=0; "zero"; "negative"] };

    .qch.summary .qch.check  
        // Run 500 random tests (optional)
        .qch.with.times[500]    
        // Run this classifier on each input (optional)
        .qch.with.classifier[classifier]        
        .qch.forall [.qch.g.int[]] prop_intensify;


    .qch.summary  .qch.check  
        .qch.with.times[500]                
        .qch.with.classifier[classifier]  
        .qch.forall [.qch.g.int[]] prop_intensify2;

```

A helpful feature of QuickCheck is the shrunk counter examples. In the
examples below, the smallest failing argument will be reported.

```q

    // Basic lists

    prop_no5 : 

    .qch.summary
        .qch.check 
        .qch.forall [.qch.g.list .qch.g.int 10] prop_no5;

    // Weighted lists with nulls

    prop_notnull : { not any null x };

    .qch.summary 
        .qch.check 
        .qch.forall [.qch.g.list .qch.g.oneof_w [(.qch.g.const 0Ni; .qch.g.const 0Wi; .qch.g.const -0Wi; .qch.g.int[50]);
                                                  (1                1                 1                  97       )]] 
            prop_notnull; 

    // Dictionaries

    prop_no5dict : { all not 5 in/: value x };

    .qch.summary
        .qch.check
        .qch.forall [.qch.g.dict `a`b`c`d!(
                    .qch.g.list .qch.g.int[50];
                    .qch.g.list .qch.g.int[];
                    .qch.g.list .qch.g.int[10];
                    .qch.g.list .qch.g.int[])]
            prop_no5dict;

    // Tables

    prop_no5table : { prop_no5dict flip x };

    .qch.summary
        .qch.check
        .qch.forall [.qch.g.table ([]a:enlist .qch.g.int 50; b:enlist .qch.g.listn[3] .qch.g.listn[3] .qch.g.long[])]
            prop_no5table;

```

### Multiple Arguments

Multiple generators can be specified by using the appropriate version of `forall*`, up to 7 arguments.

```q

    .qch.summary .qch.check .qch.forall2 [.qch.g.list .qch.g.int[]; .qch.g.list .qch.g.int[]] { 
        (count x) ~ count y
        };


    .qch.summary .qch.check 
        .qch.forall7 [.qch.g.int[]; .qch.g.int[]; .qch.g.int[]; .qch.g.int[]; .qch.g.int[]; .qch.g.int[]; .qch.g.int[]] 
            {[x1;x2;x3;x4;x5;x6;x7] (x1-x2-x3-x4-x5-x6-x7) ~ x1+x2+x3+x4+x5+x6+x7 };

```


