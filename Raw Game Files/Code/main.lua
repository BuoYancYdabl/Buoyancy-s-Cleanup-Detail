-- title:  BuoYancY's Cleanup Detail
-- author: BuoYancY_dabl
-- desc:   You are a janitor! Cleanup the facility. But this isnt a common facility...
-- script: lua
-- saveid: MD9goto/0001
-- ver:    1.0.0

--[[
MIT License

Copyright (c) 2019 Dmytro Yatsuk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--

--A X Z

----------------------------------------
----------update proccess bank----------
---you can see other banks functions----
----if you has pro version of TIC-80----
----------------------------------------

--map editing:
----------------------------------------
--[[
Choose a paint tool and make a walls/static objects
Select a fill tool and fill empty space by tiles (by carefull - you can fill all map)
Set player spawnpoint at map (240 id sprite). Not recomended to set more or less than 1 spawnpoint.
To set custom physics objects set it on map then enter in "local objects_physics_id" data that specified upper data
To avoid huge lags dont set blood qt more than 10000 and less than 1 (you can disable blood by option, not by setting it value to zero)
--]]
----------------------------------------

--runs all the activities 60 times per second
function TIC()
 mainActivity()
 getControls()
 player_additionalAnim()
	player_flooring()
	collisionLauncher()
	player_snifferEnabled()
	cameraMovement()
	getFps()
	overlay()
	func_disable()
end