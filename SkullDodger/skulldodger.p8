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
 player_size={5,5}
 coords={} --tracks current player position

 --set variables for enemy data
 skull_size={5,5}
 skull_freq=5 --how often skulls are spawned
 skull_speed=1 --how fast skulls move
 skulls={} --skulls to display on screen

 cls()
 titleinit()
end


function collided(c1, s1, c2, s2)
 --see if player sprite came in contact with enemy sprite
 return
  c1[1] < c2[1] + s2[1] and
  c2[1] < c1[1] + s1[1] and
  c1[2] < c2[2] + s2[2] and
  c2[2] < c1[2] + s1[2]
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
   gameoverupdate() --game over
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

skulls={} --reset number of skulls on screen

 cls()
 print("- game over -",30,50,4)
 print("press <action> to restart",10,56,4)
 if btnp(4) then titleinit() end
end

function gameupdate()
 --the game code, updates every frame, 30fps

 cls() --clear screen every frame

coords={playerx, playery} --set coordinates for collision

 if btn(0) then playerx-=player_speed end
 if btn(1) then playerx+=player_speed end
 if btn(2) then playery-=player_speed end
 if btn(3) then playery+=player_speed end 

 --make sure player doesn't leave play field
 if playerx <= 0 then playerx=0 end
 if playerx >= 127-player_width then playerx=127-player_width end
 if playery <= 0 then playery=0 end
 if playery >= 127-player_width then playery=127-player_width end

if (frame % skull_freq == 0) then
 add(skulls, {rnd(128 - skull_size[1]),(- skull_size[2])})
end

 for drop in all(skulls) do
  drop[2] += skull_speed
   if drop[2] > 128 then
    del(skull,drop)
   elseif collided(
   drop, skull_size, coords, player_size
    )
   then
     mode=2
  end
 end

 --for debugging: clear screen, write simple text
 print("<action> to get game over",10,122,7)

spr(3,playerx,playery)

--for debugging only: display the current frame
--print("frame:",0,0,7)
--print(frame,24,0)

score=flr(frame/30)

if highscore <= score then
 highscore = score
end

print("score: ",0,0,7)
print(score,24,0)

