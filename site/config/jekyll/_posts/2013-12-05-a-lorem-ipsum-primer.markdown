---
layout: post
published: true
title: A Lorem Ipsum Primer
---
Abstract
--------
Our purpose is to create a genome assembler based on a novel approach called the Firefly Algorithm (1).  We hypothesize that this will produce more accurate assemblies than other assemblers.

Introduction
------------
In the last decade genome sequencing data has exploded.  Thanks to hardware innovations such as 454 and Illumina sequencing the amount of DNA sequence data that is being generated each year is increasing exponentially.

As a result of this explosion of data new techniques are being developed to assemble the short and at times error-prone reads produced by these sequencers.  Currently the computational time required to accurately assemble a genome pro novo is a significant bottleneck in bioinformatics.  Algorithms exist that can assemble a genome in a relatively short time, but these algorithms typically are not able to guarantee an accurate assembly.  Conversely, algorithms exist that can guarantee an accurate assembly of reads but that are unacceptably inefficient.

Extensive work has been done in the field of computer science toward solving extremely difficult problems such as the Travelling Salesman Problem (TSP).  In brief, TSP involves finding the shortest route that an imaginary “salesman” might take between large numbers of cities while visiting each city exactly once.  This is a problem that has been extensively investigated for years, and many solutions have been proposed that can generate a near-optimal solution in reasonable timeframes (2).

By modeling genome assembly as a travelling salesman problem, we have been able to investigate the use of some of these established algorithms for this purpose.  This paper introduces techniques to model read alignment as a graph traversal problem and explores the use of the Firefly and LocalSearch algorithms in assembly.
