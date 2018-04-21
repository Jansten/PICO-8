pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- michael "boston" hannon
-- simple spaceship flying game

function _init()
 t=0

 music(0)
 
 ship = {
  sp=1,
  x=60,
  y=100,
  h=4,
  p=0,
  t=0,
  imm=false,
  box = {x1=0,y1=0,x2=7,y2=7}}
 bullets = {}
 enemies = {}
 explosions = {}
 stars = {}
 
 for i=1,128 do
  add(stars,{
   x=rnd(128),
   y=rnd(128),
   s=rnd(2)+1
  })
 end
 

 start()
end

function respawn()
 local n = flr(rnd(9))+2
 for i=1,n do
  local d = -1
  if rnd(1)<0.5 then d=1 end
 add(enemies, {
  sp=17,
  m_x=i*16,
  m_y=-20-i*8,
  d=d,
  x=-32,
  y=-32,
  r=12,
  box = {x1=0,y1=0,x2=7,y2=7}
  })
 end
end

function start()
 _update = update_game
 _draw = draw_game
end

function game_over()
 _update = update_over
 _draw = draw_over
end

function update_over()

end

function draw_over()
 cls()
 print("game over",50,50,4)
end

function abs_box(s)
 local box = {}
 box.x1 = s.box.x1 + s.x
 box.y1 = s.box.y1 + s.y
 box.x2 = s.box.x2 + s.x
 box.y2 = s.box.y2 + s.y
 return box
end 
 
function coll(a,b)
 local box_a = abs_box(a)
 local box_b = abs_box(b)

 if box_a.x1 > box_b.x2 or
    box_a.y1 > box_b.y2 or
    box_b.x1 > box_a.x2 or
    box_b.y1 > box_a.y2 then
    return false
 end
 
 return true
end

function explode(x,y)
 add(explosions,{x=x,y=y,t=0})
end

function fire()
 local b = {
  sp=3,
  x=ship.x,
  y=ship.y,
  dx=0,
  dy=-3,
  box = {x1=2,y1=0,x2=5,y2=4}
 }
 add(bullets,b)
end

function update_game()
 t=t+1

 if ship.imm then
 ship.t += 1
 if ship.t >30 then
  ship.imm = false
  ship.t = 0
  end
 end
 
 for st in all(stars) do
  st.y += st.s
  if st.y >= 128 then
   st.y = 0
   st.x=rnd(128)
  end
 end
 
 for ex in all(explosions) do
  ex.t+=1
  if ex.t == 13 then
   del(explosions,ex)
  end
 end

 if #enemies <= 0 then
  respawn()
 end

 for e in all(enemies) do
  e.m_y += 1.3
  e.x = e.r*sin(t/50) + e.m_x
  e.y = e.r*cos(t/50) + e.m_y
  if coll(ship,e) and not ship.imm then
   ship.imm = true
   ship.h -= 1
   if ship.h <= 0 then
    game_over()
   end
  end

 if e.y > 150 then
  del(enemies,e)
 end
end

 for b in all(bullets) do
  b.x+=b.dx
  b.y+=b.dy
  if b.x < 0 or b.x > 128 or
   b.y < 0 or b.y > 128 then
   del(bullets,b)
  end
  
  for e in all(enemies) do
   if coll(b,e) then
    del(enemies,e)
    ship.p += 1
    explode(e.x,e.y)
   end
  end
 end

 if(t%6<3) then
  ship.sp=1
 else
  ship.sp=2
 end
 
 if btn(0) then ship.x-=1 end
 if btn(1) then ship.x+=1 end
 if btn(2) then ship.y-=1 end
 if btn(3) then ship.y+=1 end 
 if btnp(4) then fire() end
end

function draw_game()
 cls()

 for st in all(stars) do
  pset(st.x,st.y,6)
 end

 print(ship.p,9)
 if not ship.imm or t%8 < 4 then
  spr(ship.sp,ship.x,ship.y)
 end

 for b in all(bullets) do
  spr(b.sp,b.x,b.y)
 end
 
 for ex in all(explosions) do
  circ(ex.x,ex.y,ex.t/2,8+ex.t%3)
 end
 
 for e in all(enemies) do
  spr(e.sp,e.x,e.y)
 end
 
 for i=1,4 do
  if i<=ship.h then
   spr(33,80+6*i,3)
   else
   spr(34,80+6*i,3)
   end
 end
