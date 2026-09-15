# Chinese can fly

> CSE2024 Software Development Practices · IC-PBL Project · Section 24592 (Afternoon) · 2026 Semester 2
>
> Selected requirement: **3. Records & Achievements System**
>
> Team leader: **진혜청 ([clover0409](https://github.com/clover0409))**. Requirement 3 is selected by our team; availability remains subject to the course’s first-come, first-served allocation.

## 1. Team Introduction

Our seven-member team will develop the Records & Achievements System for the Space Invaders project. Our goal is to help players review their performance, track progress across games, and earn meaningful achievements. We aim to deliver a reliable, understandable system that integrates with the other teams’ features without changing gameplay rules unnecessarily.

We will first build and run the original Java project, inspect its startup and gameplay flow, and then agree on integration points before implementation. Every member will contribute code, documentation, tests, or reviews through traceable commits and pull requests.

### Members and Responsibilities

| Member | GitHub | Role | Main deliverable |
| --- | --- | --- | --- |
| 진혜청 | [clover0409](https://github.com/clover0409) | Team leader and integration coordinator | Coordinate requirements, cross-team communication, PR reviews, and final integration. |
| 위준걸 | [arjen12138](https://github.com/arjen12138) | Records data model and game-result capture | Define run records, capture completed-run data, and prevent duplicate records (R1). |
| 담조곤 | [wrxtzk](https://github.com/wrxtzk) | Local persistence | Implement saving, loading, validation, and recovery from invalid save data (R4). |
| 손첸디 | [sunchendi](https://github.com/sunchendi) | Personal bests and rankings | Implement high-score comparisons, deterministic sorting, and the local top-ten list (R2–R3). |
| 하함준 | [Godovo666](https://github.com/Godovo666) | Achievement logic | Implement unlock conditions, progress evaluation, and duplicate-unlock prevention (R5). |
| 허린호 | [woshi777](https://github.com/woshi777) | Records and achievements UI | Build the records screen, achievement states, and queued unlock notifications (R6–R7). |
| 양천시 | [MiooYoung](https://github.com/MiooYoung) | Integration testing and gameplay event adapter | Connect gameplay events, verify end-to-end flows, and maintain regression checks and acceptance evidence. |

**Team leader:** 진혜청. The leader coordinates the team and represents it in leaders’ meetings and cross-team discussions.

Work is divided by feature ownership and integration needs. Each feature owner writes tests for their own module; 양천시 coordinates integration and regression testing, and 진혜청 coordinates reviews and merges. All seven members contribute to implementation, documentation, and peer review.

## 2. Team Requirements

Our team is responsible for recording completed single-player runs, maintaining local personal records, evaluating achievements, and presenting records and achievement progress to the player.

### Planned Scope

- Capture each completed run’s score, enemies defeated, survival duration, and completion time.
- Maintain a local high score and a top-ten completed-run list.
- Persist records and unlocked achievements between application launches.
- Provide a records and achievements screen, a game-over summary, and unlock notifications.
- Integrate with gameplay and interface owners through agreed interfaces.

### Scope Boundaries

- The initial version supports one local player profile and single-player runs.
- Online accounts, online leaderboards, cloud synchronization, and anti-cheat are outside the initial scope.
- Two-player records require a separately agreed scoring and ownership model and are not promised in the initial version.
- Achievements do not award currency or items in the initial version. Such rewards require a separate agreement with the relevant teams.

These are proposed implementation boundaries, not additional course rules. Exact class names, storage format, and interface signatures will be decided after reviewing the existing repository.

## 3. Detailed Requirements

### R1. Capture Completed Game Records

When a run reaches the normal game-over or completion flow, the system shall create exactly one record containing:

- A unique run identifier.
- Final score.
- Number of enemies defeated during the run.
- Active gameplay duration in seconds, excluding paused time.
- Completion date and time.

**Acceptance criteria:** A completed test run produces one record with values matching the gameplay system. Processing the same run identifier again does not create a duplicate. Closing the application before the completion flow does not create a completed-run record.

### R2. Track Personal Bests

The system shall maintain the highest score, highest enemies-defeated count in one run, and longest survival duration among completed runs.

**Acceptance criteria:** Records update only when a new value is strictly higher. Equal values do not count as a new best. With no saved runs, the interface displays an explicit empty state instead of presenting a fictional game record.

### R3. Display a Local Top-Ten Ranking

The system shall rank completed runs by score in descending order and show up to ten entries. Equal scores shall be ordered by earlier completion time, with run identifier as a final deterministic tie-breaker.

**Acceptance criteria:** Given more than ten test records, the screen shows exactly the ten highest-ranked entries with rank, score, enemies defeated, survival duration, and completion time. Fewer than ten records are displayed without fabricated entries.

### R4. Persist and Restore Progress

Completed-run records and unlocked achievements shall be saved locally when a run finishes and when a new achievement is unlocked. The system shall load valid saved data on the next application launch.

**Acceptance criteria:** Closing and reopening the application restores the same records and unlocked achievements. Missing save data starts a new profile. Invalid data does not crash the game: the original invalid file is retained separately, and the player receives a clear notice before a new empty state is used. A write failure is reported and does not silently overwrite the previous valid save.

### R5. Implement an Achievement Catalogue

The initial catalogue shall contain at least the following five achievements:

| ID | Achievement | Unlock condition |
| --- | --- | --- |
| A01 | First Finish | Complete one run through the normal game-over or completion flow. |
| A02 | First Victory | Defeat the first enemy. |
| A03 | Invader Hunter | Defeat 20 enemies within one run. |
| A04 | Survivor | Accumulate 60 seconds of active play within one run, excluding pauses. |
| A05 | Personal Best | Complete a run with a score strictly above the best score recorded before that run; at least one earlier completed run is required. |

**Acceptance criteria:** Each achievement unlocks when its condition is first met and remains unlocked across launches. A02–A04 can unlock during play; A01 and A05 are evaluated at run completion. Each achievement unlocks only once per local profile. Tests cover just-below, exact-threshold, and repeated-event cases. Numeric thresholds are proposed and will be checked against the original game’s pacing before the team freezes requirements.

### R6. Show Achievement Status and Notifications

The achievement screen shall show each achievement’s name, description, locked or unlocked state, and unlock time when available. During gameplay, each newly unlocked achievement shall generate a non-blocking notification. Simultaneous unlocks shall be queued so that messages remain readable.

**Acceptance criteria:** A locked achievement becomes visibly unlocked after its condition is met. Repeated qualifying events do not produce duplicate unlock notifications. Notifications do not pause the game or take control away from the player. The game-over summary lists the run’s results and achievements unlocked during that run.

### R7. Provide a Records and Achievements Screen

The player shall be able to open the records and achievements screen from the main menu and return to the menu. The screen shall include personal bests, the top-ten list, and the achievement catalogue.

**Acceptance criteria:** The screen is reachable through the agreed menu entry, correctly renders both empty and populated states, and allows the player to return without losing stored data. Data shown on the screen matches the saved records and achievement state.

## 4. Dependencies on Other Teams

The following three integration dependencies must be agreed with the responsible teams. Specific team names are not yet available.

| Dependency | Requirement owner | Needed collaboration | Integration check |
| --- | --- | --- | --- |
| D1. Main-menu entry and navigation | Requirement 7: Main Menu | Provide a menu entry for our records and achievements screen and a return-navigation hook. | Open our screen from the main menu and return successfully. |
| D2. In-game notification presentation | Requirement 8: Gameplay HUD | Agree on a notification API or display region so achievement messages do not overlap essential HUD information or block input. | Trigger multiple unlocks during play and verify readable, queued notifications with normal controls. |
| D3. Enemy-defeat event contract | Requirement 9: Player & Enemy Ship Variety | Ensure that all introduced enemy variants report defeats consistently and expose the run identifier needed to avoid duplicate counting. | Each defeated enemy contributes exactly one count regardless of ship variant. |

Our team will investigate existing score, pause/resume, run-start, and game-over hooks in the base repository. We will propose adapters where needed and review shared-code changes with the maintainers. Existing hooks are not assumed to exist until source inspection confirms them.

Mocks may support independent development, but these dependencies count as complete only after integration with the relevant teams’ implementations.

## 5. Collaboration and Verification

- Use the team fork as the shared workspace and contribute reviewed changes to the main repository through pull requests.
- Have 진혜청, as the designated team representative, request direct-access permission from TA Seungho Kim. Other members do not submit duplicate requests.
- Write descriptive commit messages and identify the implemented requirement in each PR.
- Include implementation notes and relevant test evidence with changes.
- Participate in cross-team review and the leaders’ meeting during each project session.
- Agree on approval rules, merge order, conflict handling, and merge method with the other teams; do not assume the lecture’s example of two approvals is already a fixed rule.
- Verify persistence, duplicate-event handling, ranking ties, achievement thresholds, and menu/HUD integration before requesting final merge.

## Reference

- Course slides: `L3_IC-PBL Project_24592.pdf`, especially slides 3–9.
- Main repository for section 24592: https://github.com/oh-gnues/Invaders-SDP-24592

This document describes planned requirements. The listed features and acceptance criteria are not claims of completed implementation.
