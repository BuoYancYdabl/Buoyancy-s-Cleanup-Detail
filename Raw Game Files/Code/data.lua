--BCD alpha testing stage

----------------------------------------
-----------storage bank data------------
----------------------------------------

--players config
local pset_blood=400 --400 by default
local pset_trash=200 --200 by default
local pset_shellSpawner=20 --20 by default

--keyboard keys in order for Android and PC
local keypKeys={Q,W,E,R,T,Y,U,I,O,P,A,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M,BS}
local keypKeysPC={A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,Y,W,X,Y,Z}

--arrays that will be used if futuretotal datanot necessary data
local textlenght={}
local blood={}
local bloodTotal=0
local text_loading=asseting blood...
local o={}
local shells={}
local binsCache={}
local binsSortedCache={}

--buttons array x,y,w,h,spr(sprId,alpha,size,rotate,width,height),m.dem,isSprite
local btns={{224,0,16,16,384,11,2,0,1,1,0,true},{20,20,48,7,0,0,0,0,0,0,1,false},{15,39,58,25,0,0,0,0,0,0,2,false},{20,36,48,7,0,0,0,0,0,0,1,false},{20,68,48,7,0,0,0,0,0,0,1,false},
{16,119,8,8,13,-1,1,0,1,1,2,true},{176,28,8,8,385,11,1,0,1,1,3,true,-1},{16,119,8,8,13,-1,1,0,1,1,4,true,-1},{20,20,48,15,0,0,0,0,0,0,4,false,1},{20,44,48,23,0,0,0,0,0,0,4,false,1},
{20,76,48,15,0,0,0,0,0,0,4,false,1},{80,104,8,8,386,-1,1,0,1,1,3,true,-1},{150,104,8,8,386,-1,1,2,1,1,3,true,-1},{110,26,48,10,0,0,0,0,0,0,3,false,1},{56,26,48,10,0,0,0,0,0,0,3,false,1},
{60,40,119,63,0,0,0,0,0,0,3,false,1},{20,20,48,15,0,0,0,0,0,0,4,false,2},{164,10,16,16,387,11,2,11,1,1,5,true},{80,30,80,80,0,0,0,0,0,0,5,false},{164,28,8,8,388,11,1,0,1,1,3,true,-1},
{60,38,120,58,0,0,0,0,0,0,3,false,2},{152,28,8,8,386,11,1,0,1,1,3,true,3},{64,119,8,8,0,0,0,0,0,0,4,true,-1},{54,119,8,8,14,0,0,0,0,0,4,true,-1},{20,44,48,15,0,0,0,0,0,0,4,false,2},
{80,48,80,10,0,0,0,0,0,0,6,false},{80,72,80,10,0,0,0,0,0,0,6,false},{20,68,48,23,0,0,0,0,0,0,4,false,2}}

--object spawner replace with tile,x,y,alpha,angle,have collision,liftable,object name
local spawner_objects={{1,72,46,11,0,true,true,bucket},{1,70,53,11,0,true,true,bin},{6,135,16,11,0,true,true,bin},{6,139,17,11,0,true,true,bucket},{1,161,25,11,0,true,true,bucket},
{1,182,78,11,0,true,true,bin}}

--map choosing screen map_name,overview x,y,w,h
local mapChoosing={{Sanctuaryn    Site,0,0,2402,1362}}

--list with random names that will apear in briefing screen
local random_names={Bob,Dave,Angler,Avtojack,Binario,Gartolkin,Fred,Alfred,Adolf,Deryl}

local dispensers={
timer=500,
object=0,
item=0,
dispenser=0,
}

local keyboard={
cursor=0,
isCalled=false,
text=,
isShift=false,
isNumeric=false,
maximal_string=0,
textLenght=0,
id=0,
formated=,
pressed=,
}

local keyboard_buffer={}
local notes_buffer={}
local notes_num=0

