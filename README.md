# parrot-linear-algebra

A linear algebra library package for the Parrot Virtual Machine

## Project Goals

The goals of the Parrot-Linear-Algebra (**PLA**) project are to develop a good,
high-performance linear algebra toolset for use with the Parrot Virtual
Machine and programs which run on top of Parrot. In pursuit of these goals,
high-performance PMC matrix types will be developed, along with interfaces
to the **BLAS** and **LAPACK** libraries for high-performance operations.

In addition to these core goals, PLA may also provide a series of ancillary
tools that are similar in implementation or purpose to its core utilities.

## Status

PLA is being actively developed. It has core PMC types that build, a build
and installation system, and a growing test suite. PLA currently provides these
PMC types:

* NumMatrix2D

    A 2-D matrix containing floating point values.

* PMCMatrix2D

    A 2-D matrix containing PMC pointers

* ComplexMatrix2D

    A 2-D matrix containing Complex values, optimized to store complex values
    directly instead of using an array of Parrot's Complex PMC type.

* CharMatrix2D (Testing)

    A 2-D character matrix that doubles as an array of strings with
    fixed-row-length storage.

PLA does not yet offer matrix or tensor types with more than two dimensions. It
might never offer higher-dimensional types because BLAS and LAPACK do not use
them.

## Dependencies

PLA has several dependencies. To help manage dependencies, you may want
to install **Plumage**.

https://github.com/parrot/plumage

This is not a dependency, just a convenience. Plumage may be installed with
Parrot automatically.

Each PLA release will target different versions of the various dependencies.
See the file RELEASES for information about individual releases and their
dependencies.

Here are a list of dependencies for PLA:

* **Parrot** (3.0 or higher)

    PLA is an extension for Parrot and requires Parrot to build and run.

    http://www.parrot.org

    PLA may provide specific release packages targetting specific versions or
    version ranges of Parrot. The development version of PLA will always try to
    build against the current development version of Parrot.

    PLA expects Parrot to be built and installed on your system. It is not intended
    to run against a development repository.

* **BLAS**, **CBLAS** or **ATLAS**

    PLA depends on either BLAS, CBLAS or ATLAS. The BLAS library is written in
    Fortran, CBLAS is a translation of BLAS to the C language. Unfortunately
    there is not a good, standard way of translating the Fortran source to C
    API bindings, so not all libraries that provide a C API for BLAS will have
    an interface compatible with PLA. We are working to be more accepting of
    small differences in various interfaces, but this work is moving slowly.

    PLA should be able to use BLAS, CBLAS and ATLAS, depending on variations in
    OS, packaging and installation paths. You may need to modify the search
    logic in `setup.nqp` to find the library on your system.

    To get the ATLAS library on an Ubuntu or Debian-based system you can use
    this command:

        sudo apt-get install libatlas3-base
        sudo apt-get install libatlas-base-dev

    On Fedora you can type:

        sudo yum install atlas-devel

    Notice that the default vesions of the atlas library are only generally
    optimized. If you are able, try to use a platform-specific variant (such
    as "-sse2" or "-3dnow") for better performance. See the ATLAS homepage for
    more information:

        http://math-atlas.sourceforge.net/

    Other versions of BLAS and CBLAS can be installed in other ways.

* **LAPACK**

    LAPACK is a library of linear algebra routines which rely heavily on the
    local BLAS implementation. For more information about LAPACK, see the
    project homepage at:

        http://www.netlib.org/lapack

    LAPACK bindings are currently in development, and are not required to
    build or run PLA.

* **Rosella**

    Rosella is a collection of libraries for Parrot. Rosella is used to
    implement the unit test suite and test harness for PLA, and is used for
    some additional features. Install Rosella if you want to run the unit tests
    or build the additional features.

* Other

    Currently, PLA is only tested to build and work on Linux and other
    Unix-like systems with all the aforementioned prerequisites. The setup
    process pulls configuration information from your installed version of
    Parrot, so it will attempt to use the same compiler with the same
    compilation options as Parrot was compiled with. If another compiler
    absolutely needs to be used, there may be a way to specify that, but no
    documentation about the process exists.

## Building

To get, build, test, and install Parrot-Linear-Algebra, follow these steps
(on Linux) once all the prerequisites have been prepared:

    git clone git://github.com/Whiteknight/parrot-linear-algebra.git pla
    cd pla
    parrot-nqp setup.nqp build
    parrot-nqp setup.nqp test
    parrot-nqp setup.nqp install

Testing only works if you have Rosella installed on your system. To
install, you may need root privileges on your system. There is currently no
known way to build or deploy PLA on Windows.

## Directory Structure

    + /
        + dynext/      : Location for generated libraries
        + examples/    : Example programs in various languages
        + ports/       : Generated information about porting
        + src/         : Source code
            + include/ : Include files
            + lib/     : Library files
            + pmc/     : PMC definition files
            + nqp/     : The NQP bootstrapper
            + rakudo/  : Wrapper files for use in Rakudo Perl 6
        + t/           : Tests
            + methods/ : Tests for methods
            + pmc/     : Tests for various PMC types
            + testlib/ : Common test library

## Credits

Original versions were developed as part of the Matrixy project by Blairuk.
Some parts of the test suite were provided by Austin Hastings.
See the file CREDITS for updated information about contributors.
