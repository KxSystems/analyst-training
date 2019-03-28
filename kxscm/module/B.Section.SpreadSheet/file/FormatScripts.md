## Format Scripts

A format script can add JS widgets to a spreadsheet cell.

For example, enter Manage Script Regions, create a new region for a cell,
and enter the following to create a combo box:

```js

    return Sheet.createCombo(cell, [1, 2, 3, 4, 5]);

```

Then, another cell can use the value of this combo box in a query.