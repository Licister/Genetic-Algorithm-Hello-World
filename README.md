#Genetic Algorithm for "Hello, world!"
  
This code was done for [Challenge #249: Hello World Genetic or Evolutionary Algorithm](https://www.reddit.com/r/dailyprogrammer/comments/40rs67/20160113_challenge_249_intermediate_hello_world/), using the language R.
  
The goal of the algorithm is to reach a target string of characters, numbers, punctuation, spaces and other special characters. The algorithm generates a random population of possible strings and then, via selection, reproduction and mutation, generates new populations until the target string is obtained.
  
The algorithm prints certain information to the console every time a new best solution is found. That information is the number of the generation, the fitness of the string and the string itself. At the end, it will also print out the time it took to reach the target string.
  
  
Methods used:
* Original population: random strings of the same size as the target one.
* Fitness: Hamming distance.
* Selection method: elitism.
* Reproduction: tournament method and 1-point crossover.
* Mutation: specific number of changes.
  
  
Parameters of the main function, `genetic`:
* `target`: target string.
* `n`: population size. Default: 50.
* `elite_per`: percentage of elite solutions to keep between generations. Default: 0.2. The actual number of solutions will be rounded up.
* `rep_per`: percentage of solutions generated via reproduction. Default: 0.7. The actual number of solutions generated will be rounded up.
* `mut_rate`: rate of mutation, that is, how many changes will be applied to the solution to be mutated (in percentage). Default: 0.2. The actual number of changes will be rounded up.
* `seed`: the seed, in order to make things reproducible. Default: 1.



  
