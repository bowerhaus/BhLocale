--[[ 
BhLocale.lua

Localization features for Gideros. The advantage of this system is that, for the mostpart,
Lua code can be written normally in you native language with no consideration being given to
how it should be localized. 

When a BhLocale is installed, key system functions that take strings are replaced by our own,
which look up localized language versions using the original language string as a key. To
add new localizations simply add a new Lua file that answers a table with appropriate string mappings.
 
MIT License
Copyright (C) 2012. Andy Bower, Bowerhaus LLP

Permission is hereby granted, free of charge, to any person obtaining a copy of this software
and associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]
BhLocale = Core.class()

function BhLocale:init(forceLocale)
	-- Get the current locale, if unsupported default to en_US
	local locale=forceLocale or application:getLocale()
	self.descriptor=locale
	self.data={}
	
	local file = loadfile(pathto("Locales/"..locale..".lua"))
	if file then
		self.data = assert(file)()
		bhDebug(string.format("Installing locale: %s", locale))	
	elseif self.descriptor~="en_US" then
		BhLocale.new("en_US")
	end
	BhLocale.current=self
	
	-- For all functions accepting strings replace with our localized versions.
	-- This is a basic set; you may need to add further functions.
	-- The third parameter is a table containing integer indices identifying the
	-- function parameter that are strings that need localizing.
	--
	BhLocale.redirect(string, "format", {1})
	BhLocale.redirect(TextField, "new", {2})
	BhLocale.redirect(Texture, "new", {1})	
	BhLocale.redirect(AlertDialog, "new", {1, 2, 3, 4, 5})	
	BhLocale.redirect(TextInputDialog, "new", {1, 2, 3, 4, 5})		
end

function BhLocale.redirect(object, func, indices)
	-- Redirect functions.
	-- Thanks to Artur Sosins (AppCodingEasy) for his original implementation of this function.
	-- http://appcodingeasy.com/Gideros-Mobile/Localization-in-Gideros
	--
	if object ~= nil and object[func] ~= nil and object.__LCfunc == nil then
		object.__LCfunc = object[func]
		object[func] = function(...)
			for i,v in pairs(indices) do
				arg[v] = BhLocale.current.data[arg[v]] or arg[v]
			end
			return object.__LCfunc(unpack(arg))
		end
	end
end