local briefing={
name=Custom,
age=math.random(20,58),
text=Some guys just went innto our office buildingnand start to screamnabout something weirdnon factory. After allnwe understand thats,
text2=this guys is justnregular stalkers thatnjust somehow accessnthe Sanctuary Sitenfactory. We stillndont know how, they saynthat they are workers,nbut in workers list theynare not apear. We checknthem on illegal items,
text3=and found some casingsnand real workers idnthat has been stolen.nNow they are actingnwith police,nwe dont care.nNow we have a job.nEspecially for you!,
text4=On site has beennaccident with somethingnweird. There are a lotnof green goo. We`vencheck everything andnunderstand that nobodynalive. But be carefull!nGrab your mop and wentnto facility! Good luck!,
pages=4,
}

local main={
game=false,
menu=true,
settings=false,
tablet=false,
inventory=false,
mapChoose=false,
pause=false,
synced=0,
isPc=false,
isConfig=false,
}

local settings={
customNick=false,
sounds=true,
page=1,
}

local m={
x=-1,
y=-1,
bl=false,
bm=false,
br=false,
tl=true,
tr=true,
ind=0,
dem=1,
totalButtons=0,
}

local p={
x=0,
y=0,
vx=0,
vy=0,
sx=0,
sy=0,
size=15,
angle=0,
isMove=false,
isHands=false,
isMop=true,
isDetector=false,
isTablet=false,
isHold=false,
animTimer=0,
use=,
floor=1,
footprints_qt=0,
footprints_spr=0,
footprints_timer=0,
mopDirtiness=0,
humanHold=0,
objectID=0,
}

local objData={
total=0,
disp=500,
physical=0,
trashDiapasone_low=0,
trashDiapasone_max=0,
}

local fps={
count=0,
timer=1000,
value=60,
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
mapViewX=0,
mapViewY=0,
mapTimer=0,
camX=0,
camY=0,
camVX=0,
camVY=0,
}

local tablet={
brief=true,
note=false,
base=false,
dem=1,
page=1,
totalPages=0,
baseChoose=0,
}

--sprite,name,type,pickable,usable,description,isUnlocked
local tabletBase={{260,Blood,Blood,No,No,This is common object innthe facility. The red orngreen goo make peoplenfeel nausea. You neednto wash it.,false,0},{261,Footprint,Blood,No,No,You will made this if younaccidentally (ornspecially) step in blood.,false,0},{264,Human Meat,Body,Yes,No,Common part of body.nProbably shoulder.,false,31},{265,Human Guts,Body,Yes,No,Disgusting part ofnhuman body.,false,10},{267,Human Leg,Body,Yes,No,Common dismemberednhuman leg. Probablynbitten-off.,false,40},
{268,Human Arm,Body,Yes,No,Same as leg - part ofnhuman.,false,30},{269,Human Head,Body,Yes,No,His eyes will be opennforever...,false,50},{270,Human Torso,Body,Yes,No,Heavy enough part ofnhumans body - his mainnbase.,false,100},{276,Can,Trash,Yes,No,Dont forget about metalncans. They from soda ornbeans.,false,8},{278,Chips,Trash,Yes,No,That was tasty. But notnlike cake.,false,9},{280,Shell 5x74,Trash,Yes,No,This cassings leavednhere by soldiers thatnwas defending thisnfacility. Using innassault rifles.,false,2},
{282,Shell 12 Gauge,Trash,Yes,No,This bullets using innsemi or semi-autonshotguns. But now itsnonly cassings...,false,2},{131,Water Bucket,Janitors Stuff,Yes,Yes,This is bucket withnwater. You can wash mopnin it and get the newnone at dispenser.,false,210},{146,Trashbin,Janitors Stuff,Yes,Yes,Used to storage wastesnand trash in it to burnnit in incinerator later.,false,190},{498,Incinerator,Facility`s Stuff,No,Yes,This big hot machine cannburn everything you putnin it. Be carefull andndont put somethingnimportant!,true,483880},
{496,Bins Dispenser,Facility`s Stuff,No,Yes,This cool-o-matic canngive you more bins ifnyou need. But be aware -nit can give you some badnstuff...,true,275200},{497,Buckets Dispenser,Facility`s Stuff,No,Yes,Push the button - getnnew bucket with clearnwater, nothing hard.nIf it dispense leg justncall me, we wont fix it!,true,354900},{1,Floor,Facility Floor,No,No,Common indoor floor ofnSanctuary Site facility.,true,0},{64,Wall,Facility Wall,No,No,Common wall of facility.,true,0},{2,Stairs,Facility Floor,No,Yes,You can climb on secondnfloor or down on firstnby stairs.,true,0},
{4,Conveyor,Facility Floor,No,No,Dont mess with stairs ;),true,0},{13,Sand,Facility Floor,No,No,Rough sand surfacenaround facility, thatnlocates in desert.,true,0},{7,Asphalt,Facility Floor,No,No,Road leads to fence.,true,0},{6,Struct,Facility Floor,No,No,The metal struct.,true,0},{16,Tiles,Facility Floor,No,No,Tiled floor located innelevators.,true,0},{65,Window,Facility Wall,No,No,Heavy glass sections.,true,0},{66,Elevator,Facility Wall,No,No,The case of elevator.,true,0},{67,Fence,Facility Wall,No,No,Fence that set up tonfacility perimeter.,true,0},
{76,Crate,Facility Design,No,No,Crates with stuff.,true,0},{93,Barrel,Facility Design,No,No,Barrels with wastes.,true,0},{77,Buttons,Facility Design,No,No,Buttons fornmanipulating diferentnmachines on facility.,true,0},{84,Computer,Facility Design,No,No,Old computers innfacility`s offices.,true,0},{81,Chair,Facility Design,No,No,Old rusty chairs.,true,0}}

local sniffer={
isBloodOn=false,
isTrashOn=false,
dist=999999,
t=0,
}

local messageReport={
timer=0,
msg=,
clr=0,
}

local save={
blood=0,
}

local t=0
local bloodRemain=0 --usused
local bloodLimit=2000
local nickname=Player
local version=version 1.0.0

--special developers initials that developer cant call
local tabletView__48={{48,20},{184,20},{48,108},{184,108}}
local poke4Mop={10392,10393,10394,10408,10409,10410,12467,12469,12475,12476,12478}
local sfxCode={C-,C#,D-,D#,E-,F-,F#,G-,G#,a-,a#,b-,0,0}