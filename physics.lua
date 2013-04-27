require'std' --for pretty printing

print[[
===============================================================================
                   PHYSICS CALCULATOR v. 2.0 by Ryan Russell
===============================================================================
Help topics:
  prefixes
type help'topic' for information.
]]

help = setmetatable({},{__call=function(help,k)help[string.lower(k)]() end})

function table.deep_copy(a)
  if type(a) ~= 'table' then return a end
	local copy = {}
	local m = getmetatable(a)
	for k,v in pairs(a) do
	  copy[k] = table.deep_copy(v)
	end
	setmetatable(copy,m)
	return copy
end

local prefixes = { 'T','G','M','k','h','da','d','c','m','u','n','p',
  k=1e3,
	M=1e6,
	G=1e9,
	T=1e12,
	da=1e1,
	h=1e2,
  d=1e-1,
	c=1e-2,
	m=1e-3,
	u=1e-6,
	n=1e-9,
	p=1e-12
}

help.prefixes = function()
  print[[
PREFIXES:]]
	for i,k in ipairs(prefixes) do
		print(string.format('  %s\t%g',k,prefixes[k]))
	end
end

local DimensionedValueMetatable = {
  __add = function(a,b)
	  a = table.deep_copy(a)
		for k,v in pairs(a.units)do
		  if b.units[k]~=v then
			  print"WARNING: Adding values with unlike units"
			end
		end
		for k,v in pairs(b.units)do
		  if a.units[k]~=v then
			  print"WARNING: Adding values with unlike units"
			end
		end
		a.value = a.value + b.value
		return a
	end,
	__sub = function(a,b)
    return a+-1*b
	end,
	__mul = function(a,b)
	  a = table.deep_copy(a)
		b = table.deep_copy(b)
		if type(a)=='number' then
		  b.value = b.value * a
		  return b
		elseif type(b)=='number' then
		  a.value = a.value * b
			return a
		else
		  for k,v in pairs(b.units) do
			  a.units[k] = (a.units[k]or 0) + v
			end
			a.value = a.value * b.value
			return a
		end
	end,
	__div = function(a,b)
	  return a*b^-1
	end,
	__pow = function(a,b)
	  a = table.deep_copy(a)
		for k,v in pairs(a.units) do
		  a.units[k] = v*b
		end
		a.value = a.value^b
		return a
	end,
	__unm = function(a)
	  return -1*a
	end,
	__concat = function(a,bString)
		assert(type(a)=='table')
		assert(type(bString)=='string')
	  a = table.deep_copy(a)
		local b = assert(loadstring('return '..bString))()
		for k,v in pairs(a.units)do
		  if b.units[k]~=v then
			  return"ERROR: Cannot convert these units. ====================="
			end
		end
		for k,v in pairs(b.units)do
		  if a.units[k]~=v then
			  return"ERROR: Cannot convert these units. ====================="
			end
		end
		return a.value/b.value .. bString
	end,
	__tostring = function(a)
	  local units = ''
		for k,v in pairs(a.units) do
		  units = units..'*'..k..(v==1 and '' or '^'..v)
		end
	  return a.value..units
	end
}

--[[
	table.insert(units,{symbol,definition})
	for i,v in ipairs(prefixes) do
	  table.insert(units,{v..symbol,definition*prefixes[v]})
	end
--]]

local baseunits = {}
units = {}
function BaseUnit(symbol)
	table.insert(baseunits, symbol)
	return setmetatable({value=1, units={[symbol]=1}},DimensionedValueMetatable)
end

function Unit(symbol, definition)
  units[symbol] = definition
  for i, prefix in ipairs(prefixes) do
    units[prefix..symbol] = definition*prefixes[prefix]
	end
end
setmetatable(_G,{__index=units})

--SI BASE UNITS
m = BaseUnit'm'
kg = BaseUnit'kg'
s = BaseUnit's'
A = BaseUnit'A'
K = BaseUnit'K'
mol = BaseUnit'mol'
cd = BaseUnit'cd'
rad = BaseUnit'rad'
sr = BaseUnit'sr'

m = Unit('m', m)
g = Unit('g', .001*kg)
s = Unit('s', s)
A = Unit('A', A)
K = Unit('K', K)
mol = Unit('mol', mol)
cd = Unit('cd', cd)
rad = Unit('rad', rad)
sr = Unit('sr', sr)

--SI NAMED UNITS
Hz = Unit('Hz', 1/s)
N = Unit('N', kg*m/s^2)
Pa = Unit('Pa', N/m^2)
J = Unit('J', N*m)
W = Unit('W', J/s)
C = Unit('C', A*s)
V = Unit('V', W/A)
F = Unit('F', C/V)
Ohm = Unit('Ohm', V/A)
S = Unit('S', A/V)
Wb = Unit('Wb', V*s)
T = Unit('T', Wb/m^2)
H = Unit('H', Wb/A)
lm = Unit('lm', cd*sr)
lx = Unit('lx', lm/m^2)
--Bq = Unit('Bq', 1/s)
--Gy = Unit('Gy', J/kg)
--Sv = Unit('Sv', J/kg)
kat = Unit('kat',mol/s)

--SI ACCEPTABLE UNITS
min = 60*s
hr = 60*min
day = 24*hr
deg = math.pi/180*rad
ha = 100*m*100*m
L = Unit('L', dm^3)
tonne = 1000*kg
Ang = 1e-10*m

--SI EXPERIMENTAL UNITS
eV = Unit('eV', 1.60217733e-19*J)
amu = 1.6605402e-27*kg


--CONVERSION UNITS
mi = 1609.344*m
ft = mi/5280
yd = 3*ft  
inch = ft/12  
lb = kg/2.20462262185  
lbf = 4.4482216152605*N  
hp = 746*W  

--PHYSICAL CONSTANTS
lightspeed = 2.99792458e8*m/s
e = eV/J*C
G = 6.67259e-11*N*m^2/kg^2
g_0 = 9.80665*N/kg
mass_e = 9.10939e-31*kg
mass_neutron = 1.67262e-27*kg
mass_proton = 1.67492e-27*kg
epsilon_0 = 8.854e-12*C^2/(N*m^2)
k = 1/4*math.pi*epsilon_0
N_A = 6.02214129e23/mol

-- USER VARIABLES:
v = {} --use v.A, for example, so store an Area.