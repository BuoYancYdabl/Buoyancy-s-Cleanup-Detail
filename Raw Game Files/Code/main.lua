-- title:  BuoYancY's Cleanup Detail
-- author: BuoYancY_dabl
-- desc:   You are a janitor! Cleanup the facility. But this isnt a common facility...
-- script: lua
-- saveid: MD9goto/0000
-- ver:    v1.0.1

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

function TIC()

 m.x,m.y,m.bl,m.bm,m.br=mouse()

 if keyboard.isCalled==true then
	 keyboard_action()
	end

 if main.menu==true then
	 m.dem=1
	elseif main.mapChoose==true then
	 m.dem=2
	elseif main.game==true then
	 m.dem=0
	elseif main.tablet==true then
	 m.dem=3
	elseif main.settings==true then
	 m.dem=4
	elseif main.inventory==true then
	 m.dem=5
	elseif main.pause==true then
	 m.dem=6
	end

 --detecting player mouse presings
 if m.bl==true and m.tl==true and keyboard.isCalled==false then
	 if mapc.generating==false or main.menu==true or main.mapChoose==true or main.tablet==true or main.settings==true then
			if m.bl==true and p.use=="" and main.isPc==true then
	 	 p.animTimer=time()+500
 	  p.use="prim"
 	  player_isDo(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
   end
			m.tl=false
		 for i=1,m.totalButtons do
		  if m.x>btns[i][1] and m.x<btns[i][1]+btns[i][3] and m.y>btns[i][2] and m.y<btns[i][2]+btns[i][4] and btns[i][11]==m.dem then
			  if main.tablet==false then
		 			m.ind=i
	 	 		buttonsCheck()
		   	break
					elseif btns[i][13]==tablet.dem or btns[i][13]==-1 then
						m.ind=i
						buttonsCheck()
					 break
					end
				end
 		end
	 end
 end
	if m.br==true and m.tr==true then
	 if m.br==true and p.use=="" and main.isPc==true and p.isMop==false then
	  p.animTimer=time()+500
 	 p.use="alt"
	  player_isDo(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
	 end
		m.tr=false
	end

 t=t+1

 if mapc.generating==true and main.game==true then
	 generation()
	end

 --counting fps
 if fps.timer>time() then
	 fps.count=fps.count+1
	else
	 fps.timer=time()+1000
	 fps.value=fps.count
		fps.count=0
	end

 if main.game==true then
  if p.animTimer<time() then
	  p.use=""
 	end

  if p.isHold==true then
		 if p.angle==0 then
			 var1=4
				var2=10
			elseif p.angle==1 then
			 var1=-2
				var2=4
			elseif p.angle==2 then
			 var1=4
				var2=-2
			else
			 var1=10
				var2=4
			end
	 	o[p.objectID][2]=p.x+var1+p.vx
		 o[p.objectID][3]=p.y+var2+p.vy
			o[p.objectID][7]=p.angle
			p.humanHold=p.objectID
		end

	 if dispensers.timer<122 then
		 dispensers.timer=dispensers.timer+1
			if dispensers.timer==1 then
		 	if o[dispensers.dispenser][12]=="dispenser trash" then
 		 	if o[dispensers.dispenser][7]==0 or o[dispensers.dispenser][7]==2 then
		 	  var1=-0.1
			 	 var2=0
	  		else
		  	 var1=0
	 		 	var2=-0.1
		  	end
				elseif o[dispensers.dispenser][12]=="dispenser water" then
				 var3=dispensers.dispenser
					if o[var3][7]==0 then
					 var1=0.1
						var2=0
					elseif o[var3][7]==1 then
					 var1=0
						var2=0.1
					elseif o[var3][7]==2 then
					 var1=-0.1
						var2=0
					else
					 var1=0
						var2=-0.1
					end
				end
			elseif dispensers.timer==122 and o[dispensers.object][12]~="bin" and o[dispensers.object][12]~="bucket" then
			 bloodTotal=bloodTotal+1
				blood[bloodTotal]={}
				blood[bloodTotal][1]=o[dispensers.object][2]
				blood[bloodTotal][2]=o[dispensers.object][3]
				blood[bloodTotal][3]=math.random(0,3)
				blood[bloodTotal][4]=260
			else
			 if settings.sounds==true then
			 	sfxPlay(6,"C-1",-1,1,15,0,-3)
				end
			 o[dispensers.object][2]=o[dispensers.object][2]+var1
		  o[dispensers.object][3]=o[dispensers.object][3]+var2
			end
		end

  if main.isPc==false then
		 if mapc.generating==false and keyboard.isCalled==false then
    if btn(0) then
	    p.vy=-1
 		  p.angle=2
   	elseif btn(1) then
	    p.vy=1
		   p.angle=0
   	else
	    p.vy=0
 	  end
 	  if btn(2) then
	    p.vx=-1
 		  p.angle=1
   	elseif btn(3) then
	   	p.vx=1
	   	p.angle=3
  		else
	    p.vx=0
 	  end
 	 	if btnp(4) and p.use=="" then
 	 	 p.animTimer=time()+500
	 	 	p.use="prim"
		 	 player_isDo(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
 		 elseif btnp(5) and p.use=="" and p.isMop==false then
	 	  p.animTimer=time()+500
 		 	p.use="alt"
	 	  player_isDo(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
 	  elseif btnp(6) and p.use=="" then
					p.use="use"
					if p.isMop==true then
					 p.animTimer=time()+500
					end
					player_isDo(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
				end
	 	 if btnp(7) and p.use=="" and p.isHold==false then
		   player_changeInstrument()
  		end
	  end
	 else
 	 if mapc.generating==false and keyboard.isCalled==false then
    if key(23) then
	    p.vy=-1
 		  p.angle=2
   	elseif key(19) then
	    p.vy=1
		   p.angle=0
  	 else
 	   p.vy=0
  	 end
 	  if key(1) then
	    p.vx=-1
 		  p.angle=1
   	elseif key(4) then
	   	p.vx=1
	   	p.angle=3
  		else
	    p.vx=0
 	  end
	 	 if keyp(17) and p.use=="" and p.isHold==false then
		   player_changeInstrument()
  		end
				if keyp(5) and p.use=="" then
				 p.use="use"
					if p.isMop==true then
					 p.animTimer=time()+500
					end
					player_isDo(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
	   end
			end
	 end

  player_flooring()

  if p.vx~=0 or p.vy~=0 then
	  p.isMove=true
 	else
	  p.isMove=false
 	end

  if p.vx~=0 or p.vy~=0 then
   collisionCheck()
			if bloodTotal<bloodLimit and p.isMove==true then
	  	func_footprint()
			end
	 end

  p.x=p.x+p.vx
	 p.y=p.y+p.vy

  if p.isDetector==true and sniffer.isBloodOn==true or sniffer.isTrashOn==true then
		 player_detect()
		end

  if mapc.camX~=p.x or mapc.camY~=p.y then
   mapc.camVX=(p.x-mapc.camX)/10
			mapc.camVY=(p.y-mapc.camY)/10

   mapc.camX=mapc.camX+mapc.camVX
	 	mapc.camY=mapc.camY+mapc.camVY

   if mapc.camVX<0.1 and mapc.camVX>-0.1 then
	 	 mapc.camVX=0
		 	mapc.camX=p.x
	 	end
	 	if mapc.camVY<0.1 and mapc.camVY>-0.1 then
			 mapc.camVY=0
				mapc.camY=p.y
			end
		end

	end
	overlay()

	func_disable()
end