end
__gfx__
00000000008008000080080000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000008008000080080000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700008888000088880000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000008118000081180000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000088cc880088cc88000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700080990800809908000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000800a080080a008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000a00000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000bbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000bb7bb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bb707bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000b00b000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080800000c0c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000088888000ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000088800000ccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000080000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
66606660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00606060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
66606060000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000
600060600000000000000000000000000000000000000000000000000000000000000000000000000000000808000c0c000c0c000c0c00000000000000000000
66606660000000000000000000000000000000000000000000000000000000000000000000000060000000888886ccccc0ccccc0ccccc0000000000000000000
000000000000000000000000000000000000000000000000000000000000000000006000000000000000000888000ccc000ccc000ccc00000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000c00000c00000c000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000
00600000000000000000000006000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000
00000000000000000060000000000000000000000000000000060000000000000000000600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000006000000000000000000000
00000000600000000000000000000000000000000000000000000000000606000000000000000000000000000000000000000000000600000000000000000000
00000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000
00000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000000000
00600000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000
06600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000099000000000000000000000000000000000000000000000000600000000600000000000000000000
00000000000000000000000000000060000000000000000099000000000000000000006000000000000000000000000000000000000000000000000060000000
00000000000000000600000000000000000000000600000099000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000600000000006000006000000000000000000060000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600060000600000000
00000000000000000000006000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000099000006000000000000000000000000000006000000000000000000000000000000000000000000
00600000000000000060000000000000000000000000000099000000000060000000000000000000000000000000006000000000000000060000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000060000000000000000000000000000000060000000000000000000000000000000000000000000000000000
00060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000
00000000060000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000aaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000aa000aa00000009900000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000a00000a00000009900000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000a0000000a0000009900000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000a0000000a0000009900000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000a0000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000a00000a00000000000000000600000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000aa000aa00000000000000000000000000000000000600000000000000000000000000000000000000000000060
0000000000600000000000000000000000000000aaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000
000000000000000000000006000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000006000000000000000bbb000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000bb7bb00000000000000000000000000000000606000000000000
000000000000000000000000000000000000000006000000000099000000000000000000000bb707bb0000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000006000000099000000000000000000000bbbbbbb0000000000000000000000000000000000000000000000
000000000000000000000000000000000000000060000000000099600000000000600000000b00b000b000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009960000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000
00000000000000000000000000000000000000000000000000000000000000b00000000000000000000006000000000000000000000000000000000000000000
0000000000000000000000060000000000000000000000000000000000000bbb0000000000000000000000000000000000000006000000000000000000000000
000000000000000000000006000000000000000000000000000000000000bb7bb000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000bb707bb00000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000006bbbbbbb00000000000000000000000000000000000000000006000000000000000000
00000000000000000000000000000000000000000000000000000000000b00b000b0000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009900000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009900000000000000000000000000000000000000000000000000000000000000000000000006
00000000000000000000000000000000000000000000000000009900000000000000000000000000000000000000000000000000000000000000000000000000
00000060000000000000000000000000000000000060000000009900000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000006000000006000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000bbb000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000060
0000000000000000000000000006bb7bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000bb707bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000
000000000000000000000000000bbbbbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000b00b000b006000000000000000000000000000000000006000000000000000000000000000000000000000000000000000600
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000
00000000600000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009900000000000000000000000000006000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009900000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009900000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000006000000000000089980000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000080080000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000600000000000000000000000000000088880000000000000000000000000000000000000000000000000000000000000000000000000
00600000000000000000000000000000000000000000000000081180000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000600000000000088cc88000000060000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000809908000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000060000000000000000000800a08000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000a060000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000
00000000000000000006000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000600000000000000000000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000600600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006000000000000000000

__sfx__
00010000180501a050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000d0501a0501d05010050100500f0501a0501c0501d0501f0500c0500c0500c0501d0501f0501d05024050230501605017050150501c0501c0501d0501a0501c0501c0501c0501a050240501805018050
001000001205000000000001205000000000000000012050000000000000000120500000000000000001205000000000000000012050000000000000000120500000000000000001205000000000000000012050
__music__
03 01424344
03 01024344
03 01424344
03 01024344
03 01424344

