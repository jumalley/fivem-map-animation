# 🗺️ Pause Menu Animation for FiveM

This FiveM Lua script plays a tourist map animation when the player opens the pause menu, enhancing immersion with a prop and animation. The animation and prop are automatically cleaned up when the menu is closed.

## 🎬 Features

- Plays a **tourist map animation** (`amb@world_human_tourist_map@male@idle_b`) when the pause menu is active.
- Attaches a **map prop** (`p_tourist_map_01_s`) to the player.
- Automatically stops the animation and removes props when the pause menu is closed.
- Ensures no animation plays inside vehicles.

## 🧠 How It Works

- A background thread checks every 500ms if the pause menu is open.
- When detected, the player is animated holding a tourist map.
- If the player closes the menu, all props and animations are cleared.

## 🛠️ Installation

1. Drop the script in your FiveM resource folder.
2. Ensure it's started in your `server.cfg`:
   ```cfg
   start your-script-name
   ```

3. Make sure the map prop (`p_tourist_map_01_s`) is available in your game build.

## 🧩 Example Usage

No interaction is needed from the player — just open the pause menu and enjoy the immersive idle animation!

## 🧼 Cleanup

All props and animations are safely removed if:
- The menu is closed.
- The player enters a vehicle.

## 📂 File Structure

```
/pausemapanim
  ├── fxmanifest.lua
  └── client.lua   ← Your script file goes here
```

## 📄 License

MIT — free to use, modify, and share.
