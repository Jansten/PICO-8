# Paddle

## Overview
- A simple paddle-style game
- Based on the tutorial from the first PICO-8 fanzine

## Versions
- v2, 2018-05-02, considered complete/final

## Goals
- Impliment base game - DONE
- Add title screen - DONE
- Add Game Over screen - PARTIAL, missing music

## Lessons Learned
- The easiest way to create a title screen is to use the game's built-in update function
- You can leverage that function to draw and animate your menus by using multiple "states" in your game
- Because the Game Over screen originally sat outside the update function, the outro music didn't fully play

## TODO
- Move the Game Over screen to another mode (Mode 2) - DONE
- Ensure Game Over music works in Game Over mode  - PARTIAL

## Unfinished
- Game Over screen music never really worked.  The first note would drone on forever.  I suspect this could be fixed, but I'm not fluent enough in PICO-8 to resolve.  Any suggestions are very welcome!