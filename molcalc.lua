#!/usr/bin/env lua
--[[
Copyright 2002-2018 Hubert Hanghofer -- hanghofer.net
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]

local _M = {}

_M.Element = {
H=1.00794,
D=2.014102, 
He=4.002602,
Li=6.941,
Be=9.012182,
B=10.811,
C=12.0107,
N=14.00674,
O=15.9994,
F=18.9984032,
Ne=20.1797,
Na=22.989770,
Mg=24.3050,
Al=26.981538,
Si=28.0855,
P=30.973761,
S=32.066,
Cl=35.4527,
Ar=39.948,
K=39.0983,
Ca=40.078,
Sc=44.955910,
Ti=47.867,
V=50.9415,
Cr=51.9961,
Mn=54.938049,
Fe=55.845,
Co=58.933200,
Ni=58.6934,
Cu=63.546,
Zn=65.39,
Ga=69.723,
Ge=72.61,
As=74.92160,
Se=78.96,
Br=79.904,
Kr=83.80,
Rb=85.4678,
Sr=87.62,
Y=88.90585,
Zr=91.224,
Nb=92.90638,
Mo=95.94,
Tc=98.0,
Ru=101.07,
Rh=102.90550,
Pd=106.42,
Ag=107.8682,
Cd=112.411,
In=114.818,
Sn=118.710,
Sb=121.760,
Te=127.60,
I=126.90447,
Xe=131.29,
Cs=132.90545,
Ba=137.327,
La=138.9055,
Ce=140.116,
Pr=140.90765,
Nd=144.24,
Pm=145.0,
Sm=150.36,
Eu=151.964,
Gd=157.25,
Tb=158.92534,
Dy=162.50,
Ho=164.93032,
Er=167.26,
Tm=168.93421,
Yb=173.04,
Lu=174.967,
Hf=178.49,
Ta=180.9479,
W=183.84,
Re=186.207,
Os=190.23,
Ir=192.217,
Pt=195.078,
Au=196.96655,
Hg=200.59,
Tl=204.3833,
Pb=207.2,
Bi=208.98038,
Po=209.0,
At=210.0,
Rn=222.0,
Fr=223.0,
Ra=226.0,
Ac=227.0,
Th=232.0381,
Pa=231.03588,
U=238.0289,
Np=237.0,
Pu=244.0,
Am=243.0,
Cm=247.0,
Bk=247.0,
Cf=251.0,
Es=252.0,
Fm=257.0,
Md=258.0,
No=259.0,
Lr=262.0,
Rf=261.0,
Db=262.0,
Sg=266.0,
Bh=264.0,
Hs=269.0,
Mt=268.0,
Uun=271.0,
Uuu=272.0
}



_M.Digit = {
    ['1']='1', ['2']='2', ['3']='3',
    ['4']='4', ['5']='5', ['6']='6',
    ['7']='7', ['8']='8', ['9']='9',
    ['0']='0',
    ['.']='.',
    [',']='.'   -- decimal comma is silently converted
}



_M.Uppercase = {
    A='A', B='B', C='C', D='D',
    E='E', F='F', G='G', H='H',
    I='I', J='J', K='K', L='L',
    M='M', N='N', O='O', P='P',
    Q='Q', R='R', S='S', T='T',
    U='U', V='V', W='W', X='X',
    Y='Y', Z='Z'
}



_M.Lowercase = {
    a='a', b='b', c='c', d='d',
    e='e', f='f', g='g', h='h',
    i='i', j='j', k='k', l='l',
    m='m', n='n', o='o', p='p',
    q='q', r='r', s='s', t='t',
    u='u', v='v', w='w', x='x',
    y='y', z='z'
}



_M.Operator = {   [' ']='',
    ['*']='*', ['/']='/',
    ['+']='+', ['-']='-',
}



_M.err = false


--[[*************************
StoichCalc(s) Parser function
*****************************]]
function _M.StoichCalc(s)

local i, j = 1, 1   -- string iterators
local l = string.len(s)
-- buffers holding element symbol and digits
local el, nr = false, false
-- are we scanning a chemical formula or a mathematical expression?
local f = false
-- buffers holding current character and output
local c, out = '', ''

-- main loop
while i <= l do
    c = string.sub(s, i, j)
    if _M.Digit[c] then
        if el then out = out..(_M.Element[el] or "??")..'*'; el = false
        elseif string.len(out)>1 and string.sub(out, -1) == ')' then
            out = out..'*'
        elseif f and not nr then out = out..')'; f = false
        end
        nr = nr and nr.._M.Digit[c] or _M.Digit[c]
    elseif _M.Uppercase[c] then
        if el then out = out..(_M.Element[el] or "??")..'+'
        elseif nr then
            if f then out = out..nr..'+'
            else out = out..nr..'*'
            end
            nr = false
        end
        if not f then out = out..'('; f = true end
        repeat
            j = j+1
            el = string.sub(s, j, j)
        until (not _M.Lowercase[el])
        el = string.sub(s, i, j-1)
    elseif c == '(' then
        if nr then out = out..nr..'+'; nr = false
        elseif el then out = out..(_M.Element[el] or "??")..'+'; el = false
        end
        out = out..c
    elseif c == ')' then
        if nr then out = out..nr; nr = false
        elseif el then out = out..(_M.Element[el] or "??"); el = false
        end
        out = out..c
    elseif _M.Operator[c] then
        if nr then out = out..nr; nr = false
        elseif el then out = out..(_M.Element[el] or "??"); el = false
        end
        if f then out = out..')'; f = false end
        out = out..c
    else
        out = out .. "?"
    end --if
    if (j>i) then i=j; else i=i+1; j=i; end
end -- main loop

-- finish unparsed tokens
    if nr then out = out..nr
        elseif el then out = out..(_M.Element[el] or "??")
    end

    if f then out = out..')' end

-- basic error handling of bracketing, wrong symbols and runtime errors
    local result = ''
    local nLB, nRB

    if #out > 0 then
        _, nLB = string.gsub(out, "%(", "")
        _, nRB = string.gsub(out, "%)", "")
        if not (nLB == nRB) then
            _M.err=true; result = result .. "Error parsing input - check brackets in translation! Found " .. nLB .. "( and " .. nRB .. ")! "
        end
        if string.find(out, "%?") then
            _M.err=true; result = result .. "Error parsing element symbols - check translation for ?? "
        end
    end

    if not _M.err then
        local success
        success, result = pcall(loadstring("return " .. out))
        if not success then
            _M.err=true
            result = "Syntax error! Check computed translation!"
        end
    end

return out, result
end --function StoichCalc()



--[[**************************************
Cli() Command Line Interface and debugging
******************************************]]
function _M.Cli(s)
    -- initialize formula string that we have to parse
    local input = s
    if not input then
        print "Enter formula: "
        input = io.read()
    end
    return _M.StoichCalc(input)
end --function Cli()



return _M
