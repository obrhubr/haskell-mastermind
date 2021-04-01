# Mastermind in Haskell

### The Game
<img src="https://upload.wikimedia.org/wikipedia/commons/2/2d/Mastermind.jpg" width="400" height="400">

The rules can be read at [Rules](https://en.wikipedia.org/wiki/Mastermind_(board_game)). This version assumes you can place any number of pins of each color, and have 8 colors at your disposition but a simple modification can change that.

## How to use it

If your secret config is `[1,2,3,4,5]`, type `12345` after executing the program.

## How it Works
The idea behind this implementation is the fact that if sequence A has the same number of B and W pins when compared to the sequence B and when the sequence B is compared to the secret sequence, then A does not violate any of the clue given by B.

### Example:
```
Seq A: [1,1,1,1,1]
Seq B: [1,2,2,2,2]

Secret: [1,2,3,4,5]

Pins(A, Secret) = {Black: 1, White: 1}
Pins(B, A) = {Black: 1, White: 1}
```
It is necessary to generate a sequence that does not violate any of the previous clues if you want to play an optimal game.