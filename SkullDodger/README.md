# Skull Dodger

## Version
- v0.1 - 2018-05-06 - Basic functionality

## Overview
- An original game, where you have to dodge skulls flying at you.  If they hit you, it's game over!

## Features
- Random waves continue to spawn until you get hit (game over)
- Score increases by one point every second you stay alive
- A screen-clearing bomb item
- High score is tracked across your current session (not between sessions)

## TODO
- Skulls should originate from all sides of the screen, not just from the top
- Create sound effects
- Possibly create music
- Create player character sprite
- Create some sort of sprite map for the play field
- Change variable names for collided() to make them more generic, as this function is being reused
- Potential: Picking up a bomb should add 10 points to the score

## Bugs
- All sprite collision areas aren't the exact size of the sprite.
- Enemy sprites and bomb sprite occasionally stack on top of other sprites