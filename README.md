# Fly and Teleport System

Enhance your GTA V experience with flight and teleportation features.

## Features

- Flight mode with adjustable speed
- Teleportation to other players
- Adjustable run speed and jump height
- Climbing mode for vertical movement

## Requirements

- FiveM server
- ESX Legacy framework
- MySQL database

## Installation

1. Download the script
2. Place the script in your FiveM resources folder
3. Add `start kosiny_hub` to your server.cfg
4. Import the database.sql file into your MySQL database

## Usage

### Commands

- `/kosinyhub fly` - Toggle flight mode
- `/kosinyhub climb` - Toggle climbing mode
- `/kosinyhub color <color>` - Change hub color (blue, red, yellow, green)
- `/kosinyhub speed <value>` - Set run speed
- `/kosinyhub jump <value>` - Set jump height
- `/kosinyhub teleport <player_id>` - Teleport to a player

### Permissions

- `kosiny_hub.fly` - Allows players to use flight mode
- `kosiny_hub.climb` - Allows players to use climbing mode
- `kosiny_hub.color` - Allows players to change hub color
- `kosiny_hub.speed` - Allows players to change run speed
- `kosiny_hub.jump` - Allows players to change jump height
- `kosiny_hub.teleport` - Allows players to teleport to other players

## Configuration

Edit the `config.lua` file to adjust settings such as default hub color, flight speed, jump height, run speed, and climb speed.

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=fly-and-teleport-system&utm_content=bottom) — describe it in one sentence and get the full source code.