pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--skull dodger
--a game by michael "boston" hannon

function _init()
 --initial program setup

frame=0 --track what frame we're on
score=0 --track current game score
highscore=0 --track high score across one session

 --set variables for player data
 player_width=5
 player_height=5
 player_speed=2

 --set variables for enemy data
 skull_size={5,5}
 skull_freq=10 --how often skulls are spawned
 skull_speed=3 --how fast skulls move
 skulls={} --skulls to display on screen

 cls()
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
frame=0

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

 if btn(0) then playerx-=player_speed end
 if btn(1) then playerx+=player_speed end
 if btn(2) then playery-=player_speed end
 if btn(3) then playery+=player_speed end 

 --make sure player doesn't leave play field
 if playerx <= 0 then playerx=0 end
 if playerx >= 127-player_width then playerx=127-player_width end
 if playery <= 0 then playery=0 end
 if playery >= 127-player_width then playery=127-player_width end

 if(frame%skull_freq==0) then
  add(skull,{rnd(128-skull_size[1], -skull_size[2])})
 end

 for each in all(skulls) do
  spr(0, each[1], each[2])
 end

 --for debugging: clear screen, write simple text
 cls()
 --print("this is a game",38,50,7)
 print("<action> to get game over",10,122,7)

spr(3,playerx,playery)

print("frame:",0,0,7)
print(frame,24,0)

score=frame/30 --bug: displays decimals

print("score: ",90,0,7)
print(score,115,0)


 --for debugging: press action to fail game
 if btnp(4) then mode=2 end

 frame+=1
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
