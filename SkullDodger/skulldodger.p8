pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--skull dodger
--a game by michael "boston" hannon

function _init()
 --initial program setup

 --set variables for player size
 playerwidth=5
 playerheight=5

 cls()

frame=0 --track what frame we're on
skull_freq=10 --how often skulls are spawned

 titleinit()
end

function titleinit()
 --change mode to say we're in the menu
 music(-1,300) --stop any currently running music
 cls()
 mode=0
end

function gameinit()
 --change mode to say we're in the game itself
 mode=1

 --setting overall variables

 --set variables for player position, middle of the screen
 playerx=64
 playery=64
end

function _update()
 if (mode==0) then --title screen
  titleupdate()
 elseif(mode==1) then --playable game
  gameupdate()
 else
   gameoverupdate()
 end
end

function titleupdate()
 --draw the title screen

spr(0,38,42)
spr(1,57,42)
spr(0,77,42)
 print("skull dodger",38,50,8)
 print("by michael \"boston\" hannon",10,56,8)
 print("press <action> button",13,98,12)
 print("to start game",30,104,12)
 if btnp(4) then gameinit() end
end

function gameoverupdate()
 --game over functionality

 cls()
 print("- game over -",30,50,4)
 print("press <action> to restart",10,56,4)
 if btnp(4) then titleinit() end
end

function gameupdate()
 --the game code

 if btn(0) then playerx-=1 end
 if btn(1) then playerx+=1 end
 if btn(2) then playery-=1 end
 if btn(3) then playery+=1 end 

 --make sure player doesn't leave play field
 if playerx <= 0 then playerx=0 end
 if playerx >= 127-playerwidth then playerx=127-playerwidth end
 if playery <= 0 then playery=0 end
 if playery >= 127-playerwidth then playery=127-playerwidth end


 --for debugging: clear screen, write simple text
 cls()
 print("this is a game",38,50,7)
 print("<action> to get game over",10,56,7)

spr(3,playerx,playery)

 --for debugging: press action to fail game
 if btnp(4) then mode=2 end
end

__gfx__
0777770007777700000000000aaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77070770770707700000f000a0a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77070770770707700000f000aaaaa000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
770707707707077000055500a000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7777777077777770005577500aaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777700077777000055575000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07070700007070000055555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000005550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
