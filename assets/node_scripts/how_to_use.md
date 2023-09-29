# How To Use
This JS file is a little node script I whipped up to generate levels.
There's not much to it, all you have to do is run ```node mission_gen.js``` and in the console a json formatted level will get generated that can be used for mission levels in the game.

Some things to note:
* You will need NodeJS installed.
* In the terminal they don't get rendered in a json friendly format
* You will need to do a string find and replace for ```'``` to become ```"```
* You can modify the script to change how frequent units appear
* Also make sure at least 1 of each ```r```, ```p```, and ```s``` show up for the level to be valid

An example output below:

```JavaScript
[ [ 's', 'r', 'r', '_', '_', '_', '_', 'r', 'r', 's' ],
  [ '_', 'r', 's', '_', '_', '_', '_', 's', 'r', '_' ],
  [ 's', '_', 's', '_', '_', '_', '_', 's', '_', 's' ],
  [ '_', '_', '_', 'p', 'p', 'p', 'p', '_', '_', '_' ],
  [ '_', 'r', 'r', '_', '_', '_', '_', 'r', 'r', '_' ],
  [ '_', 's', 's', '_', 'r', 'r', '_', 's', 's', '_' ],
  [ '_', '_', '_', 'p', '_', '_', 'p', '_', '_', '_' ],
  [ 's', 'r', 'p', '_', '_', '_', '_', 'p', 'r', 's' ],
  [ 'p', '_', 'r', '_', '_', '_', '_', 'r', '_', 'p' ],
  [ 's', '_', 'p', '_', '_', '_', '_', 'p', '_', 's' ],
  [ '_', '_', '_', '_', '_', '_', '_', '_', '_', '_' ],
  [ 's', 's', '_', 'r', 's', 's', 'r', '_', 's', 's' ],
  [ '_', '_', '_', '_', 'r', 'r', '_', '_', '_', '_' ],
  [ '_', '_', 'r', 'r', 's', 's', 'r', 'r', '_', '_' ],
  [ 'r', '_', 'p', 'r', '_', '_', 'r', 'p', '_', 'r' ],
  [ '_', '_', 'r', '_', '_', '_', '_', 'r', '_', '_' ],
  [ 'p', '_', '_', '_', '_', '_', '_', '_', '_', 'p' ],
  [ '_', 'r', '_', '_', '_', '_', '_', '_', 'r', '_' ],
  [ '_', '_', 'r', '_', 'r', 'r', '_', 'r', '_', '_' ],
  [ 's', '_', 'p', 'p', 'p', 'p', 'p', 'p', '_', 's' ] ]
  ```