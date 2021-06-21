----------------------------------------
------------functions bank--------------
----------------------------------------

--checking if blood spawns over map or solids objects. also using as checking everything
function collide(x,y)
 return solids[mget((x)//8,(y)//8)]
end

--all overlay in game that player see
function overlay()
 if main.menu==true then
	 cls()
		map(0,0,240,136,-mapc.mapViewX,-mapc.mapViewY)
		map_preview()
		spr(0,4,4,11,1,0,0,10,16)
		spr(256,150,18,11,1,0,0,8,13)
		textlenght[5]=print("New Game",45-textlenght[5]/2,21,0)
	 textlenght[6]=print("Settings",45-textlenght[6]/2,37,0)
		textlenght[7]=print("Quit Game",45-textlenght[7]/2,69,0)
	 textlenght[8]=print("Buoyancy's\n\n  Cleanup\n\n   Detail",90,48)
	elseif main.mapChoose==true then
	 cls(10)
	 map(0,0,240,136,-mapc.mapViewX,-mapc.mapViewY)
		map_preview()
		spr(0,4,4,11,1,0,0,10,16)
		spr(256,150,18,11,1,0,0,8,13)
		rect(20,12,48,88,13)
		for i=24,24 do
		 textlenght[9]=print("Choose Map",45-textlenght[9]/2,16,0)
		 textlenght[i//24+9]=print(mapChoosing[i//24][1],45-textlenght[i//24+9]/2,i,0)
			rect(15,i+15,58,25,0)
			textri(16,i+16,16+56,i+16,16+56,i+16+23,mapChoosing[i//24][2],mapChoosing[i//24][3],mapChoosing[i//24][4],mapChoosing[i//24][3],mapChoosing[i//24][4],mapChoosing[i//24][5],-1,true)
			textri(16,i+16,16,i+16+23,16+56,i+16+23,mapChoosing[i//24][2],mapChoosing[i//24][3],mapChoosing[i//24][2],mapChoosing[i//24][5],mapChoosing[i//24][4],mapChoosing[i//24][5],-1,true)
		end
 elseif main.game==true and mapc.generating==false then
  cls()
	 map(0,0,240,136,-p.x+112+math.floor(p.x-mapc.camX),-p.y+56+math.floor(p.y-mapc.camY))
 	for i=1,bloodTotal do
  	if blood[i][1]>p.x-128 and blood[i][1]<p.x+136 and blood[i][2]>p.y-72 and blood[i][2]<p.y+88 then
	   spr(blood[i][4],blood[i][1]-p.x+112+p.x-mapc.camX,blood[i][2]-p.y+56+p.y-mapc.camY,11,1,0,blood[i][3])
 	 end
	 end
		for b=1,3 do
   for i=1,objData.total do
	   if o[i][2]>p.x-120-o[i][8]*8 and o[i][2]<p.x+136 and o[i][3]>p.y-64-o[i][9]*8 and o[i][3]<p.y+88 and o[i][13]==b then
	    spr(o[i][1],o[i][2]-p.x+112+p.x-mapc.camX,o[i][3]-p.y+56+p.y-mapc.camY,o[i][4],o[i][5],o[i][6],o[i][7],o[i][8],o[i][9])
   	end
	  end
		end
 	if p.vx==0 and p.vy==0 then
	  spr(256,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
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
	 	 spr(258,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,t%60//30*var,p.angle,2,2)
		 else
		  spr(256,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
 		end
	 	if p.use=="" then
	  	player_hudMove()
 		end
	 end
 	if p.use~="" then
	  player_hudactivity(p.isMop,p.isHands,p.isDetector,p.isTablet,p.use)
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
	elseif main.game==true and mapc.generating==true then
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
		textlenght[3]=print(text_loading,120-textlenght[3]//2,102,14,false,2)
	elseif main.settings==true then
	 cls()
		map(0,0,240,136,-mapc.mapViewX,-mapc.mapViewY)
		map_preview()
		spr(0,4,4,11,1,0,0,10,16)
		spr(256,150,18,11,1,0,0,8,13)
		if settings.page==1 then
		 textlenght[6]=print("Nickname:",45-textlenght[6]//2,21,0)
			textlenght[7]=print(nickname,45-textlenght[7]//2,29,0)
			textlenght[8]=print("Use custom\n nickname?",45-textlenght[8]//2,45,0)
		 if settings.customNick==false then
		  var="No"
 		else
	 	 var="Yes"
		 end
 		textlenght[9]=print(var,45-textlenght[9]//2,61,0)
	  textlenght[10]=print("Clear",45-textlenght[10]//2,77,0)
		 textlenght[11]=print("Progress?",45-textlenght[11]//2,85,0)
		elseif settings.page==2 then
		 textlenght[6]=print("Controls:",45-textlenght[6]//2,21,0)
			if main.isPc==false then
		  var="Android"
 		else
	 	 var="PC"
		 end
	 	textlenght[12]=print(var,45-textlenght[12]//2,29,0)
			textlenght[8]=print("Sounds:",45-textlenght[8]//2,45,0)
			if settings.sounds==true then
			 var="Yes"
			else
			 var="No"
			end
			textlenght[7]=print(var,45-textlenght[7]//2,53,0)
		end
	elseif main.tablet==true then
	 cls()
		map(0,0,240,136,-p.x+112,-p.y+56)
		for i=1,bloodTotal do
  	if blood[i][1]>p.x-120 and blood[i][1]<p.x+128 and blood[i][2]>p.y-64 and blood[i][2]<p.y+80 then
	   spr(blood[i][4],blood[i][1]-p.x+112,blood[i][2]-p.y+56,11,1,0,blood[i][3])
 	 end
	 end
  for i=1,objData.total do
	  if o[i][2]>p.x-112-o[i][8]*8 and o[i][2]<p.x+128 and o[i][3]>p.y-56-o[i][9]*8 and o[i][3]<p.y+80 then
	   spr(o[i][1],o[i][2]-p.x+112,o[i][3]-p.y+56,o[i][4],o[i][5],o[i][6],o[i][7],o[i][8],o[i][9])
  	end
	 end
		for i=1,4 do
		 spr(i+191,tabletView__48[i][1],tabletView__48[i][2],11)
		end
		rect(56,20,16*8,12*8,3)
		rect(48,28,18*8,10*8,3)
		rect(56,23,16*8,12*8-6,2)
		rect(51,28,18*8-6,10*8,2)
		textlenght[11]=print("Page "..tablet.page.."/"..tablet.totalPages,120-textlenght[11]//2,105,8)
	 if tablet.brief==true then
 		rectb(56,26,48,10,8)
	 	rectb(110,26,48,10,15)
	 elseif tablet.note==true then
	  rectb(56,26,48,10,15)
 		rectb(110,26,48,10,8)
		end	 
		if tablet.brief==true or tablet.note==true then
	  print("Brief",67,28,8)
  	print("Notes",120,28,8)
		end
 	if tablet.brief==true then
		 if tablet.page==1 then
  	 if settings.customNick==true then
		 	 print("Name: "..nickname,60,40,8)
	 	 else
	    print("Name: "..briefing.name,60,40,8)
 			end
	 	 print("Age: "..briefing.age,60,48,8)
	  	print("         Briefing:\n"..briefing.text,60,62,8)
	  elseif tablet.page==2 then
		  print(briefing.text2,60,40,8)
 		elseif tablet.page==3 then
			 print(briefing.text3,60,40,8)
	 	elseif tablet.page==4 then
		  print(briefing.text4,60,40,8)
 		end
		elseif tablet.note==true then
	  for i=40,100,8 do
		 	line(60,i+6,178,i+6,8)
		  if notes_buffer[(tablet.page-1)*8+(i//8-4)]~=nil then
		   print(notes_buffer[(tablet.page-1)*8+(i//8-4)],60,i,8)
 	  end
			end
	 elseif tablet.base==true then
		 if tablet.baseChoose==0 then
			 for i=40,96,20 do
				 if tabletBase[i//20-4+tablet.page*3]~=nil then
				  spr(tabletBase[i//20-4+tablet.page*3][1],60,i,11,2)
				  if tabletBase[i//20-4+tablet.page*3][7]==true then
						 print(tabletBase[i//20-4+tablet.page*3][2],80,i+5)
						else
						 print("????????",80,i+5)
						end
					end
				end
			else
			 rect(70,102,100,10,2)
			 spr(tabletBase[tablet.baseChoose][1],58,30,11,2)
		  if tabletBase[tablet.baseChoose][7]==true then
				 print(tabletBase[tablet.baseChoose][2],78,35)
				 print("Type: "..tabletBase[tablet.baseChoose][3],58,50)
				 print("Pickable: "..tabletBase[tablet.baseChoose][4],58,58)
					print("Usable: "..tabletBase[tablet.baseChoose][5],58,66)
				 print("Weight: "..tabletBase[tablet.baseChoose][8].."/100",78,42)
					print("       Description:\n"..tabletBase[tablet.baseChoose][6],58,76)
				else
				 print("????????",78,35)
					print("Scan this object to\ninvestigate it!",58,76)
				end
			end
		end
	elseif main.inventory==true then
	 cls()
		map(0,0,240,136,-p.x+112,-p.y+56)
		for i=1,bloodTotal do
  	if blood[i][1]>p.x-120 and blood[i][1]<p.x+128 and blood[i][2]>p.y-64 and blood[i][2]<p.y+80 then
	   spr(blood[i][4],blood[i][1]-p.x+112,blood[i][2]-p.y+56,11,1,0,blood[i][3])
 	 end
	 end
  for i=1,objData.total do
	  if o[i][2]>p.x-112-o[i][8]*8 and o[i][2]<p.x+128 and o[i][3]>p.y-56-o[i][9]*8 and o[i][3]<p.y+80 then
	   spr(o[i][1],o[i][2]-p.x+112,o[i][3]-p.y+56,o[i][4],o[i][5],o[i][6],o[i][7],o[i][8],o[i][9])
  	end
	 end
	 spr(146,60,10,11,15)
	 for i=80,160,12 do
		 for b=30,110,12 do
			 if o[p.objectID][16][2][(i//12-6)+((b//12-2)*7)+1]~=nil then
					for h=1,objData.total do
		 		 if o[h][15]==o[p.objectID][16][2][(i//12-6)+((b//12-2)*7)+1] then
							spr(o[h][1],i,b,11)
	 		   break
						end
					end
				else
				 break
				end
		 end
		end
	elseif main.pause==true then
	 cls()
		map(0,0,240,136,-p.x+112,-p.y+56)
		for i=1,bloodTotal do
  	if blood[i][1]>p.x-120 and blood[i][1]<p.x+128 and blood[i][2]>p.y-64 and blood[i][2]<p.y+80 then
	   spr(blood[i][4],blood[i][1]-p.x+112,blood[i][2]-p.y+56,11,1,0,blood[i][3])
 	 end
	 end
  for i=1,objData.total do
	  if o[i][2]>p.x-112-o[i][8]*8 and o[i][2]<p.x+128 and o[i][3]>p.y-56-o[i][9]*8 and o[i][3]<p.y+80 then
	   spr(o[i][1],o[i][2]-p.x+112,o[i][3]-p.y+56,o[i][4],o[i][5],o[i][6],o[i][7],o[i][8],o[i][9])
  	end
	 end
		for i=1,4 do
		 spr(i+191,tabletView__48[i][1],tabletView__48[i][2],11)
		end
		rect(56,20,16*8,12*8,3)
		rect(48,28,18*8,10*8,3)
		rect(56,23,16*8,12*8-6,2)
		rect(51,28,18*8-6,10*8,2)
		if t%60//30==1 then
		 textlenght[2]=print("PAUSE",120-textlenght[2]//2,30,8,false,2)
		end
		for i=50,72,22 do
		 rectb(80,i-2,80,10,8)
		end
		textlenght[3]=print("Resume Game",120-textlenght[3]//2,50,8)
	 textlenght[4]=print("Main Menu",120-textlenght[4]//2,72,8)
	end
	if mapc.generating==false or main.menu==true or main.mapChoose==true or main.tablet==true or main.settings==true then
 	for i=1,m.totalButtons do
	  if btns[i][11]==m.dem and btns[i][12]==true then
			 if main.tablet==false then
					if main.settings==true then
		 			if btns[i][5]==14 and btns[i][8]==2 and settings.page==settings.maxpages then
	 	 		 btns[i][7]=0
		 	 	elseif btns[i][5]==14 and btns[i][8]==2 and settings.page<settings.maxpages then
			 	  btns[i][7]=1
	 	 	 end
		 			if btns[i][5]==14 and btns[i][8]==0 and settings.page==settings.maxpages then
	 	 		 btns[i][7]=1
		 	 	elseif btns[i][5]==14 and btns[i][8]==0 and settings.page<settings.maxpages then
			 	  btns[i][7]=0
		 	  end
					end
					spr(btns[i][5],btns[i][1],btns[i][2],btns[i][6],btns[i][7],0,btns[i][8],btns[i][9],btns[i][10])
				elseif btns[i][13]==tablet.dem or btns[i][13]==-1 then
					if tablet.dem~=3 or btns[i][5]~=386 or i==22 then
				 	spr(btns[i][5],btns[i][1],btns[i][2],btns[i][6],btns[i][7],0,btns[i][8],btns[i][9],btns[i][10])
     end
				end
			end
	 end
	end
	if keyboard.isCalled==true then
	 if main.tablet==true then
		 cls()
		end
	 rect(0,30,240,106,13)
		line(0,50,240,50,0)
		for i=10,220,22 do
		 if keyboard.pressed==keypKeys[i//22+1] and m.tl==false then
			 var=44
			else
			 var=42
			end
		 spr(var,i,56,11,1,0,0,2,2)
		end
		for i=21,200,22 do
		 if keyboard.pressed==keypKeys[i//22+11] and m.tl==false then
			 var=44
			else
			 var=42
			end
		 spr(var,i,78,11,1,0,0,2,2)
		end
		for i=10,190,22 do
		 if keyboard.pressed==keypKeys[i//22+19] and m.tl==false and i~=10 then
			 var=44
			elseif keyboard.isShift==true and i==10 then
			 var=44
			elseif keyboard.pressed=="BS" and i==186 then
			 var=44
			else
			 var=42
			end
		 spr(var,i,100,11,1,0,0,2,2)
		end
		if keyboard.pressed=="space" then
		 var1=44
			var2=45
			var3=75
		else
		 var1=42
			var2=43
			var3=74
		end
		if keyboard.isShift==true then
		 var4=2
		else
		 var4=0
		end
		for i=84,164,8 do
	 	spr(var3,i,120,11,1,0,0,1,2)
		end
		spr(var1,76,120,11,1,0,0,1,2)
		spr(var2,172,120,11,1,0,0,1,2)
		spr(107,208,84,11,1,0,0,3,4)
		spr(76,14,103+var4,11)
		spr(42,197,120,11,1,0,0,2,2)
		if keyboard.isNumeric==false then
		 var=0
		else
		 var=2
		end
		spr(42+var,21,120,11,1,0,0,2,2)
		print("EC",199,122,3)
		print("FN",23,122+var,3)
		for i=10,220,22 do
		 if keyboard.pressed==keypKeys[i//22+1] and m.tl==false then
			 var=2
			else
			 var=0
			end
			if keyboard.isNumeric==false then
		  print(keypKeys[i//22+1],i+2,58+var,3)
		 else
			 if (i//22+1)==10 then
				 var1=0
				else
				 var1=i//22+1
				end
			 print(var1,i+2,58+var,3)
			end
		end
		for i=21,212,22 do
		 if keyboard.pressed==keypKeys[i//22+11] and m.tl==false then
			 var=2
			else
			 var=0
			end
		 print(keypKeys[i//22+11],i+2,80+var,3)
		end
		for i=32,190,22 do
		 if keyboard.pressed==keypKeys[i//22+19] and m.tl==false then
			 var=2
			else
			 var=0
			end
		 print(keypKeys[i//22+19],i+2,102+var,3)
		end
		if t%60>30 then
		 line(keyboard.cursor,32,keyboard.cursor,46,0)
			line(keyboard.cursor-1,32,keyboard.cursor+1,32,0)
			line(keyboard.cursor-1,46,keyboard.cursor+1,46,0)
		end
		print(keyboard.text,8,34,0,false,2)
	end
	if messageReport.timer>time() then
	 textlenght[13]=print(messageReport.msg,120-textlenght[13]//2,100,messageReport.clr)
	end
	if main.game==true or main.inventory==true or main.tablet==true then
	 var=14
	else
	 var=4
	end
	print("fps: "..fps.value,200,0,var)
end

--when player choose map
function generation()
	mapc.badBlood=0
	mapc.badTrash=0
	mapc.badShells=0
	if mapc.generating_Blood==true then
 	for i=1,bloodTotal do
 		if	collide(blood[i][1],blood[i][2]) or collide(blood[i][1]+8,blood[i][2]) or
   collide(blood[i][1],blood[i][2]+8) or collide(blood[i][1]+8,blood[i][2]+8) then
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
		 if collide(o[i][2],o[i][3]) or collide(o[i][2]+8,o[i][3]) or
 	 collide(o[i][2],o[i][3]+8) or collide(o[i][2]+8,o[i][3]+8) then 
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
 	 if collide(shells[i][2]-7,shells[i][3]-7) or collide(shells[i][2]+7,shells[i][3]-7)
	 	or collide(shells[i][2]-7,shells[i][3]+7) or collide(shells[i][2]+7,shells[i][3]+7) then
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
				for b=1,100000 do
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
							o[z][13]=1
							o[z][14]=0.02
							o[z][15]=objData.total+1
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
			end
			shellsBuffer={}
		 for y=1,objData.total do
			 if o[y][12]=="shell 5x74" or o[y][12]=="shell shotgun" then
	 		 if collide(o[y][2],o[y][3]) or collide(o[y][2]+7,o[y][3])
					or collide(o[y][2],o[y][3]+7) or collide(o[y][2]+7,o[y][3]+7) then
		    for h=1,1000 do
						 if shellsBuffer[h]==nil then
							 shellsBuffer[h]=o[y][15]
								break
							end
						end
 				end
	 		end
			end
			for i=1,1000 do
			 if shellsBuffer[1]~=nil then
				 for y=1,objData.total do
					 if o[y][15]==shellsBuffer[1] then
						 table.remove(o,y)
							table.remove(shellsBuffer,1)
							objData.total=objData.total-1
							break
						end
					end
				else
				 shellsBuffer=nil
				 break
				end
			end
		 for i=1,objData.total do
			 if o[i][12]=="human meat" or o[i][12]=="human guts" or o[i][12]=="human leg" or o[i][12]=="human arm" or o[i][12]=="human head" or o[i][12]=="human torso" then
					bloodTotal=bloodTotal+1
					blood[bloodTotal]={}
					blood[bloodTotal][1]=o[i][2]
					blood[bloodTotal][2]=o[i][3]
					blood[bloodTotal][3]=math.random(0,3)
					blood[bloodTotal][4]=260
				end
			end
			shells=nil
			mapc.generating=false
			solids[0]=nil
			for i=2,14,12 do
  	 for b=0,1 do
  		 solids[i+b]=nil
  		end
	  end
		end
	end
end

--massive function that checking player and objects collisions
function collisionCheck()
 p.sx,p.sy=p.x+p.vx,p.y+p.vy
	if collide(p.sx,p.y) or collide(p.sx,p.y+8) or collide(p.sx,p.y+15)
	or collide(p.sx+15,p.y) or collide(p.sx+15,p.y+8) or collide(p.sx+15,p.y+15) then
		p.vx=0
	end
 if collide(p.x,p.sy) or collide(p.x+8,p.sy) or collide(p.x+15,p.sy)
	or collide(p.x,p.sy+15) or collide(p.x+8,p.sy+15) or collide(p.x+15,p.sy+15) then
	 p.vy=0
	end
 for i=1,objData.total do
 	if p.sx+16>o[i][2] and p.sx<o[i][2]+o[i][8]*8 and p.sy+16>o[i][3] and p.sy<o[i][3]+o[i][9]*8 and o[i][10]==true then
	  if o[i][3]<p.y-7 or o[i][3]>p.y+15 then
		  p.vy=0
 		end
	 	if o[i][2]<p.x-7 or o[i][2]>p.x+15 then
		  p.vx=0
 		end
	 end
 end
	if p.vx==0 and p.vy==0 then
	 p.isMove=false
	end
end

function sfxPlay(id,note,dur,channel,vol,speed,diap1,diap2)
	if diap1~=nil and diap2~=nil then
		varSfx1=""..string.char(string.byte(diap1,1))..string.char(string.byte(diap1,2))
		varSfx2=""..string.char(string.byte(diap2,1))..string.char(string.byte(diap2,2))
		for i=1,12 do
			if varSfx1==sfxCode[i] then
			 sfxCode[13]=i
			elseif varSfx2==sfxCode[i] then
			 sfxCode[14]=i
				break
			end
		end
		note=""..sfxCode[math.random(sfxCode[13],sfxCode[14])]..string.char(string.byte(diap1,3))
	 diap1,diap2=nil,nil
	end
	sfx(id,note,dur,channel,vol,speed)
end

--overlap function that allow player make fast traces
function traceDo(msg,clr)
 trace("--------------------------------------\n"..msg.."\n---------------------------------------",clr)
end

--disable everything after TIC() ends every tic
function func_disable()
 if m.bl==false and m.tl==false then
	 m.tl=true
		keyboard.pressed=""
	end
	if m.br==false and m.tr==false then
	 m.tr=true
	end
	m.ind=0
end

--some sort of buttons variants when player choose it
function buttonsCheck()
 g=m.ind
 if m.ind==1 then
	 if settings.sounds==true then
		 sfxPlay(4,"F-5",-1,1,15,1)
		end
	 main.pause=true
		main.game=false
	elseif m.ind==2 then
	 if settings.sounds==true then
		 sfxPlay(8,"F-4",-1,0,15,1)
		end
	 main.menu=false
		main.mapChoose=true
	elseif m.ind==3 then
	 main.hasSave=false
		pmem(252,0)
	 main.mapChoose=false
		main.game=true
		sync(1,0,false)
		sync(2,0,false)
		sync(4,0,false)
		sync(32,0,false)
		bloodTotal=pset_blood
 	if bloodTotal<1 then
	  traceDo("No blood found",6)
		 exit()
 	end
	 if bloodTotal>2000 then
		 traceDo("Too much blood (overfill). Limit: 2000",6)
 		exit()
	 end
 	if pset_trash>2000 then
	  traceDo("Too many trash. Limit: 1000",6)
		 exit()
 	end
	 if pset_trash<1 then
	  traceDo("No trash found",6)
 		exit()
	 end
 	if pset_shellSpawner<1 then
	  traceDo("No shells spawners found",6)
		 exit()
 	end
	 if pset_shellSpawner>100 then
	  traceDo("Too many shells spawners. Limit: 100",6)
 		exit()
	 end
  bloodRemain=bloodTotal
	 if mapc.generating==true then
   for i=1,bloodTotal do
    blood[i]={}
 		 blood[i][1]=math.random(0,240*8)
  	 blood[i][2]=math.random(0,136*8)
	  	blood[i][3]=math.random(0,3)
				blood[i][4]=math.random(260,263)
				if blood[i][4]==263 then
				 blood[i][4]=262
				else
				 blood[i][4]=260
				end
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
						mapc.camX=p.x
						mapc.camY=p.y
 	 		 mset(tx,ty,1)
	 	 	else
		 	  traceDo("You set more than 1 player spawnpoint",6)
			   exit()
 			 	break
 	 		end
	 	 elseif getted==241 then
		   for b=1,100000 do
			   if o[b]==nil then
 			 	 o[b]={}
 	 			 o[b][1]=160
	 	 			o[b][2]=tx*8
		 	 		o[b][3]=ty*8
			 	 	o[b][4]=11
				 	 o[b][5]=1
 				 	o[b][6]=0
		 			 o[b][8]=2
 			 		o[b][9]=2
	 			 	o[b][10]=true
		 			 o[b][11]=false
 	 				o[b][12]="dispenser trash"
							o[b][13]=3
							o[b][15]=objData.total+1
	  				objData.total=objData.total+1
		  		 mset(tx,ty,1)
 		 		 if mget(tx+1,ty)==244 then
	 	 		  o[b][7]=0
 		 	 	elseif mget(tx+1,ty)==245 then
	 		 		 o[b][7]=1
	  		 	else
			 		  traceDo("Arrow is missing at "..(tx+1).."/"..ty,6)
			  			exit()
				    break
 					 end
	 	 	 	mset(tx+1,ty,1)
		 	  	break
 		 	 end
				 end
 	 	elseif getted==242 then
	 	  for b=1,100000 do
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
								o[b+z][13]=3
								o[b+z][15]=objData.total+1
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
	 				 else
				 	  traceDo("Arrow is missing at "..(tx+1).."/"..ty,6)
 					 	exit()
	 			   break
		 			 end
			 			mset(tx+1,ty,1)
			  		break
				  end
  			end
	  	elseif getted==243 then
		 	 for b=1,100000 do
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
								o[b+z][13]=3
								o[b+z][15]=objData.total+1
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
	 				 else
 			 	  traceDo("Arrow is missing at "..(tx+1).."/"..ty,6)
 	 					exit()
	 		 	 end
		  	 	mset(tx+1,ty,1)
			 			break
				 	end
 				end
	 		elseif getted==244 or getted==245 then
		 		for i=240,244 do
			 	 if mget(tx-1,ty)==i then
				 	 break
					 else
	   		 traceDo("Found non-linked arrows at "..tx.."/"..ty,6)
 				  exit()
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
 	if mapc.generating==true then
  	for i=1,pset_shellSpawner do
    shells[i]={}
	   shells[i][1]=math.random(1,2)
   	shells[i][2]=math.random(0,240*8)
	  	shells[i][3]=math.random(0,136*8)
	  end
  	for i=1,100000 do
	   if o[i]==nil then
		   objData.trashDiapasone_low=i
		   objData.trashDiapasone_max=i+pset_trash
 		  break
 	 	end
  	end
	  for i=objData.trashDiapasone_low,objData.trashDiapasone_max do
	   o[i]={}
  		math_random=math.random(276,280)
				if math_random==280 then
				 math_random=math.random(264,270)
				end
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
				o[i][13]=1
				o[i][15]=objData.total+1
				objData.total=objData.total+1
	  	if math_random>=276 and math_random<=277 then
		   o[i][12]="trash can"
					o[i][14]=0.08
 		 elseif math_random>=278 and math_random<=279 then
	 	  o[i][12]="trash chips"
					o[i][14]=0.09
 		 elseif math_random==264 then
				 o[i][12]="human meat"
					o[i][14]=0.31
				elseif math_random>=265 and math_random<=266 then
				 o[i][12]="human guts"
					o[i][14]=0.10
				elseif math_random==267 then
				 o[i][12]="human leg"
					o[i][14]=0.4
				elseif math_random==268 then
				 o[i][12]="human arm"
				 o[i][14]=0.3
				elseif math_random==269 then
				 o[i][12]="human head"
					o[i][14]=0.5
				elseif math_random==270 then
				 o[i][12]="human torso"
					o[i][14]=1.1
				end
  	end
 	end
	 for i=1,100000 do
	  if spawner_objects[i]~=nil then
		  objData.physical=objData.physical+1
 		else
	 	 break
		 end
 	end
	 for b=1,objData.physical do
 	 for i=1,100000 do
	   if o[i]==nil then
		   o[i]={}
  			o[i][1]=mget(spawner_objects[b][2],spawner_objects[b][3])
	  		o[i][2]=spawner_objects[b][2]*8
		  	o[i][3]=spawner_objects[b][3]*8
 		 	o[i][4]=spawner_objects[b][4]
	 		 o[i][5]=1
 		 	o[i][6]=0
	 		 o[i][7]=spawner_objects[b][5]
 	 		o[i][8]=1
	 	 	o[i][9]=1
		 	 o[i][10]=spawner_objects[b][6]
 			 o[i][11]=spawner_objects[b][7]
  			o[i][12]=spawner_objects[b][8]
					o[i][13]=2
					o[i][15]=objData.total+1
	  		if o[i][12]=="bin" then
					 o[i][16]={}
	 				o[i][16][1]=0
		 			o[i][16][2]={}
					elseif o[i][12]=="bucket" then
					 o[i][16]={}
		 			o[i][16][1]=0
				 	o[i][16][2]=0
					end
					mset(spawner_objects[b][2],spawner_objects[b][3],spawner_objects[b][1])
		   objData.total=objData.total+1
				 break
 		 end
	 	end
 	end
	 solids[0]=true
 	for i=64,109 do
	  solids[i]=true
 	end
	 for i=2,14,12 do
	  for b=0,1 do
		  solids[i+b]=true
 		end
 	end
 elseif m.ind==4 then
	 if settings.sounds==true then
		 sfxPlay(8,"F-4",-1,0,15,1)
		end
	 main.menu=false
		main.settings=true
		settings.page=1
	elseif m.ind==5 then
	 exit()
	elseif m.ind==6 then
	 if settings.sounds==true then
		 sfxPlay(8,"F-3",-1,0,15,1)
		end
	 main.menu=true
		main.mapChoose=false
	elseif m.ind==7 then
	 if settings.sounds==true then
		 sfxPlay(5,"F-5",-1,1,15,1)
		end
	 main.tablet=false
		tablet.brief=true
		tablet.note=false
		tablet.base=false
		main.game=true
		main.inventory=false
		tablet.baseChoose=0
		tablet.dem=1
	elseif m.ind==8 then
	 if settings.sounds==true then
		 sfxPlay(8,"F-3",-1,0,15,1)
		end
	 main.settings=false
		main.menu=true
	elseif m.ind==9 then
	 if settings.page==1 then
		 if settings.sounds==true then
	 	 sfxPlay(8,"F-4",-1,0,15,1)
	 	end
	  keyboard.isCalled=true
 		keyboard.text=nickname
 		keyboard.maximal_string=12
	 	keyboard.id=1
	 end
	elseif m.ind==10 then
	 if settings.page==1 then
		 if settings.sounds==true then
		  sfxPlay(8,"F-4",-1,0,15,1)
	 	end
	  if settings.customNick==false then
	 	 settings.customNick=true
	 		pmem(255,1)
	 	else
	 	 settings.customNick=false
	 		pmem(255,0)
 		end
	 end
	elseif m.ind==11 then
	 if settings.page==1 then
		 for i=0,255 do
	 	 pmem(i,0)
	 	end
 		tx=0
 		ty=0
 		for i=1,100000 do
 		 mset(tx,ty,0)
  		tx=tx+1
	  	if tx==240 then
		   tx=0
	 		 ty=ty+1
  		end
	  	if ty==136 then
	 		 sync(4,7,true)
	 	  break
	 	 end
	 	end
	 	traceDo("Clearing all progress: succeed",11)
 	 exit()
	 end
	elseif m.ind==12 then
	 if tablet.page>1 then
		 tablet.page=tablet.page-1
			if settings.sounds==true then
		  sfxPlay(8,"F-4",-1,1,15,1)
		 end
		end
	elseif m.ind==13 then
	 if tablet.page<tablet.totalPages then
		 tablet.page=tablet.page+1
			if settings.sounds==true then
	 	 sfxPlay(8,"F-4",-1,1,15,1)
	 	end
		end
	elseif m.ind==14 then
	 if tablet.note==false then
		 if settings.sounds==true then
		  sfxPlay(8,"F-4",-1,1,15,1)
		 end
		 tablet.note=true
			tablet.brief=false
			tablet.totalPages=25
			tablet.page=1
		end
	elseif m.ind==15 then
	 if tablet.brief==false then
		 if settings.sounds==true then
		  sfxPlay(8,"F-4",-1,1,15,1)
		 end
		 tablet.brief=true
		 tablet.note=false
			tablet.totalPages=briefing.pages
			tablet.page=1
		end
	elseif m.ind==16 then
	 if tablet.note==true then
		 for i=40,103,8 do
			 if m.y>i and m.y<i+7 then
				 if settings.sounds==true then
					 sfxPlay(8,"F-4",-1,0,15,1)
					end
				 notes_num=i//8-4+(tablet.page-1)*8
					keyboard.isCalled=true
	   	keyboard.text=notes_buffer[i//8-4+(tablet.page-1)*8]
	   	keyboard.maximal_string=20
	   	keyboard.id=2
					sync(1,6,false)
					sync(32,6,false)
				end
			end
		end
	elseif m.ind==17 then
	 if settings.page==2 then
	 	if settings.sounds==true then
	 	 sfxPlay(8,"F-4",-1,0,15,1)
 		end
 	 if main.isPc==false then
 		 main.isPc=true
 			pmem(254,1)
 		else
 		 main.isPc=false
	 		pmem(254,0)
	 	end
  end
	elseif m.ind==18 then
	 if settings.sounds==true then
		 sfxPlay(5,"F-5",-1,1,15,1)
		end
	 main.inventory=false
		main.game=true
		p.objectID=0
	elseif m.ind==19 then
		for i=80,160,12 do
		 for b=30,110,12 do
	  	if m.x>i and m.x<i+7 and m.y>b and m.y<b+7 and o[p.objectID][16][2][(i//12-6)+((b//12-2)*7)+1]~=nil then
				 var=p.objectID
					varTrash=0
					varBlood=0
					if settings.sounds==true then
					 sfxPlay(3,"D-1",-1,1,15,1)
						sfxPlay(5,"F-5",-1,2,15,1)
					end
					for y=1,objData.total do
					 if o[y][15]==o[var][16][2][(i//12-6)+((b//12-2)*7)+1] then
						 o[var][16][1]=o[var][16][1]-o[y][14]
							for h=1,100 do
							 if o[var][16][2][h]~=nil then
								 for k=1,objData.total do
									 if o[var][16][2][h]==o[k][15] then
										 for j=276,283 do
											 if o[k][1]==j then
												 varTrash=varTrash+o[k][14]
													break
												end
											end
											break
										end
									end
								else
								 break
								end
							end
							for j=276,283 do
							 if o[y][1]==j then
								 varTrash=varTrash-o[y][14]
							 end
							end
							if o[var][16][1]>8 or o[var][16][1]<0 then
							 o[var][16][1]=0
							end
							if o[var][16][1]<=1.0 then
							 o[var][1]=math.floor(o[var][16][1]*3+146)
							else
							 o[var][1]=149
							end
							p.objectID=y
 	  		 table.remove(o[var][16][2],(i//12-6)+((b//12-2)*7)+1)
				  	p.isHold=true
	   			main.inventory=false
		   		main.game=true
	  		 	break
			   end
	  		end
   	 break
	  	end
	  end
  end
	elseif m.ind==20 then
	 if settings.sounds==true then
		 sfxPlay(8,"F-4",-1,1,15,1)
		end
	 if tablet.base==false then
	  tablet.brief=false
 		tablet.note=false
	  tablet.base=true
			tablet.page=1
			tablet.totalPages=11
			if tablet.baseChoose==0 then
			 tablet.dem=2
			else
			 tablet.dem=3
			end
		else
		 tablet.base=false
			tablet.brief=true
			tablet.page=1
			tablet.totalPages=4
			tablet.dem=1
		end
	elseif m.ind==21 then
	 if tablet.base==true then
			for i=40,80,20 do
			 if m.y>i and m.y<i+16 then
				 if tabletBase[i//20-4+tablet.page*3]~=nil then
 			  if settings.sounds==true then
		     sfxPlay(8,"F-4",-1,1,15,1)
		    end
						tablet.baseChoose=i//20-4+tablet.page*3
					 tablet.dem=3
						tablet.page=0
						tablet.totalPages=0
						break
				 end
				end
			end
		end
	elseif m.ind==22 then
	 if settings.sounds==true then
		 sfxPlay(8,"F-4",-1,1,15,1)
	 end
	 tablet.baseChoose=0
		tablet.dem=2
		tablet.totalPages=11
		tablet.page=1
	elseif m.ind==23 then
		if settings.page<settings.maxpages then
 	 settings.page=settings.page+1
			if settings.sounds==true then
		  sfxPlay(8,"F-4",-1,0,15,1)
	  end
	 end
	elseif m.ind==24 then
		if settings.page>1 then
		 settings.page=settings.page-1
			if settings.sounds==true then
		  sfxPlay(8,"F-3",-1,0,15,1)
	  end
		end
	elseif m.ind==25 then
	 if settings.sounds==false then
		 sfxPlay(8,"F-4",-1,0,15,1)
		 settings.sounds=true
			pmem(253,0)
		else
		 settings.sounds=false
			pmem(253,1)
		end
	elseif m.ind==26 then
	 if settings.sounds==true then
		 sfxPlay(5,"F-5",-1,1,15,1)
		end
	 main.pause=false
		main.game=true
	elseif m.ind==27 then
	 reset()
 end
end

--this just single used text. Totaly useless!
function otherStuff()
 instr="Instrument: "
end

function message(msg1,clr1)
 messageReport.msg=msg1
	messageReport.clr=clr1
	messageReport.timer=time()+5000
end

--loading algorythm of map preview in main screen
function map_preview()
 if mapc.mapTimer==0 then
	 mapc.mapViewX=0
		mapc.mapViewY=0
	elseif mapc.mapTimer>0 and mapc.mapTimer<240 then
	 mapc.mapViewX=mapc.mapViewX+0.45
		mapc.mapViewY=mapc.mapViewY+0.55
	elseif mapc.mapTimer==240 then
	 mapc.mapViewX=240
		mapc.mapViewY=136
	elseif mapc.mapTimer>240 and mapc.mapTimer<560 then
	 mapc.mapViewX=mapc.mapViewX-0.75
		mapc.mapViewY=mapc.mapViewY-0.25
	elseif mapc.mapTimer==560 then
	 mapc.mapTimer=-1
	end
	mapc.mapTimer=mapc.mapTimer+1
end

function keyboard_action()
 if keypKeys[1]=="Q" and keyboard.isShift==false then
	 for i=1,26 do
		 keypKeys[i]=string.lower(keypKeys[i])
		end
	end
	if keyboard.text~=nil then
	 keyboard.textLenght=string.len(keyboard.text)
 else
	 keyboard.textLenght=0
		keyboard.text=""
	end
	if m.bl==true and m.tl==true then
	 m.tl=false
		if keyboard.textLenght<keyboard.maximal_string then
   for i=10,220,22 do
	   if m.x>i and m.x<i+16 and m.y>56 and m.y<72 then
     if settings.sounds==true then
					 sfxPlay(13,"E-4",-1,0,15,0)
					end
					if keyboard.isNumeric==false then
					 keyboard.text=keyboard.text..keypKeys[i//22+1]
				 	keyboard.pressed=keypKeys[i//22+1]
 		   break
					else
					 if (i//22+1)==10 then
						 var=0
						else
						 var=i//22+1
					 end
						keyboard.text=keyboard.text..var
						keyboard.pressed=keypKeys[i//22+1]
					 break
					end
	 		end
		 end
 		for i=21,212,22 do
	 	 if m.x>i and m.x<i+16 and m.y>78 and m.y<94 then
		 	 if settings.sounds==true then
					 sfxPlay(13,"E-4",-1,0,15,0)
					end
					keyboard.text=keyboard.text..keypKeys[i//22+11]
			  keyboard.pressed=keypKeys[i//22+11]
					break
				end
 		end
			for i=32,170,22 do
			 if m.x>i and m.x<i+16 and m.y>100 and m.y<116 then
				 if settings.sounds==true then
					 sfxPlay(13,"E-4",-1,0,15,0)
					end
					keyboard.text=keyboard.text..keypKeys[i//22+19]
					keyboard.pressed=keypKeys[i//22+19]
				 break
				end
			end
			if m.x>76 and m.x<188 and m.y>120 and m.y<136 then
			 if settings.sounds==true then
				 sfxPlay(13,"E-4",-1,0,15,0)
				end
				keyboard.text=keyboard.text.." "
				keyboard.pressed="space"
			end
	 end
  if m.x>186 and m.x<202 and m.y>100 and m.y<116 then
		 if settings.sounds==true then
			 sfxPlay(13,"E-4",-1,0,15,0)
		 end
			keyboard.pressed="BS"
			for i=1,keyboard.textLenght do
			 keyboard_buffer[i]=string.byte(keyboard.text,i)
		 end
			keyboard.text=""
			for i=1,keyboard.textLenght-1 do
			 keyboard.text=keyboard.text..string.char(keyboard_buffer[i])
	  end
			for i=1,keyboard.textLenght do
			 keyboard_buffer[i]=nil
			end
		end
		if m.x>10 and m.x<26 and m.y>100 and m.y<116 then
		 if settings.sounds==true then
			 sfxPlay(13,"E-4",-1,0,15,0)
			end
			if keyboard.isShift==false then
			 keyboard.isShift=true
				if keypKeys[1]=="q" then
		 	 for i=1,26 do
			 	 keypKeys[i]=string.upper(keypKeys[i])
				 end
			 end
			else
			 keyboard.isShift=false
				if keypKeys[1]=="Q" then
				 for i=1,26 do
					 keypKeys[i]=string.lower(keypKeys[i])
					end
				end
			end
		elseif m.x>21 and m.x<37 and m.y>120 and m.y<136 then
		 if settings.sounds==true then
			 sfxPlay(13,"E-4",-1,0,15,0)
			end
			if keyboard.isNumeric==false then
			 keyboard.isNumeric=true
			else
			 keyboard.isNumeric=false
			end
		end
	 if m.x>216 and m.x<232 and m.y>84 and m.y<116 then
			if settings.sounds==true then
			 sfxPlay(13,"E-4",-1,0,15,0)
			end
			if keyboard.id==1 then
			 nickname_buffering("in")
				keyboard.isCalled=false
			else
			 notes_num=notes_num+1
				keyboard.text=notes_buffer[notes_num]
			end
  elseif m.x>208 and m.x<216 and m.y>100 and m.y<116 then
			if settings.sounds==true then
			 sfxPlay(13,"E-4",-1,0,15,0)
			end
			if keyboard.id==1 then
		 	nickname_buffering("in")
				keyboard.isCalled=false
			else
			 notes_num=notes_num+1
				keyboard.text=notes_buffer[notes_num]
			end
		elseif m.x>199 and m.x<215 and m.y>122 and m.y<136 then
		 if settings.sounds==true then
				sfxPlay(13,"E-4",-1,0,15,0)
			end
			keyboard.isCalled=false
			if keyboard.id==2 then
			 sync(1,0,false)
				sync(32,0,false)
			end
		end
	end
	keyboard.cursor=print(keyboard.text,241,0)*2+10
	if keyboard.id==1 then
	 nickname=keyboard.text
	elseif keyboard.id==2 then
	 notes_buffer[notes_num]=keyboard.text
	end
end

function pmeming()
 if pmem(255)~=0 then
	 settings.customNick=true
	end
	if pmem(254)~=0 then
	 main.isPc=true
	end
	if pmem(253)~=1 then
	 settings.sounds=true
	else
	 settings.sounds=false
	end
	if pmem(252)~=0 then
	 main.hasSave=true
	else
	 main.hasSave=false
	end
end

function nickname_buffering(in_out)
 var=0
 if pmem(200)~=0 and in_out=="out" then
	 for i=1,12 do
		 if pmem(i+199)~=0 then
			 var=var+1
			else
			 break
			end
		end
		for i=1,var do
		 keyboard_buffer[i]=pmem(i+199)
		end
		nickname=""
		for i=1,var do
		 nickname=nickname..string.char(keyboard_buffer[i])
  end
		for i=1,var do
		 keyboard_buffer[i]=nil
		end
		var=nil
	elseif in_out=="in" then
	 var=12
		for i=1,var do
		 keyboard_buffer[i]=string.byte(nickname,i)
		end
		for i=1,var do
		 pmem(i+199,keyboard_buffer[i])
			keyboard_buffer[i]=nil
		end
		var=nil
	end
end

function func_footprint()
 for i=1,bloodTotal do
 	if blood[i]~=nil then
   if p.x>blood[i][1]-8 and p.x<blood[i][1] and p.y>blood[i][2]-8 and p.y<blood[i][2] and blood[i][4]~=261 and blood[i][4]~=263 then
				if p.footprints_qt==0 then
		 		p.footprints_qt=math.random(4,12)
					if blood[i][4]==262 then
					 p.footprints_spr=263
					else
					 p.footprints_spr=261
					end
				end
			end
	 end
 end
	if p.footprints_qt~=0 then
	 p.footprints_timer=p.footprints_timer+1
		if p.footprints_timer>=15 then
		 bloodTotal=bloodTotal+1
			blood[bloodTotal]={}
			blood[bloodTotal][1]=p.x+math.random(2,6)
			blood[bloodTotal][2]=p.y+math.random(2,6)
			blood[bloodTotal][3]=p.angle
			blood[bloodTotal][4]=p.footprints_spr
			p.footprints_timer=0
			p.footprints_qt=p.footprints_qt-1
		end
	end
end

function func_poke4(addr,state,value)
	poke4(addr*2+state,value)
end

--everything in this function calls once before TIC()
function init()
	sync(1,6,false)
	sync(2,6,false)
	sync(4,6,false)
	sync(32,6,false)
	briefing.name=random_names[math.random(1,10)]
	for i=1,100 do
	 if btns[i]==nil then
		 break
	 else
		 m.totalButtons=m.totalButtons+1
		end
	end
	for i=1,100 do
	 textlenght[i]=0
	end
	otherStuff()
	pmeming()
	if pmem(200)~=0 then
 	nickname_buffering("out")
	end
end

init()
