pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- paddle
-- by michael "boston" hannon

-- create paddle
padx=52
pady=122
padw=24
padx=4

function movepaddle()
-- move the paddle with btn 1 and 2
 if btn(0) then
  padx-=3
 elseif btn(1) then
  padx+=3
 end
end

function _update()
-- built-in function, called every 30 seconds (30 fps)
 movepaddle()
end

function _draw()
-- clear the screen, draw a background
 rectfill(0,0,128,128,3)

-- draw the paddle
 rectfill(padx,pady,padx+padw,padx+pady,15)
end
