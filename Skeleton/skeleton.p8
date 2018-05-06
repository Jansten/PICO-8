pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--pico-8 code skeleton
--by michael "boston" hannon

-- [game description]

function _init()
 --initial program setup
 cls()
 titleinit()
end

function titleinit()
 --change the mode to say we're on the title screen
 music(-1,300) --make sure all music stops playing
 cls()
 mode=0
end

function gameinit()
--change mode to say we're in the game itself
mode=1

--[game code goes here]
end

--[main game functions here]

function _update()
 if (mode==0) then
  titleupdate()
 elseif (mode==1) then
  gameupdate()
 else --this maybe should be "if mode==2" to be more explicit
   gameoverupdate()
 end
end

function titleupdate()
 --draw the title screen

 print ("this game's title", 38,50,7)
 print("by michael \"boston\" hannon",10,56,7)
 print("press <action> button",13,98,12)
 print("to start game",30,104,12)
 if btnp(4) then --this is the "z" button by default
  gameinit()
 end
end

function gameoverupdate()
--game over functionality

 cls()
 print("- game over -",30,50,4)
 print("press <action> to restart",10,56,4)
 if btnp(4) then titleinit() end
end

function gameupdate()
 --all the code that is run every frame (30fps)
 end