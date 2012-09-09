BhLocale for Gideros
====================

Localization features for Gideros. The advantage of this system is that, for the mostpart,
Lua code can be written normally in you native language with no consideration being given to
how it should be localized. When a BhLocale is installed, key system functions that take strings are replaced by our own, which look up localized language versions using the original language string as a key. To add new localizations simply add a new Lua file that answers a table with appropriate string mappings.

Folder Structure
----------------

This module is referenced by the general Bowerhaus library for Gideros mobile. There are a number of cooperating modules in the Bowerhaus library, each with it's own Git repository. In order that the example project files will run correctly "out of the box" you should create an appropriate directory structure and clone/copy the files within it.

###/MyDocs
Place your own projects in folders below here

###/MyDocs/Library
Folder for library modules

###/MyDocs/Library/Bowerhaus
Folder containing sub-folders for all other Bowerhaus libraries

###/MyDocs/Library/Bowerhaus/BhLocale
Folder for THIS MODULE