print("high score: ",0,6,7)
print(highscore,44,6)

 for drop in all(skulls) do
  spr(0,drop[1],drop[2])
 end

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
__label__
77707770777077707770000077707770777000000000000000000000000000000000000000000007777777770007700770077077707770000007770000000000
70007070707077707000070000700070700000000000000000000000000000000000000000000007707777700070007000707070707000070000070000000000
77007700777070707700000077707770777000000000000000000000000000000000000000000007707077700077707077777077007700000000070000000000
70007070707070707000070070007000007000000000000000000000000000000000000000000007777777000000707770707770707000070000070000000000
70007070707070707770000077707770777000000000000000000000000000000000000000000000777770000077000770777770707770000000070000000000
00000000000000000000000000000000000000000777770000000000000000000000000000000000707070000000000770707700000000000000000000000000
00000000000000000000000000000000000000007707077000000000000000000000000000000000000000000000000777777700000000000000000000000000
00000000000000000000000000000000000000007707077000000000000000000000000000000000000000000000000077777000000000000000000000000000
00000000000000000000000000000000000000007707077000000000777770000000000000000000000000000000000070707000000000000000000000000000
00000000000000000000000000000000000000007777777000000007707077000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000777770000000007707077000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000707070000000007707077000000000000000777770000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000007777777000000000000007707077000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000777770000000000000007707077000000000000000000000000000000000000000000000
00000000000000000000000000000000000000077777000000000000707070000000000000007707077000000000000000000000000000000000000000000000
00000000000000000000000000000000000000770707700000000000000000000000000000007777777000000000000000000000000000000000000000000000
00000000000000000000000000000000000000770707700000000000000000000000000000000777770000000000000000000000000000000000000000000000
00000000000000000000000000000000000000770707700777770000000000000000000000000707070000000000000000000000000000000000000000000000
00000000000000000000000000000000000000777777707707077000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000077777007707077000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000070707007707077777700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000007777777070770000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000777777070770000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007777707077070770000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000077070770077777770000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000077070770007777700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000077070770007070700000000000007777700000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000077777770000000000000000000077070770000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007777700000000000000000000077070770000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007070700000000000000000000077070770000000007777700000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000077777770000000077070770000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000007777700000000077070770000000000000000000000000000000000000
00000000000000000000000000000000000777770000000000000000000000000000007070700000000077070770000000000000000000000000000000000000
00000000000000000000000000000000007707077000000000000000000000000000000000000000000077777770000000000000000000000000000000000000
00000000000000000000000000000000007707077000000000000000000000000000000000000000000007777700000000000000000000000000000000000000
00000000000000000000000000000000007707077000000000000000000000000000000000000000000007777700000000000000000000000000000000000000
00000000000000000000000000000000007777777000000000000000000000000000000000000000000077070770000000000000000000000000000000000000
00000000000000000000000000000000000777770000000000000000000000000000000000000000000077070770000000000000000000000000000000000000
00000000000000000000000000000000000707070000000000000000000000000000000000000000000077070770000007777700000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000077777770000077070770000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000007777700000077070770000000000000000000000000
00000777770000000000000000000000000000000000000000000000000000000000000000000000000007070700000077070770000000000000000000000000
00007707077000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777770000000000000000000000000
00007707077000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777700000000000000000000000000
00007707077000000000000000000000000000000000000000000000000000000000007777700000000000000000000007070700000000000000000000000000
00007777777000000000000000000000000000000000000000000000000000000000077070770000000000000000000000000000000000000000000000000000
00000777770000000000000000000000000000000000000000000000000000000000077070770000000000000000000000000000000000000000000000000000
00000707070000000000000000000000000000000000000000000000000000000000777770770000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000007777777770000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000007707777700000000000000000000000000000000000000000000000000000
00000000000000000000000000000777770000000000000000000000000000000007707077700000000000000000000000000000000000000000000000000000
00000000000000000000000000007707077000000000000000000000000000000007777777000000000000000000000000000000000000000000000000000000
00000000000000000000000000007707077000000000000000000000000000000000777770000000000000000000000000000000000000000000000000000000
00000000000000000000000000007707077000000000000000000000000000000000707070000000000000007777700000000000000000000000000000000000
00000000000000000000000000007777777000000000000000000000000000000000000000000000000000077070770000000000000000000000000000000000
00000000000000000000000000000777770000000000000000000000000000000000000000000000000000077070770000000000000000000000000000000000
00000000000000000000000000000707070000000000000000000000000000000000000000000000000000077070770000000000077777000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000077777770000000000770707700000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777700000000000770707700000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000007070700000000077777707700000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770777777700000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770777777000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000777770000000000000000000000770777707000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000007707077000000000000000000000777777700000000000000000000
00000000000000000000000000000000000000000000000000000000000000000aaa000007707077000000000000000000000077777000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000a0a0a00007777777000000000000000000000070707000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000aaaaa00007777777000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000a000a00007777777000000000000000000000000000000000000000000000000
00000000000000777770000000000000000000000000000000000000000000000aaa000007707077000000000000000000000000000000000000000000000000
00000000000007707077000000000000000000000000000000000000000000000000000007777777000000000000000000000000000000000000000000000000
00000000000007707077000000000000000000000000000000000000000000000000000000777770000000000000000000000000000000000000000000000000
00000000000007707077000000000000000000000000000000000000777770000000000000707070000000000000000000000000000000000000000000000000
00000000000007777777000000000000000000000000000000000007707077000000000000000000000000000000000000000000000000000000000000000000
00000000000000777770000000000000000000000000000000000007707077000000000000000000000000000000000000000000000000000000000000000000
00000000000000707070000000000077777000000000000000000007707077000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000770707700000000000000000007777777000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000770707700000000000000000000777770000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000007777700770707700000000000000000000707070000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000077070770777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000077070770077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000077070770070707000000000000000000000000000000000000000000000000000000000000000000000000000000000077777000000
00000000000000000000077777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770707700000
00000000000000000000007777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770707700000
00000000000000000000007070700000000000000000000000000000000000000000000000000000000000000000000000000000000000077777770707700000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770707777777700000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000770707777777000000
00000000000000000000007777700000000000000000000000000000000000000000000000000000000000000000000000000000000000770707770707000000
00000000000000000000077070770000000000000000000000000000000000000000000000000000000000000000000000000000000000777777700000000000
00000000000000000000077070770000000000000000000000000000000000000000000000000000000000000000000000000000000000077777000000000000
00000000000000000000077070770000777770000000000000000000000000000000000000000000000000000000000000000000000000070707000000000000
00000000000000000000077777770007707077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000007777700007707077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000007070700007707077000000000777770000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000007777777000000007707077000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000777770000000007707077000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000707070000000007707077000007777700000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000007777777000077070770000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000777770000077070770000000000000000000000000000000000000000000000000000000000000000
00000000777770000000000000000000000000000000000707070000077070770000000000000000000000000000000000000000000000000000000000000000
00000007707077000000000000000000000000000000000000000000077777770000000000000000000000000000000000000000000000000000000000000000
00000007707077000000000000000000000000000000000000000000007777700000000000000000000000000000000000000000000000000000000000000000
00000007777777000000000000000000000000000000000000000000007070700000000000000000000000000000000000000000000000000000000000000000
00000007777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000007777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000007707077000000000000000000000000000000000000000000000000000000077777000000000000000000000000000000000000000000000000000000
00000007777777000000000000000000000000000000000000000000000000000000770707700000000000000000000000000000000000000000000000000000
00000000777770000000000000000000000000000000000000000000000000000000770707700000000000000000000000000000000000000000000000000000
00000000707070000000000000000000000000000000000000000000000000000000770707700000000000000000000000000000000000000000000000777770
00000000000000000000000000000000000000000000000000000000000000000000777777700000000000000000000000000000000000000000000007707077
00000000000000000000000000000000000000000000000000000000000000000000077777000000000000000000000000000000000000000000000007707077
00000000000000000000000000000000000000000000000000000000000000000000070707000077777000000000000000000000000000000000000007707077
00000000000000000000000000000000000000000000000000000000000000000000000000000770707700000000000000000000000000000000000007777777
00000000000000000000000000000000000000000000000000000000000000000000000000000770707700000000000000000000000000000000000000777770
00000000000000000000000000000000000000000000000000000007777700000000000000000770707700000000000000000000000000000000000000707070
00000000000000000000000000000000000000000000000000000077070770000000000000000777777700000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000077070770000000000000000077777000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777770000077070770000000000000000070707000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007707077000077777770000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007707077000007777700000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007707077000007070700000000000000000000000000000000000000000000000000077777000000000000
00000000000000000000000000000000000000000007777777000000000000000000000000000000000000000000000000000000000000770707700000000000
00000000000000000000000000000000000000000000777770000000000000000000000000000000000000000000000000000000000000770707700000000000
00000000000070777007707770777007707700700000707770077000000770777077777000077077707770777000000770707077707770770707700000000000
00000000000700707070000700070070707070070000000700707000007000700777707700700070707770700000007070707070007070777777700000000000
00000000007000777070000700070070707070007000000700707000007000770777707700700077707070770000007070707077007700077777000000000000
00000000000700707070000700070070707070070000000700707000007070700777707700707070707070700000007070777070007070070707000007777700
00000000000070707007700700777077007070700000000700770000007770777777777700777070707070777000007700070077707070000000000077070770
00000000000000000000000000000000000000000000000000000000000000000077777000000000000000000000000000000000000000000000000077070770

