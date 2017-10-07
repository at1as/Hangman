# Hangman

Simple script to solve hangman.

Does the following:
* Selects a word a random from the dictionary
* Given the length of the word, finds the most common letter occurances across all words of that length
* Simple algorithm
  * Guesses most common letters until solution is found
* Improved algorithm
  * Filters for most common letters at every iteration for dictionary words that match pattern of the guessed letters
  * Continues until solution is found

Note: Syntax is nearly Ruby compatable, however tuple types need to be changed to Hash and type decleration needs to be removed from the array.


## Usage

```
$ crystal hangman.cr
```

## Output

### Simple Algorithm
```
$ crystal hangman.cr  --error-trace

Selecting a word from the dictionary at random...

The word is --------- (9 of 9 digits remaining)
Solving using simple algorithm...

Trying with e...
The word is ------e-- (8 of 9 digits remaining)

Trying with i...
The word is ------e-- (8 of 9 digits remaining)

Trying with a...
The word is --a---e-- (7 of 9 digits remaining)

...

Trying with y...
The word is crac-less (1 of 9 digits remaining)

Trying with g...
The word is crac-less (1 of 9 digits remaining)

Trying with b...
The word is crac-less (1 of 9 digits remaining)

Trying with f...
The word is crac-less (1 of 9 digits remaining)

Trying with v...
The word is crac-less (1 of 9 digits remaining)

Trying with k...
The word is crackless (0 of 9 digits remaining)

Solved after 22 iterations with simple algorithm
```

### Improved Algorithm
```
Solving using improved algorithm...

Trying with e...
The word is ------e-- (8 of 9 digits remaining)

Trying with s...
The word is ------ess (6 of 9 digits remaining)

Trying with n...
The word is ------ess (6 of 9 digits remaining)

Trying with l...
The word is -----less (5 of 9 digits remaining)

Trying with r...
The word is -r---less (4 of 9 digits remaining)

Trying with t...
The word is -r---less (4 of 9 digits remaining)

Trying with a...
The word is -ra--less (3 of 9 digits remaining)

Trying with c...
The word is crac-less (1 of 9 digits remaining)

Trying with k...
The word is crackless (0 of 9 digits remaining)

Solved after 10 iterations with improved algorithm

```
## Notes

* Build on `Crystal 0.23.1 (2017-09-08) LLVM 4.0.1`
* Requires list of words to be under `/usr/local/share/dict` as is default on macOS
