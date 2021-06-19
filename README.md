# Mastermind in Haskell

### The Game
<img src="https://upload.wikimedia.org/wikipedia/commons/2/2d/Mastermind.jpg" width="400" height="400">

The rules can be read at [Rules](https://en.wikipedia.org/wiki/Mastermind_(board_game)). This version assumes you can place any number of pins of each color, and have 8 colors at your disposition but a modification of the source code should make any parameters work.

## Compile

If you have `ghc` installed, type `./make.sh` and it will automatically create the `mastermind.exe` file for you. Then execute it.

## How to use it

If your secret combination is `[1,2,3,4,5]`, type `12345` after executing the program.
You will see an output similar to this:

```
12345

[1,1,1,1,1] <- This is the combination it tries
(1,1) <- The white and black pins that it gets back
... and repeat

[1,2,2,2,2] 
(2,2)
[1,2,3,3,3]
(3,3)
[1,2,3,4,4]
(4,4)
[1,2,3,4,5]
(5,5)

Record {secret = [1,2,3,4,5], list = [((5,5),[1,2,3,4,5])]} <- this should match your secret combination
```

If you are comfortable working with source code, you can follow instructions written in comments in the `playGame` function in the `src/mastermind.hs` file, and comment out the necessary code. This allows you to manually enter the white and black pins.

## How it Works

The idea behind this implementation is the fact that if sequence A has the same number of Black (B) and White (W) pins when compared to the sequence B and the sequence B is compared to the secret sequence, then A does not violate any of the clue given by B.

When comparing two sequences you get back a number of Black (B) pins and White (W) pins.

The algorithm I designed works because, if comparing combination A and combination B yield the same results as comparing combination B and the secret combination, then combination A does not infringe on any of the previous clues(B and W pins).

### Example:
```
Seq A: [1,1,1,1,1]
Seq B: [1,2,2,2,2]

Secret: [1,2,3,4,5]

Pins(A, Secret) = {Black: 1, White: 1}
Pins(B, A) = {Black: 1, White: 1}
```
It is necessary to generate a sequence that does not infringe on any of the previous clues if you want to play an optimal game.