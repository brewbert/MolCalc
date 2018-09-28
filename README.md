MolCalc
=======

Copyright (c) 2010-2018 Ing. Hubert HANGHOFER,
Licensed under the GPL (see sources)

This is the lua version of <https://github.com/brewbert/wxMol> as
used as a lua-module on <https://molcalc.com>

Sources are available from the repositories at

*   <https://github.com/brewbert/MolCalc> and
*   <https://bitbucket.org/brewbert/MolCalc>

Purpose and Usage
=================

MolCalc.lua is a stoichiometric compiler. It parses chemical
formulas and enables simple arithmetic calculations. For example,
to calculate the percentage of Aluminium in Alaun, you could enter:

Al2/(Al2(SO4)3+16H2O)*100

The converted input is presented along with the result, so that
you can check if the calculation was done according to your
expectations.

molcalc.lua is a module containing the parser function as used
on <https://molcalc.com> in a WSAPI-fastcgi environment.

If you need a version for your desktop, you could try
the python code <https://github.com/brewbert/wxMol>
or download the windows binaries derived thereof from:
<http://hanghofer.net/~hubert/python/>
