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
- Create and impliment screen-clearing bomb item (sprite has already been created)
- Change variable names for collided() to make them more generic, as this function is being reused

## Bugs
- Player sprite's collision area isn't the exact size of the sprite.
- Bomb does not respect collision rules, so it does not clear the screen