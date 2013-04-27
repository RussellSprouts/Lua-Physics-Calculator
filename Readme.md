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

    > v.A = 5*m^2
		> v.d = .1*mm
		> v.C = epsilon_0*v.A/v.d
		> =v.C
		4.427e-007*A^2*kg^-1*s^4*m^-2
		> =v.C .. 'uF'
		0.4427uF
		