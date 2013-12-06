---
layout: post
published: true
title: More Ipsum, or Why Lorem
---
Related Work
------------
In recent years a number of competing assemblers have been released that vary in quality and performance.  Over 40 such algorithms are listed on the Wikipedia page for sequence assembly (3).  We have reviewed three of the more popular sequencers to inform our own work.  These assemblers are:

 *	Bowtie (4)
 *	BWA (5)
 *	Velvet (6)

Materials and Methods
---------------------
### Graph Representation
In order to apply the LocalSearch and Firefly algorithms to an assembly task we must first represent the assembly as a graph.  An intuitive method of accomplishing this is shown below.

![Overlaps Graph](example_graph.png "Overlaps Graph")

In this example, each node in the graph represents a short read.  The edges connecting the nodes represent overlaps.  For instance, the overlap between the first node and the second is 14 base pairs, the second and the third 9, etc.  The challenge of assembly then becomes finding a path through the graph that connects all the nodes and is as "long" as possible (contains the greatest possible number of overlaps).

In this example by simply choosing the path that connects all of the nodes vertically an optimal alignment can be generated.  However, with tens of thousands of reads and much more complex overlaps the process can become very difficult.

### LocalSearch Algorithm
The LocalSearch algorithm works by taking an initial path and then trying different variations on it to find a more efficient graph traversal.  In the example below the two edges connecting the central point from above are replaced by edges connecting the point from below, leading to a more efficient final path.  Local search is a well-established algorithm that can find a reasonably good solution in a short amount of time.

![LocalSearch Example](localsearch_example.png "LocalSearch Example")

*LocalSearch example, photo courtesy http://www.cs.berkeley.edu/~vazirani/algorithms/chap9.pdf*

### Firefly Algorithm
The firefly algorithm is a novel approach to solving a graph-traversal problem.  A number of random paths through the graph are generated, and each one is called a "firefly".  Each random result is then evaluated to see how effectively it solved the problem.  Typically, these early solutions are quite poor.  However, the algorithm starts "moving" the fireflies (changing the paths) toward other fireflies that are better paths.  The better a path is, the more the other fireflies will be attracted to it, just as real fireflies are attracted by other bright fireflies.

In this way the paths all begin converging on the most optimal solution, which is an effective path traversal or, as in our case, a good alignment.

The Firefly algorithm also has the significant advantage of being easily parallelizable.  All the fireflies can be moved independently of each other, and as a result the process can easily be scaled to large clusters of machines for faster assembly.

### Choice of Language
We chose to implement our sequencer in C++.  C++ is a mature language with nearly ubiquitous cross-platform support.  It also benefits from a structure very conducive to optimization and many years of performance research.  Although we did little to optimize our actual algorithm implementations by programming them in C++ we were able to achieve more reasonable performance and create a solid foundation for future work.
