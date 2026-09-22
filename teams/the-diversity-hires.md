# The Diversity Hires

## 1. Team Introduction

**Team Name:** The Diversity Hires

**Team Focus:** Visual Effect System

**Vision:**
We aim to bring the Space Invaders remake to life visually — making every explosion, hit, and menu screen feel satisfying, readable, and polished, while keeping our effects lightweight enough not to hurt performance for the rest of the game.

**Team Roles:**

| Role | Member | Responsibility |
|---|---|---|
| Team Leader | Aymeric GERON | Coordinates tasks, tracks progress, communicates with other teams, manages the GitHub board/PRs |
| Particle Effects Lead | Junlin Chon | Builds and tunes explosion particle systems |
| Color & Shader Artist | Helena Ding | Defines color palettes, lighting/flash effects, shader-based visuals |
| Background Artist | ZHUMAKHMETOV MIKHAIL | Designs and implements background art/parallax scrolling |
| UI/Icon Designer | Oluwadamilola Tinubu | Creates new icons and visual assets used across the game |
| Homepage/Layout Designer | Liya Aklil | Designs and implements the homepage/main menu layout |
| QA & Integration Lead | Zhang ZEWEI | Tests effects in-game, checks performance, integrates with other teams' systems |

## 2. Team Requirements

Our team is responsible for the **Visual Effect System** — all non-audio visual feedback in the game, including particle effects, color treatments, background art, UI iconography, and menu/homepage layout. Our goal is to make gameplay feel more dynamic and readable, and to give the game a cohesive visual identity across all screens.

## 3. Detailed Requirements

1. **Explosion Particles** — Implement particle effects for ship/enemy explosions (player death, enemy death, projectile impacts).
2. **Color System** — Establish a consistent color palette and apply color-based feedback (e.g., damage flashes, power-up highlights, background tinting).
3. **Background Effects** — Design and implement dynamic/animated backgrounds (e.g., parallax starfield, scrolling elements).
4. **Icon Set** — Create additional icons needed across the UI (e.g., lives, score, power-ups, pause/settings).
5. **Homepage Layout** — Design and implement the visual layout of the main menu/homepage screen.

## 4. Dependencies on Other Teams

1. **Sound Effects/BGM Team** — Need audio cues synced to our visual effects (e.g., explosion sound timed with particle burst) for combined feedback.
2. **Gameplay HUD Team** — Need event triggers/hooks (e.g., damage taken, score change) so our visual effects can fire at the correct moments.
3. **Player & Enemy Ship Variety Team** — Need finalized ship sprites/states so we can apply visual effects (e.g., explosions, damage flashes) accurately to each ship type.
