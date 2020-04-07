----------------------------------------
--players animations and actions bank---
----------------------------------------

--the name says about itself
function player_additionalAnim()
 --resets player animation if it launched too long
 if main.game==true then
  if p.animTimer<time() then
	  p.use=""
 	end

  --swipes object that player has in his hands
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

	 --dispenser objects
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
	end
end

--change instruments in order
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
		sniffer.isBloodOn=false
		sniffer.isTrashOn=false
	else
	 p.isTablet=false
		p.isMop=true
	end
	if settings.sounds==true then
	 sfxPlay(7,"C-4",-1,1,15,1)
 end
end

--animations for player movement
function player_hudMove()
 if settings.sounds==true then
  if t%30//5==3 then
	  sfxPlay(1,"C-1",-1,0,15,2)
	 end
 end
	if p.isMop==true then
	 spr(402,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif p.isHands==true and p.isHold==false then
	 if t%60//15==1 or t%60//15==3 then
	  spr(400,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,t%60//30*var,p.angle,2,2)
	 else
		 spr(256,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
		end
	elseif p.isHands==true and p.isHold==true then
	 spr(432,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif p.isDetector==true then
	 if t%60//15==1 or t%60//15==3 then
		 spr(404+(t%60//30)*2,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
		else
		 spr(408,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
		end
	else
	 spr(410,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	end
end

--this is how player looks when he do nothing
function player_hudIdle()
 if p.isMop==true then
	 spr(402,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif p.isHands==true and p.isHold==false then
	 spr(256,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif p.isHands==true and p.isHold==true then
	 spr(432,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif p.isDetector==true then
	 spr(408,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	else
	 spr(410,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	end
end

--animations when player do some activity (trying to lift the object or to remove the blood)
function player_hudactivity(mop,hand,detect,tablet,use)
 if mop==true then
	 spr(434,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif hand==true and use=="prim" then
	 spr(432,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif hand==true and use=="alt" then
	 spr(464,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif detect==true then
	 spr(436,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	elseif tablet==true then
	 spr(410,112+p.x-mapc.camX,56+p.y-mapc.camY,11,1,0,p.angle,2,2)
	end
end

--when player doing something
function player_isDo(mop,hand,detect,tableted,use)
 if mop==true and use=="prim" then
	 if settings.sounds==true then
		 sfxPlay(2,"F-2",-1,1,15,1,"F-2","a#2")
		end
		for i=0,bloodTotal do
			if blood[i]~=nil and math.floor(p.mopDirtiness)+math.floor((p.mopDirtiness-math.floor(p.mopDirtiness))*10)<7 then
				if p.x>blood[i][1]-16 and p.x<blood[i][1]+8 and p.y>blood[i][2]-16 and p.y<blood[i][2]+8 then
					if bloodTotal>0 then
					 if blood[i][4]==260 or blood[i][4]==261 then
 					 p.mopDirtiness=p.mopDirtiness+1
		 			else
						 p.mopDirtiness=p.mopDirtiness+0.1
						end
						table.remove(blood,i)
				 	bloodTotal=bloodTotal-1
						var=math.floor(p.mopDirtiness)+math.floor((p.mopDirtiness-math.floor(p.mopDirtiness))*10)
						if math.floor(p.mopDirtiness)>math.floor((p.mopDirtiness-math.floor(p.mopDirtiness))*10) then
							var1,var2,var3=6,4,12
						else
						 var1,var2,var3=5,4,12
						end
						if var>6 then
		 			 for c=1,11 do
			 			 func_poke4(0x6000,poke4Mop[c],var1)
		     end
					 elseif var>3 then
						 for c=1,11 do
						  func_poke4(0x6000,poke4Mop[c],var2)
	 	    end
		 			elseif var>1 then
			 		 for c=1,11 do
				 		 func_poke4(0x6000,poke4Mop[c],var3)
		     end
						end
				  break
					end
				end
	  elseif math.floor(p.mopDirtiness)+math.floor((p.mopDirtiness-math.floor(p.mopDirtiness))*10)>=7 and bloodTotal<bloodLimit then
			 bloodTotal=bloodTotal+1
			 blood[bloodTotal]={}
				blood[bloodTotal][1]=p.x+4
				blood[bloodTotal][2]=p.y+4
				blood[bloodTotal][3]=math.random(0,3)
				if math.floor(p.mopDirtiness)>math.floor((p.mopDirtiness-math.floor(p.mopDirtiness))*10) then
			  var=260
				else
				 var=262
				end
				blood[bloodTotal][4]=var
				break
			end
	 end
	elseif mop==true and use=="use" then
	 for b=1,objData.total do
			if p.x>o[b][2]-19 and p.x<o[b][2]+o[b][8]*8+4 and p.y>o[b][3]-19 and p.y<o[b][3]+o[b][9]*8+4 and o[b][12]=="bucket" then
 			if settings.sounds==true then
		   sfxPlay(2,"F-2",-1,1,15,0,"F-2","a#2")
		  end
				if o[b][16][1]+o[b][16][2]<30 and o[b][1]~=130 and o[b][1]~=140 and p.mopDirtiness>0 then
				 o[b][16][1]=o[b][16][1]+math.floor(p.mopDirtiness)
					o[b][16][2]=o[b][16][2]+math.floor((p.mopDirtiness-math.floor(p.mopDirtiness))*10)
					p.mopDirtiness=0
					for c=1,11 do
					 func_poke4(0x6000,poke4Mop[c],14)
					end
					if o[b][16][1]+o[b][16][2]>=24 then
					 if o[b][16][1]>o[b][16][2] then
						 varBucket=0
						else
						 varBucket=2
						end
					else
					 varBucket=0
					end
					o[b][1]=(o[b][16][1]+o[b][16][2])/6+131+varBucket
					varTemp=true
	 	 	break
				elseif o[b][16][1]+o[b][16][2]>=30 then
				 if o[b][16][1]>o[b][16][2] then
					 p.mopDirtiness=7
						var=6
					else
					 p.mopDirtiness=0.7
						var=5
					end
					for c=1,11 do
					 func_poke4(0x6000,poke4Mop[c],var)
					end
				 break
				end
		 end
		end
 elseif hand==true and use=="prim" and dispensers.timer>=121 then
	 if settings.sounds==true then
		 sfxPlay(3,"D-1",-1,1,15,1)
		end
		for i=1,objData.total do
		 if p.x+19>o[i][2] and p.x-3<o[i][2]+o[i][8]*8 and p.y+19>o[i][3] and p.y-3<o[i][3]+o[i][9]*8 and p.isHold==false then
				if o[i][11]==true then
		 		p.isHold=true
			 	p.objectID=i
					if o[i][1]==150 then
					 o[i][1]=146
					elseif o[i][1]==140 then
					 o[i][1]=130
					end
					if i==objData.total and dispensers.timer<120 then
					 p.isHold=false
						p.objectID=0
					end
		  	break
				elseif o[i][11]==false and dispensers.timer>=121 then
				 var=true
					for b=1,objData.total do
					 if math.floor(o[b][2])==o[i][2]-9 and math.floor(o[b][3])==o[i][3]+4 or math.floor(o[b][2])==o[i][2]+16 and math.floor(o[b][3])==o[i][3]+4 or math.floor(o[b][2])==o[i][2]+4 and math.floor(o[b][3])==o[i][3]-9 or math.floor(o[b][2])==o[i][2]+4 and math.floor(o[b][3])==o[i][3]+16 then
							if o[b][12]~="incinerator" and o[b][12]~="dispenser water" and o[b][12]~="dispenser trash" then
					 		var=false
					 		break
						 end
						else
						 var=true
						end
					end
					if var==true then
						if o[i][12]=="dispenser trash" then
			  	 if math.random(0,100)>20 then
		 					objData.total=objData.total+1
  	 				o[objData.total]={}
      		o[objData.total][1]=146
	   	 	 o[objData.total][2]=o[i][2]+4
		     	o[objData.total][3]=o[i][3]+4
   		 	 o[objData.total][4]=-1
 	 		   o[objData.total][5]=1
  	  	  o[objData.total][6]=0
 	  		  o[objData.total][7]=o[i][7]+1
     	 	o[objData.total][8]=1
	     		o[objData.total][9]=1
		      o[objData.total][10]=true
 			    o[objData.total][11]=true
    		  o[objData.total][12]="bin"
  	  			o[objData.total][13]=2
	 			  	o[objData.total][14]=0
				    objData.disp=objData.disp+1
								o[objData.total][15]=objData.disp
								o[objData.total][16]={}
	 	  			o[objData.total][16][1]=0
  			 		o[objData.total][16][2]={}
		  		 	dispensers.timer=0
				  	 dispensers.object=objData.total
 						 dispensers.dispenser=i
   					break
		  		 else
							 math_random=math.random(265,268)
							 objData.total=objData.total+1
  	 				o[objData.total]={}
      		o[objData.total][1]=math_random
	   	 	 o[objData.total][2]=o[i][2]+4
		     	o[objData.total][3]=o[i][3]+4
   		 	 o[objData.total][4]=11
 	 		   o[objData.total][5]=1
  	  	  o[objData.total][6]=0
 	  		  o[objData.total][7]=math.random(0,3)
     	 	o[objData.total][8]=1
	     		o[objData.total][9]=1
		      o[objData.total][10]=false
 			    o[objData.total][11]=true
  	  			o[objData.total][13]=1
								objData.disp=objData.disp+1
	  				 o[objData.total][15]=objData.disp
								if math_random>=276 and math_random<=277 then
    		   o[objData.total][12]="trash can"
				    	o[objData.total][14]=0.08
     		 elseif math_random>=278 and math_random<=279 then
	 	      o[objData.total][12]="trash chips"
    					o[objData.total][14]=0.09
 		     elseif math_random==264 then
    				 o[objData.total][12]="human meat"
				    	o[objData.total][14]=0.31
    				elseif math_random>=265 and math_random<=266 then
	 			    o[objData.total][12]="human guts"
    					o[objData.total][14]=0.10
				    elseif math_random==267 then
    				 o[objData.total][12]="human leg"
				    	o[objData.total][14]=0.4
    				elseif math_random==268 then
				     o[objData.total][12]="human arm"
    				 o[objData.total][14]=0.3
				    elseif math_random==269 then
    				 o[objData.total][12]="human head"
				    	o[objData.total][14]=0.5
    				elseif math_random==270 then
				     o[objData.total][12]="human torso"
    					o[objData.total][14]=1.1
			    	end
								o[objData.total][16]={}
	 	  			o[objData.total][16][1]=0
  			 		o[objData.total][16][2]={}
		  		 	dispensers.timer=0
				  	 dispensers.object=objData.total
 						 dispensers.dispenser=i
								break
							end
						elseif o[i][12]=="dispenser water" then
				  	if math.random(0,100)>20 then
 							objData.total=objData.total+1
   					o[objData.total]={}
      		o[objData.total][1]=131
	      	o[objData.total][2]=o[i][2]+4
		    	 o[objData.total][3]=o[i][3]+4
   		  	o[objData.total][4]=11
	   		  o[objData.total][5]=1
 		     o[objData.total][6]=0
  	 		  o[objData.total][7]=o[i][7]+1
     	 	o[objData.total][8]=1
	     		o[objData.total][9]=1
		      o[objData.total][10]=true
 			    o[objData.total][11]=true
    	 	 o[objData.total][12]="bucket"
 	  		 	o[objData.total][13]=2
				  	 o[objData.total][14]=0
 	 				 objData.disp=objData.disp+1
								o[objData.total][15]=objData.disp
								o[objData.total][16]={}
		   			o[objData.total][16][1]=0
			 	  	o[objData.total][16][2]=0
				 		 dispensers.timer=0
  			 		dispensers.object=objData.total
		  		 	dispensers.dispenser=i
				  	 break
  				 else
							 math_random=math.random(265,268)
							 objData.total=objData.total+1
  	 				o[objData.total]={}
      		o[objData.total][1]=math_random
	   	 	 o[objData.total][2]=o[i][2]+4
		     	o[objData.total][3]=o[i][3]+4
   		 	 o[objData.total][4]=11
 	 		   o[objData.total][5]=1
  	  	  o[objData.total][6]=0
 	  		  o[objData.total][7]=math.random(0,3)
     	 	o[objData.total][8]=1
	     		o[objData.total][9]=1
		      o[objData.total][10]=false
 			    o[objData.total][11]=true
  	  			o[objData.total][13]=1
	  				 objData.disp=objData.disp+1
								o[objData.total][15]=objData.disp
								if math_random>=276 and math_random<=277 then
    		   o[objData.total][12]="trash can"
				    	o[objData.total][14]=0.08
     		 elseif math_random>=278 and math_random<=279 then
	 	      o[objData.total][12]="trash chips"
    					o[objData.total][14]=0.09
 		     elseif math_random==264 then
    				 o[objData.total][12]="human meat"
				    	o[objData.total][14]=0.31
    				elseif math_random>=265 and math_random<=266 then
	 			    o[objData.total][12]="human guts"
    					o[objData.total][14]=0.10
				    elseif math_random==267 then
    				 o[objData.total][12]="human leg"
				    	o[objData.total][14]=0.4
    				elseif math_random==268 then
				     o[objData.total][12]="human arm"
    				 o[objData.total][14]=0.3
				    elseif math_random==269 then
    				 o[objData.total][12]="human head"
				    	o[objData.total][14]=0.5
    				elseif math_random==270 then
				     o[objData.total][12]="human torso"
    					o[objData.total][14]=1.1
			    	end
		  		 	dispensers.timer=0
				  	 dispensers.object=objData.total
 						 dispensers.dispenser=i
								break
							end
						end
		  	end
  	 end
	  end
		end
	elseif hand==true and use=="alt" then
	 if settings.sounds==true then
		 sfxPlay(3,"C-1",-1,1,15,1)
		end
	 var=nil
		varO=nil
		if p.isHold==true then
 		for i=1,objData.total do
				if p.x>o[i][2]-19 and p.x<o[i][2]+o[i][8]*8+4 and p.y>o[i][3]-19 and p.y<o[i][3]+o[i][9]*8+4 then
					if o[i][12]=="bin" and o[p.objectID][12]~="bin" and o[p.objectID][12]~="bucket" then
						if o[i][16][1]<1 then
							for b=1,1000 do
								if o[i][16][2][b]==nil then
									var=1
									o[i][16][2][b]=o[p.objectID][15]
									o[p.objectID][2]=-40
									o[p.objectID][3]=0
									o[i][16][1]=o[i][16][1]+o[p.objectID][14]
									varBlood=0
									varTrash=0
									for y=1,100 do
									 if o[i][16][2][y]~=nil then
								 		for h=1,objData.total do
									 		if o[h][15]==o[i][16][2][y] then
												 for k=276,283 do
													 if o[h][1]==k then
														 varTrash=varTrash+o[h][14]
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
									if o[i][16][1]<=1.0 then
									 o[i][1]=math.floor(o[i][16][1]*3+146)
									else
									 o[i][1]=149
									end
									break
								end
							end
						end
		 			p.isHold=false
						break
 			 elseif o[i][12]=="incinerator" and p.isHold==true then
	 				varO=true
						if o[p.objectID][12]=="bin" then
						 var=o[p.objectID][15]
							for h=1,100 do
							 for z=1,objData.total do
								 if o[z][15]==var and o[z][12]=="bin" then
									 p.objectID=z
									 break
									end
								end
								if o[p.objectID][16][2][h]~=nil then
						 		for y=1,objData.total do
				 		 		if o[y][15]==o[p.objectID][16][2][h] then
								 		table.remove(o,y)
									 	objData.total=objData.total-1
										 break
					 				end
						 	 end
							 elseif o[p.objectID][16][2][h]==nil then
									break
					 		end
		  	  end
							for y=1,objData.total do
				  	 if o[y][12]=="bin" and o[y][15]==var then
						   table.remove(o,y)
					   	break
		   		 end
			    end
		    else
     	 table.remove(o,p.objectID)
	 	   end
						objData.total=objData.total-1
						break
					end
				end
			end
			if var==nil and varO==nil then
				if o[p.objectID][12]=="human meat" or o[p.objectID][12]=="human guts" or o[p.objectID][12]=="human leg" or o[p.objectID][12]=="human arm" or o[p.objectID][12]=="human head" or o[p.objectID][12]=="human torso" then
					bloodTotal=bloodTotal+1
	  		blood[bloodTotal]={}
			 	blood[bloodTotal][1]=o[p.objectID][2]
  			blood[bloodTotal][2]=o[p.objectID][3]
		  	blood[bloodTotal][3]=math.random(0,3)
					blood[bloodTotal][4]=260
				end
			end
			p.objectID=0
	  p.isHold=false
  end
	elseif hand==true and use=="use" then
	 for i=1,objData.total do
  	if p.x>o[i][2]-19 and p.x<o[i][2]+o[i][8]*8+4 and p.y>o[i][3]-19 and p.y<o[i][3]+o[i][9]*8+4 and o[i][12]=="bin" and p.isHold==false then
				if settings.sounds==true then
				 sfxPlay(4,"F-5",-1,1,15,1)
				end
				main.game=false
		  main.inventory=true
 			p.objectID=i
	 		break
			end
		end
	elseif detect==true and use=="prim" then
	 if sniffer.isBloodOn==false then
		 if settings.sounds==true then
			 sfxPlay(11,"C-1",-1,1,13,0)
			end
			sniffer.isBloodOn=true
			sniffer.isTrashOn=false
		else
		 if settings.sounds==true then
			 sfxPlay(12,"C-1",-1,1,13,0)
			end
		 sniffer.isBloodOn=false
		end
	elseif detect==true and use=="alt" then
	 if sniffer.isTrashOn==false then
		 if settings.sounds==true then
			 sfxPlay(11,"C-1",-1,1,13,0)
			end
			sniffer.isTrashOn=true
			sniffer.isBloodOn=false
		else
		 if settings.sounds==true then
			 sfxPlay(12,"C-1",-1,1,13,0)
			end
		 sniffer.isTrashOn=false
		end
	elseif tableted==true and use=="prim" then
	 if settings.sounds==true then
		 sfxPlay(4,"F-5",-1,1,15,1)
		end
		main.tablet=true
		main.game=false
		tablet.page=1
		tablet.totalPages=briefing.pages
	elseif tableted==true and use=="alt" then
  var=nil
		p.animTimer=time()
		if tabletBase[1][7]==false or tabletBase[2][7]==false then
			for i=1,bloodTotal do
	 	 if p.x>blood[i][1]-16 and p.x<blood[i][1]+8 and p.y>blood[i][2]-16 and p.y<blood[i][2]+8 then
					if blood[i][4]==260 or blood[i][4]==262 then
					 if tabletBase[1][7]==false then
		 	 	 tabletBase[1][7]=true
					 	var=0
				 	 break
	 			 end
					elseif blood[i][4]==261 or blood[i][4]==263 then
					 if tabletBase[2][7]==false then
		  		 tabletBase[2][7]=true
			 			var=0
			  		break
				  end
			  end
				end
			end
		end
		for i=1,objData.total do
 	 if p.x+19>o[i][2] and p.x-3<o[i][2]+o[i][8]*8 and p.y+19>o[i][3] and p.y-3<o[i][3]+o[i][9]*8 then
				if o[i][1]==264 then
				 if tabletBase[3][7]==false then
		 			tabletBase[3][7]=true
			 		var=0
				 	break
					end
				elseif o[i][1]==265 or o[i][1]==266 then
				 if tabletBase[4][7]==false then
					 tabletBase[4][7]=true
						var=0
						break
					end
				elseif o[i][1]==267 then
				 if tabletBase[5][7]==false then
					 tabletBase[5][7]=true
						var=0
						break
					end
				elseif o[i][1]==268 then
				 if tabletBase[6][7]==false then
					 tabletBase[6][7]=true
						var=0
						break
					end
				elseif o[i][1]==269 then
				 if tabletBase[7][7]==false then
					 tabletBase[7][7]=true
						var=0
						break
					end
				elseif o[i][1]==270 then
				 if tabletBase[8][7]==false then
					 tabletBase[8][7]=true
						var=0
					 break
					end
				elseif o[i][1]==276 or o[i][1]==277 then
				 if tabletBase[9][7]==false then
					 tabletBase[9][7]=true
						var=0
						break
					end
				elseif o[i][1]==278 or o[i][1]==279 then
				 if tabletBase[10][7]==false then
					 tabletBase[10][7]=true
						var=0
						break
					end
				elseif o[i][1]==280 or o[i][1]==281 then
				 if tabletBase[11][7]==false then
					 tabletBase[11][7]=true
						var=0
						break
					end
				elseif o[i][1]==282 or o[i][1]==283 then
				 if tabletBase[12][7]==false then
					 tabletBase[12][7]=true
						var=0
					 break
					end
				elseif o[i][1]==130 or o[i][1]==131 or o[i][1]==132 or o[i][1]==133 or o[i][1]==134 or o[i][1]==135 or o[i][1]==136 or o[i][1]==137 or o[i][1]==138 then
				 if tabletBase[13][7]==false then
					 tabletBase[13][7]=true
						var=0
						break
					end
				elseif o[i][1]==146 or o[i][1]==147 or o[i][1]==148 or o[i][1]==149 then
     if tabletBase[14][7]==false then
					 tabletBase[14][7]=true
						var=0
						break
					end
				end
			end
		end
		if var==nil then
		 message("Nothing to scan",6)
			if settings.sounds==true then
			 sfxPlay(6,"F-3",-1,1,15,-1)
			end
		elseif var==0 then
		 message("Scanned",11)
			if settings.sounds==true then
			 sfxPlay(6,"F-4",-1,1,15,-1)
			end
		end
	end
end

--checking player floor state
function player_flooring()
 if main.game==true then
 	getted=mget(((p.x+4)//8),(p.y//8))
	 if getted==14 or getted==15 then
	  if p.floor==1 then
		  p.x=p.x+240*4
 			mapc.camX=mapc.camX+240*4
	 		p.floor=2
		 elseif p.floor==2 then
		  p.x=p.x-240*4
 			mapc.camX=mapc.camX-240*4
	 		p.floor=1
		 end
 	elseif getted==0 then
	  if mget(p.x//8+1,p.y//8)==0 and mget(p.x//8,p.y//8+1)==0 and mget(p.x//8+1,p.y//8+1)==0 then
		  if p.floor==2 then
			  p.x=p.x-240*4
				 mapc.camX=mapc.camX-240*4
 				p.floor=1
	 			if p.isHold==true and math.random(0,100)<=40 then
		 		 if p.angle==0 then
			 	  o[p.objectID][2]=p.x+4
				 		o[p.objectID][3]=p.y+12
					 elseif p.angle==1 then
					  o[p.objectID][2]=p.x-4
	 					o[p.objectID][3]=p.y+4
 					elseif p.angle==2 then
		 			 o[p.objectID][2]=p.x+4
			 			o[p.objectID][3]=p.y-4
				 	else
					  o[p.objectID][2]=p.x+12
						 o[p.objectID][3]=p.y+4
 					end
	 				if o[p.objectID][12]=="bin" then
		 			 for i=1,1000 do
			 			 if o[p.objectID][16][2][1]~=nil then
				 			 for b=1,objData.total do
					 			 if o[b][15]==o[p.objectID][16][2][1] then
						 			 o[b][2]=o[p.objectID][2]+math.random(-4,4)
							 			o[b][3]=o[p.objectID][3]+math.random(-4,4)
					      if settings.sounds==true then
						      sfxPlay(2,"F-2",-1,1,15,-2,"F-2","a#2")
						     end
 										for h=264,270 do
	 									 if o[b][1]==h then
		 									 bloodTotal=bloodTotal+1
			 									blood[bloodTotal]={}
				 								blood[bloodTotal][1]=o[b][2]
					 							blood[bloodTotal][2]=o[b][3]
						 						blood[bloodTotal][3]=math.random(0,3)
							 					blood[bloodTotal][4]=260
								 			 break
									 		end
										 end
 										o[p.objectID][16][1]=0
	 									table.remove(o[p.objectID][16][2],1)
		 								break
			 						end
				 				end
					 		else
						 	 break
							 end
 						end
	 					o[p.objectID][1]=150
 		 		elseif o[p.objectID][12]=="bucket" then
	 		 	 o[p.objectID][1]=140
		 				if settings.sounds==true then
			 	 	 sfxPlay(2,"F-2",-1,1,15,-2,"F-2","a#2")
						 end
 						for i=1,o[p.objectID][16][1]+o[p.objectID][16][2] do
	 					 bloodTotal=bloodTotal+1
		 					blood[bloodTotal]={}
			 				blood[bloodTotal][1]=o[p.objectID][2]+math.random(-4,4)
				 			blood[bloodTotal][2]=o[p.objectID][3]+math.random(-4,4)
					 		blood[bloodTotal][3]=math.random(0,3)
						 	blood[bloodTotal][4]=260
 						end
	 					o[p.objectID][16][1]=-1
		 				o[p.objectID][16][2]=-1
			 		end
				 	for i=264,270 do
				  	if o[p.objectID][1]==i then
						  bloodTotal=bloodTotal+1
							 blood[bloodTotal]={}
 							blood[bloodTotal][1]=o[b][2]
	 						blood[bloodTotal][2]=o[b][3]
		 					blood[bloodTotal][3]=math.random(0,3)
			 				blood[bloodTotal][4]=260
				 			break
					 	end
 					end
	 				p.isHold=false
		 			p.objectID=0
			 	end
	 		end
		 end
	 end
 end
end

--working if player enabled sniffer on first or second range channel. Searching for blood or trash
function player_detect()
 sniffer.t=sniffer.t+1
 sniffer.dist=999999
 if sniffer.isBloodOn==true then
	 for i=1,bloodTotal do
		 sniffer.detecting=math.sqrt((p.x+4-blood[i][1])*(p.x+4-blood[i][1])+(p.y+4-blood[i][2])*(p.y+4-blood[i][2]))
   if sniffer.detecting<sniffer.dist then
				sniffer.dist=sniffer.detecting
			end
		end
	else
	 for i=1,objData.total do
		 if o[i][12]~="incinerator" and o[i][12]~="dispenser trash" and o[i][12]~="dispenser water" and o[i][12]~="human meat" and o[i][12]~="human guts" and o[i][12]~="human leg" and o[i][12]~="human arm" and o[i][12]~="human head" and o[i][12]~="human torso" then
		  sniffer.detecting=math.sqrt((p.x+((o[i][8]*8)/2)-o[i][2])*(p.x+((o[i][8]*8)/2)-o[i][2])+(p.y+((o[i][9]*8)/2)-o[i][3])*(p.y+((o[i][9]*8)/2)-o[i][3]))
    if sniffer.detecting<sniffer.dist then
				 sniffer.dist=sniffer.detecting
			 end
		 end
		end
 end
	if sniffer.isBloodOn==true then
	 varSniff1=9
		varSniff2="F-4"
	else
	 varSniff1=10
		varSniff2="F-3"
	end
	if math.floor(sniffer.dist)<120 and math.floor(sniffer.dist)>10 then
 	if sniffer.t%120>math.floor(sniffer.dist) then
			sfxPlay(varSniff1,varSniff2,-1,1,15,1)
			sniffer.t=0
	 end
	elseif math.floor(sniffer.dist)<=10 then
	 if sniffer.t%10==9 then
		 sfxPlay(varSniff1,varSniff2,-1,1,15,1)
		 sniffer.t=0
		end
	elseif math.floor(sniffer.dist)>=120 then
	 if sniffer.t%120==119 then
			sfxPlay(varSniff1,varSniff2,-1,1,15,1)
		 sniffer.t=0
		end
	end
end

--checks if player enabled sniffer
function player_snifferEnabled()
 if main.game==true then
  if p.isDetector==true and sniffer.isBloodOn==true or sniffer.isTrashOn==true then
		 player_detect()
		end
	end
end