pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--skull dodger
--a game by michael "boston" hannon

function _init()
 --initial program setup
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

 --for debugging: clear screen, write simple text
 cls()
 print("this is a game",38,50,7)
 print("<action> to get game over",10,56,7)

 --for debugging: press action to fail game
 if btnp(4) then mode=2 end
end

__gfx__
07777700077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77070770770707700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77070770770707700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77070770770707700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777770777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777700077777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07070700007070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
