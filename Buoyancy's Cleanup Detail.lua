-- title:  BuoYancY's Cleanup Detail
-- author: BuoYancY_dabl
-- desc:   You are a janitor! Cleanup a place!
-- script: lua
-- saveid: MD9goto/0000
-- ver:    0.0.0 Pre-Alpha

----------------------------------------
--players config:
--set custom quantity of blood (not recomended to set over 10000!)
local pset_blood=400
--set custom quantity of trash
local pset_trash=100
--disable loading (disable blood, wahsing,trash and other object spawmning even a player)
local pset_loadingSkip=false
--setting custom shell spawners quantity
local pset_shellSpawner=10
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

function blood_check(x,y)
 return solids[mget((x)//8,(y)//8)]
end

local textlenght={}
local blood={}
local bloodTotal=0
local text_loading="asseting blood..."
local o={}
local shells={}

--x,y,w,h,sprId,alpha,size
local btns={{224,0,16,16,384,11,2}}

local m={
x=-1,
y=-1,
p=false,
t=true,
ind=0,
totalButtons=0,
}

local p={
x=0,
y=0,
vx=0,
vy=0,
size=15,
angle=0,
isMove=false,
isHands=false,
isMop=true,
isDetector=false,
isTablet=false,
animTimer=0,
use="",
}

local objData={
total=0,
trashDiapasone_low=0,
trashDiapasone_max=0,
}

local fps={
count=0,
timer=1000,
value=60,
}

local colp={
trx=0,
try=0,
ru=0,
rd=0,
lu=0,
ld=0,
tl=0,
tr=0,
bl=0,
br=0,
r=false,
l=false,
t=false,
b=false,
}

local mapc={
generating=true,
generating_Blood=true,
generating_Trash=false,
generating_Shells=false,
badBlood=0,
badTrash=0,
badShells=0,
shellsSpawner=0,
}

local t=0
local bloodRemain=0
local version="Pre-Alpha 0.0.0"
local build=0

function overlay()
 cls()
	map(0,0,240,136,-p.x+112,-p.y+56)
	for i=1,bloodTotal do
 	if blood[i][1]>p.x-120 and blood[i][1]<p.x+128 and blood[i][2]>p.y-64 and blood[i][2]<p.y+80 then
	  spr(260,blood[i][1]-p.x+112,blood[i][2]-p.y+56,11,1,0,blood[i][3])
	 end
	end
 for i=1,objData.total do
	 if o[i][2]>p.x-112-o[i][8]*8 and o[i][2]<p.x+128 and o[i][3]>p.y-56-o[i][9]*8 and o[i][3]<p.y+80 then
	  spr(o[i][1],o[i][2]-p.x+112,o[i][3]-p.y+56,o[i][4],o[i][5],o[i][6],o[i][7],o[i][8],o[i][9])
 	end
	end
	if p.isMove==false then
	 spr(256,112,56,11,1,0,p.angle,2,2)
	 if p.use=="" then
		 player_hudIdle()
		end
	else
	 if p.angle==0 or p.angle==2 then
		 var=1
		else
		 var=2
		end
	 if t%60//15==1 or t%60//15==3 then
		 spr(258,112,56,11,1,t%60//30*var,p.angle,2,2)
		else
		 spr(256,112,56,11,1,0,p.angle,2,2)
		end
		if p.use=="" then
	 	player_hudMove()
		end
	end
	if p.use~="" then
	 player_hudactivity(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
	end
 for i=1,m.totalButtons do
	 spr(btns[i][5],btns[i][1],btns[i][2],btns[i][6],btns[i][7])
	end
	if p.isMop==true then
	 textlenght[4]=print(instr.."Mop",180-textlenght[4]//2,128)
	elseif p.isHands==true then
	 textlenght[4]=print(instr.."None",180-textlenght[4]//2,128)
	elseif p.isDetector==true then
	 textlenght[4]=print(instr.."Snifer",180-textlenght[4]//2,128)
	else
	 textlenght[4]=print(instr.."Tablet",180-textlenght[4]//2,128)
	end
	textlenght[1]=print(version.." Build "..build,120-textlenght[1]//2,0)
	print("fps: "..fps.value,200,0,14)
end

function generation()
 cls()
	textlenght[2]=print("Loading...",120-textlenght[2]//2,56,15,false,4)
	rect(15,99,210,18,1)
	if mapc.generating_Blood==true then
	 rect(16,100,208*(1.0-mapc.badBlood/bloodTotal),16,11)
	elseif mapc.generating_Trash==true then
	 text_loading="asseting trash..."
		rect(16,100,208*(1.0-mapc.badTrash/(objData.trashDiapasone_max-objData.trashDiapasone_low)),16,11)
	elseif mapc.generating_Shells==true then
	 text_loading="asseting shells..."
	 rect(16,100,208*(1.0-mapc.badShells/20),16,11)
	end
	mapc.badBlood=0
	mapc.badTrash=0
	mapc.badShells=0
	textlenght[3]=print(text_loading,120-textlenght[3]//2,102,14,false,2)
	if mapc.generating_Blood==true then
 	for i=1,bloodTotal do
 		if	blood_check(blood[i][1],blood[i][2]) or blood_check(blood[i][1]+7,blood[i][2]) or
   blood_check(blood[i][1],blood[i][2]+7) or blood_check(blood[i][1]+7,blood[i][2]+7) then
				blood[i][1]=math.random(0,240*8)
    blood[i][2]=math.random(0,136*8)
 	  mapc.badBlood=mapc.badBlood+1
			end
	 end
		for i=1,bloodTotal do
			for b=1,objData.total do
	 	 if o[b][11]==false then
  			if blood[i][1]+8>o[b][2] and blood[i][1]<o[b][2]+15 and
	  		blood[i][2]+8>o[b][3] and blood[i][2]<o[b][3]+15 then
		  		blood[i][1]=math.random(0,240*8)
      blood[i][2]=math.random(0,136*8)
 	    mapc.badBlood=mapc.badBlood+1
	    end
				end
			end
		end
		if mapc.badBlood==0 then
	  mapc.generating_Blood=false
			mapc.generating_Trash=true
	 end
	elseif mapc.generating_Trash==true then
	 for i=objData.trashDiapasone_low,objData.trashDiapasone_max do
		 if blood_check(o[i][2],o[i][3]) or blood_check(o[i][2]+7,o[i][3]) or
 	 blood_check(o[i][2],o[i][3]+7) or blood_check(o[i][2]+7,o[i][3]+7) then 
 	  o[i][2]=math.random(0,240*8)
				o[i][3]=math.random(0,136*8)
				mapc.badTrash=mapc.badTrash+1
			end
		end
		for i=objData.trashDiapasone_low,objData.trashDiapasone_max do
			for b=1,objData.total do
	 	 if o[b][11]==false then
  			if o[i][2]+8>o[b][2] and o[i][2]<o[b][2]+15 and
	  		o[i][3]+8>o[b][3] and o[i][3]<o[b][3]+15 then
		  		o[i][2]=math.random(0,240*8)
      o[i][3]=math.random(0,136*8)
 	    mapc.badTrash=mapc.badTrash+1
	    end
				end
			end
		end
		if mapc.badTrash==0 then
		 mapc.generating_Shells=true
			mapc.generating_Trash=false
		end
	elseif mapc.generating_Shells==true then
		for i=1,pset_shellSpawner do
 	 if blood_check(shells[i][2],shells[i][3]) or blood_check(shells[i][2]+7,shells[i][3])
	 	or blood_check(shells[i][2],shells[i][3]+7) or blood_check(shells[i][2]+7,shells[i][3]+7) then
		  shells[i][2]=math.random(0,240*8)
		 	shells[i][3]=math.random(0,136*8)
				mapc.badShells=mapc.badShells+1
			end
		end
		for i=1,pset_shellSpawner do
			for b=1,objData.total do
	 	 if o[b][11]==false then
  			if shells[i][2]+16>o[b][2] and shells[i][2]<o[b][2]+23 and
	  		shells[i][3]+16>o[b][3] and shells[i][3]<o[b][3]+23 then
		  		shells[i][2]=math.random(0,240*8)
      shells[i][3]=math.random(0,136*8)
 	    mapc.badShells=mapc.badShells+1
	    end
				end
			end
		end
		if mapc.badShells==0 then
		 for i=1,pset_shellSpawner do
			 math_random=math.random(7,14)
				for b=1,1000 do
				 if o[b]==nil then
					 for z=b,math_random+b do
							o[z]={}
							o[z][2]=math.random(shells[i][2]-8,shells[i][2]+8)
							o[z][3]=math.random(shells[i][3]-8,shells[i][3]+8)
							o[z][4]=11
							o[z][5]=1
							o[z][6]=0
							o[z][7]=math.random(0,3)
							o[z][8]=1
							o[z][9]=1
							o[z][10]=false
							o[z][11]=true
							if shells[i][1]==1 then
							 o[z][1]=math.random(280,281)
								o[z][12]="shell 5x74"
							else
							 o[z][1]=math.random(282,283)
								o[z][12]="shell shotgun"
							end
							objData.total=objData.total+1
						end
						break
					end
				end
			 for i=1,objData.total do
				 if o[i][12]=="shell 5x74" or o[i][12]=="shell shotgun" then
					 if blood_check(o[i][2],o[i][3]) or blood_check(o[i][2]+7,o[i][3])
						or blood_check(o[i][2],o[i][3]+7) or blood_check(o[i][2]+7,o[i][3]+7) then
 						for b=i,objData.total-1 do
	 					 o[b][1]=o[b+1][1]
		 			  o[b][2]=o[b+1][2]
			 		  o[b][3]=o[b+1][3]
				 	  o[b][4]=o[b+1][4]
					 		o[b][5]=o[b+1][5]
					   o[b][6]=o[b+1][6]
					   o[b][7]=o[b+1][7]
 					  o[b][8]=o[b+1][8]
	 						o[b][9]=o[b+1][9]
		 			  o[b][10]=o[b+1][10]
			 		  o[b][11]=o[b+1][11]
				 	  o[b][12]=o[b+1][12]
					 	end
						 objData.total=objData.total-1
 					end
	 			end
		 	end
			end
			mapc.generating=false
			solids[0]=nil
		end
	end
end

function player_changeInstrument()
 if p.isMop==true then
	 p.isMop=false
		p.isHands=true
 elseif p.isHands==true then
	 p.isHands=false
		p.isDetector=true
	elseif p.isDetector==true then
	 p.isDetector=false
		p.isTablet=true
	else
	 p.isTablet=false
		p.isMop=true
	end
end

function player_hudMove()
 if p.isMop==true then
	 spr(402,112,56,11,1,0,p.angle,2,2)
	elseif p.isHands==true then
	 if t%60//15==1 or t%60//15==3 then
	  spr(400,112,56,11,1,t%60//30*var,p.angle,2,2)
	 else
		 spr(256,112,56,11,1,0,p.angle,2,2)
		end
	elseif p.isDetector==true then
	 if t%60//15==1 or t%60//15==3 then
		 spr(404+(t%60//30)*2,112,56,11,1,0,p.angle,2,2)
		else
		 spr(408,112,56,11,1,0,p.angle,2,2)
		end
	else
	 spr(410,112,56,11,1,0,p.angle,2,2)
	end
end

function player_hudIdle()
 if p.isMop==true then
	 spr(402,112,56,11,1,0,p.angle,2,2)
	elseif p.isHands==true then
	 spr(256,112,56,11,1,0,p.angle,2,2)
	elseif p.isDetector==true then
	 spr(408,112,56,11,1,0,p.angle,2,2)
	else
	 spr(410,112,56,11,1,0,p.angle,2,2)
	end
end

function player_hudactivity(mop,hand,detect,tablet,use)
 if mop==true then
	 spr(434,112,56,11,1,0,p.angle,2,2)
	elseif hand==true and use=="prim" then
	 spr(432,112,56,11,1,0,p.angle,2,2)
	elseif hand==true and use=="alt" then
	 spr(464,112,56,11,1,0,p.angle,2,2)
	elseif detector==true then
	 spr(436,112,56,11,1,0,p.angle,2,2)
	elseif tablet==true then
	 spr(410,112,56,11,1,0,p.angle,2,2)
	end
end

function player_isDo(mop,hand,detect,use)
 if mop==true and use=="prim" then
	 for i=1,bloodTotal do
 	 if blood[i]~=nil then
    if p.x>blood[i][1]-16 and p.x<blood[i][1]+8 and p.y>blood[i][2]-16 and p.y<blood[i][2]+8 then
	    if bloodTotal>1 then
		 			for b=i,bloodTotal-1 do
					  blood[b][1]=blood[b+1][1]
			 			blood[b][2]=blood[b+1][2]
				 		blood[b][3]=blood[b+1][3]
			 		end
				 	bloodTotal=bloodTotal-1
				  break
 	 	 else
					 traceDo("Done",11)
						exit()
						break
					end
				end
	  end
	 end
	elseif mop==true and use=="alt" then
 elseif hand==true and use=="prim" then
	elseif hand==true and use=="alt" then
	elseif detect==true and use=="prim" then
	else
	end
end

function collisionCheck()
 colp.trx,colp.try=p.x+16,p.y
	colp.ru,colp.rd,colp.lu,colp.ld,colp.tl,colp.tr,colp.bl,colp.br=0,0,0,0,0,0,0,0
 colp.r,colp.l,colp.t,colp.b=false,false,false,false
	for i=0,1 do
		if solids[mget(colp.trx//8,colp.try//8)]==true then
			if colp.ru<2 then
			 colp.r=true
			end
			break
		elseif objData.total>0 and colp.r==false then
			for b=1,objData.total do
			 if o[b][10]==true then
 				colp.trx,colp.try=p.x+15,p.y
	 		 if colp.trx>o[b][2]-2 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-2 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.r=true
			 		break
				 else
		    colp.trx=colp.trx+1
	 		  colp.ru=colp.ru+1
		   end
			 end
		 end
		else
		 colp.trx=colp.trx+1
		 colp.ru=colp.ru+1
		end
	end
	colp.trx,colp.try=p.x+16,p.y+15
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
   if colp.rd<2 then
			 colp.r=true
			end
			break
		elseif objData.total>0 then
	 	for b=1,objData.total do
			 if o[b][10]==true then
 				colp.trx,colp.try=p.x+16,p.y+15
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.r=true
			 		break
				 else
		    colp.trx=colp.trx+1
 			  colp.rd=colp.rd+1
	 	  end
		 	end
		 end
		else
		 colp.trx=colp.trx+1
		 colp.rd=colp.rd+1
		end
	end
	colp.trx,colp.try=p.x-1,p.y
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
			if colp.lu<2 then
			 colp.l=true
			end
			break
		elseif objData.total>0 then
		 for b=1,objData.total do
			 if o[b][10]==true then
 			 colp.trx,colp.try=p.x-1,p.y
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.l=true
			 		break
				 else
		    colp.trx=colp.trx-1
 			  colp.lu=colp.lu+1
	 	  end
		 	end
		 end
		else
		 colp.trx=colp.trx-1
		 colp.lu=colp.lu+1
		end
	end
	colp.trx,colp.try=p.x-1,p.y+15
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
   if colp.ld<2 then
			 colp.l=true
			end
			break
		elseif objData.total>0 then
		 for b=1,objData.total do
			 if o[b][10]==true then
 			 colp.trx,colp.try=p.x-1,p.y+15
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.l=true
			 		break
				 else
		    colp.trx=colp.trx-1
 			  colp.ld=colp.ld+1
	 	  end
		 	end
		 end
		else
		 colp.trx=colp.trx-1
		 colp.ld=colp.ld+1
		end
	end
	colp.trx,colp.try=p.x,p.y-1
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
   if colp.tl<2 then
			 colp.t=true
			end
			break
		elseif objData.total>0 then
		 for b=1,objData.total do
			 if o[b][10]==true then
 			 colp.trx,colp.try=p.x,p.y-1
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.t=true
			 		break
				 else
		    colp.try=colp.try-1
 			  colp.tl=colp.tl+1
	 	  end
		 	end
		 end
		else
		 colp.try=colp.try-1
		 colp.tl=colp.tl+1
		end
	end
	colp.trx,colp.try=p.x+15,p.y-1
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
   if colp.tr<2 then
			 colp.t=true
			end
			break
		elseif objData.total>0 then
		 for b=1,objData.total do
			 if o[b][10]==true then
 			 colp.trx,colp.try=p.x+15,p.y-1
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.t=true
			 		break
				 else
		    colp.try=colp.try-1
 			  colp.tr=colp.tr+1
	 	  end
		 	end
		 end
		else
   colp.try=colp.try-1
	  colp.tr=colp.tr+1
		end
	end
	colp.trx,colp.try=p.x,p.y+16
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
   if colp.bl<2 then
			 colp.b=true
			end
			break
		elseif objData.total>0 then
		 for b=1,objData.total do
			 if o[b][10]==true then
 			 colp.trx,colp.try=p.x,p.y+16
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.b=true
			 		break
				 else
		    colp.try=colp.try+1
 			  colp.bl=colp.bl+1
	 	  end
		 	end
		 end
		else
		 colp.try=colp.try+1
		 colp.bl=colp.bl+1
		end
	end
	colp.trx,colp.try=p.x+15,p.y+16
	for i=0,4 do
	 if solids[mget(colp.trx//8,colp.try//8)] then
   if colp.br<2 then
			 colp.b=true
			end
			break
		elseif objData.total>0 then
		 for b=1,objData.total do
			 if o[b][10]==true then
 			 colp.trx,colp.try=p.x+15,p.y+16
	 		 if colp.trx>o[b][2]-1 and colp.trx<o[b][2]+o[b][8]*8+1 and colp.try>o[b][3]-1 and colp.try<o[b][3]+o[b][9]*8+1 then
		 			colp.b=true
			 		break
				 else
		    colp.try=colp.try+1
 			  colp.br=colp.br+1
	 	  end
		 	end
		 end
		else
		 colp.try=colp.try+1
	  colp.br=colp.br+1
	 end
	end
end

function traceDo(msg,clr)
 trace("--------------------------------------\n"..msg.."\n---------------------------------------",clr)
end

function func_disable()
 if m.p==false and m.t==false then
	 m.t=true
	end
	m.ind=0
end

function buttonsCheck()
 if m.ind==1 then
	 exit()
	end
end

function otherStuff()
 instr="Instrument: "
end

function init()
 if pmem(0)~=0 then
	 build=pmem(0)
	else
	 build=0
	end
	build=build+1
	pmem(0,build)
 for i=1,100 do
	 if btns[i]==nil then
		 break
	 else
		 m.totalButtons=m.totalButtons+1
		end
	end
 bloodTotal=pset_blood
	if bloodTotal<1 then
	 traceDo("No blood found",6)
		exit()
	end
	if bloodTotal>10000 then
		traceDo("Too much blood (overfill). Limit: 10000",6)
		exit()
	end
	if pset_trash>2000 then
	 traceDo("Too many trash. Limit: 2000",6)
		exit()
	end
	if pset_trash<1 then
	 traceDo("No trash found",6)
		exit()
	end
	if pset_loadingSkip==true then
	 mapc.generating=false
	end
 bloodRemain=bloodTotal
	if mapc.generating==true then
  for i=1,bloodTotal do
   blood[i]={}
		 blood[i][1]=math.random(0,240*8)
 	 blood[i][2]=math.random(0,136*8)
	 	blood[i][3]=math.random(0,3)
	 end
	end
	solids={}
 tx=0
	ty=0
	if mapc.generating==true then
  for i=0,100000 do
	  getted=mget(tx,ty)
		 if getted==240 then
		  if p.x==0 and p.y==0 then
	 	  p.x=tx*8
 		 	p.y=ty*8
	 		 mset(tx,ty,1)
		 	else
			  traceDo("You set more than 1 player spawnpoint",6)
			  exit()
 				break
	 		end
		 elseif getted==241 then
		  for b=1,1000 do
			  if o[b]==nil then
				  mset(tx,ty,1)
 				 o[b]={}
	 			 o[b][1]=160
		 			o[b][2]=tx*8
			 		o[b][3]=ty*8
				 	o[b][4]=11
					 o[b][5]=1
 					o[b][6]=0
	 				o[b][7]=0
		 			o[b][8]=2
			 		o[b][9]=2
				 	o[b][10]=true
					 o[b][11]=false
 					o[b][12]="dispenser trash"
	 				objData.total=objData.total+1
		 		 break
			 	end
 			end
	 	elseif getted==242 then
		  for b=1,1000 do
			  if o[b]==nil then
				  for z=0,1 do
					  o[b+z]={}
		 			 o[b+z][1]=128
 						o[b][2]=tx*8
	 					o[b][3]=ty*8
		 			 o[b+z][4]=11
 		 			o[b+z][5]=1
	 		 		o[b+z][6]=0
		 		 	o[b+z][8]=2
			 		 o[b+z][9]=2
 						o[b+z][10]=true
	 					o[b+z][11]=false
							o[b+z][12]="dispenser water"
		 		  objData.total=objData.total+1
			 			mset(tx,ty,1)
				  end
					 if mget(tx+1,ty)==244 then
					  o[b][7]=2
 						o[b+1][7]=0
	 					o[b+1][2]=(tx+2)*8
		 				o[b+1][3]=ty*8
			 		elseif mget(tx+1,ty)==245 then
				 	 o[b][7]=3
					 	o[b+1][7]=1
						 o[b+1][2]=tx*8
 						o[b+1][3]=(ty+2)*8
	 				end
		 			mset(tx+1,ty,1)
			 		break
				 end
 			end
	 	elseif getted==243 then
			 for b=1,1000 do
				 if o[b]==nil then
					 for z=0,1 do
	 				 o[b+z]={}
		 				o[b+z][1]=162
			 			o[b][2]=tx*8
				 		o[b][3]=ty*8
					 	o[b+z][4]=11
						 o[b+z][5]=1
 						o[b+z][6]=0
	 					o[b+z][8]=2
		 				o[b+z][9]=2
							o[b+z][10]=true
							o[b+z][11]=false
							o[b+z][12]="incinerator"
	      objData.total=objData.total+1
				 		mset(tx,ty,1)
				  end
					 if mget(tx+1,ty)==244 then
					  o[b][7]=2
 						o[b+1][7]=0
	 					o[b+1][2]=(tx+2)*8
		 				o[b+1][3]=ty*8
			 		elseif mget(tx+1,ty)==245 then
				 	 o[b][7]=3
					 	o[b+1][7]=1
						 o[b+1][2]=tx*8
 						o[b+1][3]=(ty+2)*8
	 				end
		 			mset(tx+1,ty,1)
			 		break
					end
				end
			end
 		tx=tx+1
	 	if tx>=136 then
		  tx=0
			 ty=ty+1
 		end
	 	if ty>=136 then
		  if p.x==0 then
			  traceDo("Unable to find player!",6)
				 exit()
 				break
	 		end
		 end
	 end
	end
	for i=1,pset_shellSpawner do
  shells[i]={}
	 shells[i][1]=math.random(1,2)
 	shells[i][2]=math.random(0,240*8)
		shells[i][3]=math.random(0,136*8)
	end
	for i=1,1000 do
	 if o[i]==nil then
		 objData.trashDiapasone_low=i
		 objData.trashDiapasone_max=i+pset_trash
		 break
		end
	end
	for i=objData.trashDiapasone_low,objData.trashDiapasone_max do
	 o[i]={}
		math_random=math.random(276,279)
		o[i][1]=math_random
		o[i][2]=math.random(0,240*8)
		o[i][3]=math.random(0,136*8)
		o[i][4]=11
	 o[i][5]=1
		o[i][6]=0
		o[i][7]=math.random(0,3)
		o[i][8]=1
		o[i][9]=1
		o[i][10]=false
		o[i][11]=true
		objData.total=objData.total+1
		if math_random>=276 and math_random<=277 then
		 o[i][12]="trash can"
		elseif math_random>=278 and math_random<=279 then
		 o[i][12]="trash chips"
		end
	end
	solids[0]=true
	for i=64,65 do
	 solids[i]=true
	end
	for i=1,100 do
	 textlenght[i]=0
	end
	otherStuff()
end

init()
function TIC()
 if btnp(7) then
	 exit()
	end

 m.x,m.y,m.p=mouse()

 if m.p==true and m.t==true and mapc.generating==false then
	 m.t=false
		for i=1,m.totalButtons do
		 if m.x>btns[i][1] and m.x<btns[i][1]+btns[i][3] and m.y>btns[i][2] and m.y<btns[i][2]+btns[i][4] then
			 m.ind=i
				buttonsCheck()
				break
			end
		end
	end

 t=t+1

 if mapc.generating==true then
	 generation()
	end

 if fps.timer>time() then
	 fps.count=fps.count+1
	else
	 fps.timer=time()+1000
	 fps.value=fps.count
		fps.count=0
	end

 if p.animTimer<time() then
	 p.use=""
	end
 
 if mapc.generating==false then
  if btn(0) and colp.t==false then
	  p.vy=-1
		 p.angle=2
 	elseif btn(1) and colp.b==false then
	  p.vy=1
		 p.angle=0
 	else
	  p.vy=0
 	end
	 if btn(2) and colp.l==false then
	  p.vx=-1
		 p.angle=1
 	elseif btn(3) and colp.r==false then
	 	p.vx=1
	 	p.angle=3
		else
	  p.vx=0
 	end
		if btnp(4) and p.use=="" then
		 p.animTimer=time()+500
			p.use="prim"
			player_isDo(p.isMop,p.isHands,p.isDetector,p.use)
		elseif btnp(5) and p.use=="" then
		 p.animTimer=time()+500
			p.use="alt"
		 player_isDo(p.isMop,p.isHands,p.isDetector,p.use)
	 end
		if btnp(7) and p.use=="" then
		 player_changeInstrument()
		end
 end

 if p.vx~=0 or p.vy~=0 then
	 p.isMove=true
	else
	 p.isMove=false
	end

 p.x=p.x+p.vx
	p.y=p.y+p.vy

 collisionCheck()
	if mapc.generating==false then
	 overlay()
	end
	func_disable()
end
