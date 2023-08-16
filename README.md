# STM32 Accelerometer Game Project

Welcome to the STM32 Accelerometer Game Project! This repository introduces an exciting new game that takes advantage of the lights and accelerometer features on the STM32 board.

## Quick Overview

Embark on a thrilling adventure with our new accelerometer-based game. You'll have the opportunity to control the lights on the STM32 board using the accelerometer's X and Y values via the I2C interface.

## How It Works

- **Gameplay**: Utilize the command `xxTilt delay target game_time` (replace `xx` with your initials) to initiate the game. The lights will turn on based on the X and Y accelerometer values. Your goal is to keep the target light on for the specified game time.
- **Winning**: If you successfully maintain the target light for the required game time, you win! In celebration, the board will flash all lights twice, just like in the previous assignment.
- **Losing**: Should you fail to illuminate the lights within the designated game time, you lose, and only the single target light will be turned on.

## Example

For instance, consider the command: ptGame 500 5 30

This configuration would run the game, aiming to keep light 5 on for 500ms to achieve victory. The game will run for 30 seconds, and if you don't manage to achieve the goal within that time, it will end in a loss.

## Note: This project is not completed. 



