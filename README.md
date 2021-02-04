MolCalc
=======

Copyright (c) 2010-2018 Ing. Hubert HANGHOFER,
Licensed under the GPL (see sources)

This is the [lua version](https://www.lua.org/) of <https://github.com/brewbert/wxMol> as
used as lua-module on <https://molcalc.com>

Sources are available from the repositories at

*   <https://github.com/brewbert/MolCalc> and
*   <https://bitbucket.org/brewbert/MolCalc>

Purpose and Usage
=================

MolCalc is a stoichiometric parser. It translates chemical element
symbols to their corresponding atomic weights and enables simple
arithmetic calculations. For example, to calculate the percentage
of Aluminium in Aluminiumsulfate-Hexadecahydrate, you could enter:

Al2/(Al2(SO4)3+16H2O)%

The converted input is returned along with the result, so that
you can check if the calculation was done according to your
expectations. MolCalc checks for bracketing (parenthesis) and
symbol errors but doesn't detect, if a chemical formula is
valid or your computations make sense.

molcalc.lua is a module containing the parser function as used
on <https://molcalc.com> in a [WSAPI-fastcgi environment](https://keplerproject.github.io/wsapi/index.html).

If you need a version for your desktop, you could try
the [python code](https://github.com/brewbert/wxMol)
or download the packages or windows binaries derived thereof from:
<http://hanghofer.net/~hubert/python/>
