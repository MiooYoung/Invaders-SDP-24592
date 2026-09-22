# <Team Name>

## Team Introduction

Our team develops the **<Sound Effects>** of Space Invaders SDP.

Team repository: [nnnrc/Invaders-SDP-24592](https://github.com/nnnrc/Invaders-SDP-24592)

## Members

| Name | Role | GitHub |
| --- | --- | --- |
| Chanyoung Lee | Team Leader | [leechanyoung0710](https://github.com/leechanyoung0710) |
| Heyonmin Jeon | Developer | [oihsie](https://github.com/oihsie) |
| Sihoon Kim | Collaborator | [nnnrc](https://github.com/nnnrc) |
| Jaesung Yoo | Developer | [jaesung-rtp](https://github.com/jaesung-rtp) |
| Jiseok Byun | Developer | [jisuk24](https://github.com/jisuk24) |
| Taesu Park | Developer | [ptsoo0602-dev](https://github.com/ptsoo0602-dev) |
| EunJi Park | Developer | [ej040320](https://github.com/ej040320) |
| Lana MANGIN | Developer | [LanaMANGIN](https://github.com/LanaMANGIN) |
| Chloé DESCAMPS | Developer | [DescampsC](https://github.com/DescampsC) |

## Team Requirement

<!-- TODO: 팀에 배정된 전체 요구사항 -->
We are responsible for the **<Sound Effects>** of the Space Invaders game.
<!-- 이 모듈이 게임에서 어떤 역할을 하는지 1~2문장 -->

## Detailed Requirements

<!-- TODO: 최소 5개 -->
1. **Core Audio Manager** - This is the most essential piece of work: building the backbone so that other teams can play a sound with a single line of code, like AudioManager.play("shoot");, without having to know anything about the underlying sound setup. <description>
2. **Dynamic BGM** – As the player's health drops, the BGM speeds up or gains a tension layer, so danger can be felt through sound alone without checking the health bar. The AudioManager listens for health-change events and crossfades between tracks.<description>
3. **Audio Control System** – Implements a global mute that lets the player turn off all sound at any time during the game, along with separate volume controls for background music and sound effects.<description>
4. **<Requirement 4>** – <description>
5. **<Requirement 5>** – <description>

## Dependencies

<!-- TODO: 다른 팀에 대한 의존성, 최대 3개 -->
- **<Other Team / Module>** – <why we depend on it>
- **<Other Team / Module>** – <why we depend on it>
- **<Other Team / Module>** – <why we depend on it>
