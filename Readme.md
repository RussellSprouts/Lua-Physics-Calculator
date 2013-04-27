Lua Physics Calculator
=============================
A simple calculator REPL-based calculator for physics
that handles units correctly.






Installation:
==============================
You need Lua and the Lua Standard Library.
(Lua for Windows)[https://code.google.com/p/luaforwindows/] includes this.
Add the command line enter:

    > lua -i physics.lua
    
    
Sample Usage:
=================================
    > lua -i physics.lua
    Lua 5.1.4  Copyright (C) 1994-2008 Lua.org, PUC-Rio
    ===============================================================================
                       PHYSICS CALCULATOR v. 2.0 by Ryan Russell
    ===============================================================================
    Help topics:
      prefixes
    type help'topic' for information.
    
Setting a variable *v.A* to be 5 square meters

    > v.A = 5*m^2

Setting a distance to be .1 mm.

    > v.d = .1*mm
    
Using C = epsilon_0*A/d for parallel plate capacitors to find the
capacitance in this situation.

    > v.C = ε_0*v.A/v.d

This value is correct, but the units are confusing.

    > =v.C
    4.427e-007*A^2*kg^-1*s^4*m^-2
        
Convert the units to micro Farrads.

    > =v.C .. 'uF'
    0.4427uF
    
You can use the Lua operators `+`, `-`, `*`, '/', and `^` with their normal mathematical meanings.
The operator `..` converts a value into certain units. For example, `1*mm..'km'` will
give 1e-007km, the number of kilometers in a millimeter.

Available Units
=======================================================================
Most of the SI units and other common units are available.
  * m - meters
  * g - grams
  * s - seconds
  * A - amperes
  * K - kelvin
  * mol - moles
  * cd - candela
  * rad - radians
  * sr - steradians
  * Hz - hertz
  * N - newtons
  * Pa - pascals
  * J - joules
  * W - watts
  * C - coulombs
  * V - volts
  * F - farrads
  * Ohm - ohms (Ω)
  * S - siemens
  * Wb - webers
  * T - teslas
  * H - henry
  * lm - lumens
  * lx - lux
  * kat - katal
  * min - minutes
  * hr - hours
  * day - days
  * deg - degrees (angle)
  * ha - hectares
  * L - liters
  * tonne - tonnes (metric)
  * Ang - Ångström (Å)
  * eV - elctron volts
  * amu - atomic mass units (u)
  * mi - miles
  * ft - feet
  * inch - inches
  * lb - mass pounds
  * lbf - pounds force
  * hp - horsepower

For technical reasons, ohms, Ångströms, and inches have different symbols from normal.

Available Physical Constants
=====================================================================
  * lightspeed (c)
  * e - charge of an electron
  * G - gravitational constant
  * g_0 - standard earth gravity
  * mass_e - mass of an electron
  * mass_neutron 
  * mass_proton
  * epsilon_0 - vacuum permutivity.
  * k - Coulomb's constant
  * N_A - Avogadro's number