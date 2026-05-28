# NBA Deathmatch

> **NBA 4D Deathmatch** is a high-fidelity cinematic fighting game built in Godot 4. Command iconic Hall of Fame legends from 1993 to 2026 in stylized, claymation-inspired arenas. Utilize advanced GDExtension multi-dimensional math modules to execute jaw-dropping special moves across 4D spatial planes. Features modular actor states and hard-hitting dynamic cameras.

---

## 🛠️ Project Development Roadmap

### 🟥 Core Architecture (Subsystems)
- [x] Repository Architecture Layout
- [x] Base 4D Fighter Class (`base_fighter_4d.gd`)
- [x] Dynamic Camera Director Script (`cinematic_director.gd`)
- [ ] 4D Input Buffering & State Machine Link
- [ ] Match Coordinator & Round Manager Logic
- [ ] Post-Process Cinematic Environment Tuning (`.tres`)

### 🏀 Roster Initialization Matrix (Actors)

#### The 1990s Era (Claymation Renders)
- [ ] **Michael Jordan ('93)** - *Status: Structural Blueprint Configured*
- [ ] **Shaquille O'Neal ('00)** - *Status: Pending Model Import*
- [ ] **Hakeem Olajuwon ('94)** - *Status: Backlog*

#### The 2000s Era (Claymation Renders)
- [ ] **Kobe Bryant ('08)** - *Status: Pending Model Import*
- [ ] **Allen Iverson ('01)** - *Status: Backlog*
- [ ] **Tim Duncan ('03)** - *Status: Backlog*

#### The 2010s - 2020s Modern Era
- [ ] **LeBron James ('12)** - *Status: Pending Model Import*
- [ ] **Stephen Curry ('16)** - *Status: Backlog*
- [ ] **Nikola Jokić ('23)** - *Status: Backlog*

---

## 🚀 Local Project Setup Environment
To contribute or test locally, pull down the repository and run:

```bash
# Clone the repository
git clone [https://github.com/credkellar-boop/NBA-Death-Match.git](https://github.com/credkellar-boop/NBA-Death-Match.git)

# Navigate into workspace
cd NBA-Death-Match

# Initialize submodules (if utilizing external 4D modules)

res://
├── assets/                 # Shared global assets
│   ├── environments/       # Shared arena skyboxes/lights
│   ├── materials/          # Shared shaders (e.g., wet_clay.gdshader)
│   └── sfx/                # Global audio clips
├── data/                   # Data-driven design
│   ├── rosters/            # .tres files (jordan_93.tres, shaq_96.tres)
│   └── movesets/           # Move data definitions
├── src/                    # Modular source code
│   ├── actors/             # Player base classes
│   │   └── base_fighter_4d/
│   │       ├── base_fighter_4d.gd
│   │       └── base_fighter_4d.tscn
│   ├── systems/            # Logic controllers
│   │   ├── roster_manager.gd
│   │   └── match_coordinator.gd
│   └── ui/                 # HUD and Menus
│       └── input_hud/
└── levels/                 # Git Submodules go here
    └── united_center_4d/   # Submodule repository
        ├── united_center_4d.gd
        ├── scene.tscn
        └── assets/         # Arena-specific geometry/audio

git submodule update --init --recursive
UnitedCenter4D (Node3D)  <- Attaches united_center_4d.gd
├── WorldEnvironment     <- Configured with ACES Cinematic Tonemapping
├── DirectionalLight3D   <- High-intensity arena ceiling spot lighting
├── CourtMesh (MeshInstance3D) <- The actual wooden floor geometry
│   └── StaticBody3D     <- Flat plane physical collision map
├── Jumbotron (Node3D)
│   ├── MeshInstance3D   <- The massive four-sided hanging central screen
│   └── AnimationPlayer  <- Cycles playback channels and warning graphics
├── CrowdSystem (Node3D)
│   ├── MeshInstance3D   <- Multi-layered low-poly claymation crowd models
│   └── FlashCameras     <- Particle emitter simulating crowd phone flashes
└── Audio (Node3D)
    ├── CrowdAmbience (AudioStreamPlayer)
    └── CrowdCheer (AudioStreamPlayer)
