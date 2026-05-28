NBA Deathmatch

[![Build Status](https://github.com/credkellar-boop/NBA-DEATH-MATCH/actions/workflows/main.yml/badge.svg)](https://github.com/credkellar-boop/NBA-Death-Match/actions/workflows/main.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Godot Engine](https://img.shields.io/badge/Godot-4.x-blue.svg)](https://godotengine.org/)

## 🚀 Overview
NBA Deathmatch 4D is a professional-grade fighting game engine built with Godot 4. It leverages a custom 4D collision system and a data-driven architecture to deliver a unique, stylized "claymation" combat experience.

## 📁 Project Structure
The engine is structured by feature domain to ensure modularity and scalability:

```text
res://
├── assets/                 # Shared global assets (textures, sfx, materials)
├── data/                   # Data-driven design (rosters, movesets)
│   ├── rosters/            # jordan_93.tres, shaq_96.tres
│   └── movesets/           # Move data definitions
├── src/                    # Modular source code
│   ├── actors/             # BaseFighter4D classes
│   ├── systems/            # Logic controllers (RosterManager, MatchCoordinator)
│   └── ui/                 # HUD and Menus
├── levels/                 # Git Submodules (Arena assets)
│   └── united_center_4d/
└── shaders/                # wet_clay.gdshader
