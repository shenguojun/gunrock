Gunrock documentation
=====================

Introduction
============

Gunrock is a CUDA library for graph primitives that refactors,
integrates, and generalizes best-of-class GPU implementations
of breadth-first search, connected components, and betweenness
centrality into a unified code base useful for future
development of high-performance GPU graph primitives.

Home Page
---------

Homepage for Gunrock: <http://gunrock.github.io/>

Getting Started with Gunrock
----------------------------
For Frequently Asked Questions, see [FAQ](http://gunrock.github.io/gunrock/doc/0.1/faq.html).

For information on building Gunrock, see [Building Gunrock](http://gunrock.github.io/gunrock/doc/0.1/building_gunrock.html)
and refer to [Operating System Support and Requirements](https://github.com/gunrock/gunrock#operating-system-support-and-requirements).

The "tests" subdirectory included with Gunrock has a comprehensive test
application for all the functionality of Gunrock.

For the programming model we use in Gunrock, see [Programming Model](http://gunrock.github.io/gunrock/doc/0.1/programming_model.html).

We have also provided a code walkthrough of a [simple example](http://gunrock.github.io/gunrock/doc/0.1/simple_example.html).

Reporting Problems
==================

To report Gunrock bugs or request features, please file an issue
directly using [Github](https://github.com/gunrock/gunrock/issues).

<!-- TODO: Algorithm Input Size Limitations -->

Operating System Support and Requirements
=========================================

This release (0.2) has only been tested on Linux Mint 15 (64-bit) with
CUDA 6.0 installed. We expect Gunrock to build and run correctly on
other 64-bit and 32-bit Linux distributions, Mac OS, and Windows.

Requirements
------------

Gunrock has not been tested with any CUDA version < 5.5.

Several graph primitives' CPU validation code uses Boost Graph Library v1.53.0.

CUDA
====

Gunrock is implemented in [CUDA C/C++](http://developer.nvidia.com/cuda).  It
requires the CUDA Toolkit. Please see the NVIDIA
[CUDA](http://developer.nvidia.com/cuda-downloads) homepage to download CUDA as
well as the CUDA Programming Guide and CUDA SDK, which includes many CUDA code
examples. Please refer to [NVIDIA CUDA Getting Started Guide for
Linux](http://docs.nvidia.com/cuda/cuda-getting-started-guide-for-linux) for
detailed information.


Design Goals
============

Gunrock aims to provide a core set of vertex-centric or edge-centric
operators for solving graph related problems and use these
parallel-friendly abstractions to improve programmer productivity
while maintaining high performance.

Road Map
========

 - Framework: The structure of the operator code in Gunrock may change
   significantly during near-term future development. Generally we
   want to find the right set of operators that can abstract most
   graph primitives while delivering high performance.

 - Primitives: Our near-term goal is to implement minimal spanning tree algorithm, build better support for bipartite graph algorithms, and explore community detection algorithms. The long term goal includes algorithms on dynamic graphs, priority queue support, graph partitioning and multi-GPU algorithms.

Credits
=======

Gunrock Developers
------------------

- [Yangzihao Wang](http://www.idav.ucdavis.edu/~yzhwang/), University of
  California, Davis

- Yuechao Pan, University of
  California, Davis

- [Yuduo Wu](http://www.ece.ucdavis.edu/~wyd855/), University of California, Davis

- Andy Riffel, University of California, Davis

- [John Owens](http://www.ece.ucdavis.edu/~jowens/), University of California,
  Davis

Acknowledgements
----------------

Thanks to the following developers who contributed code: The
connected-component implementation was derived from code written by
Jyothish Soman, Kothapalli Kishore, and P. J. Narayanan and described
in their IPDPSW '10 paper *A Fast GPU Algorithm for Graph
Connectivity* ([DOI](http://dx.doi.org/10.1109/IPDPSW.2010.5470817)).
The breadth-first search implementation and many of the utility
functions in Gunrock are derived from the
[b40c](http://code.google.com/p/back40computing/) library of
[Duane Merrill](https://sites.google.com/site/duanemerrill/). The
algorithm is described in his PPoPP '12 paper *Scalable GPU Graph
Traversal* ([DOI](http://dx.doi.org/10.1145/2370036.2145832)). Thanks
to Erich Elsen and Vishal Vaidyanathan from
[Royal Caliber](http://www.royal-caliber.com/) for their discussion on
library development and the dataset auto-generating code.

This work was funded by the DARPA XDATA program under AFRL Contract
FA8750-13-C-0002 and by NSF awards CCF-1017399 and OCI-1032859. Our
XDATA principal investigator is Eric Whyne of
[Data Tactics Corporation](http://www.data-tactics.com/) and our DARPA
program manager is
[Dr. Christopher White](http://www.darpa.mil/Our_Work/I2O/Personnel/Dr_Christopher_White.aspx).

Gunrock Copyright and Software License
======================================

Gunrock is copyright The Regents of the University of
California, 2013. The library, examples, and all source code are
released under
[Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0).
