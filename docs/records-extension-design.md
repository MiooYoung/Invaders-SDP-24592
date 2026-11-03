# Records & Achievements 扩展设计说明 / Extension Design Notes

> **状态 / Status：团队已确认 A、B、C，作为需求 3.8–3.10 / The team confirmed A, B and C as requirements 3.8–3.10.**
> 起草 / Drafted：2026-11-03（Asia/Seoul），양천시 / MiooYoung；同日由团队确认 / confirmed by the team the same day.
> 需求正文只在 [`teams/Chinese_can_fly.md`](../teams/Chinese_can_fly.md)。本文只记录设计考虑与验收细节，二者不一致时以需求文件为准。
> Requirement text lives only in [`teams/Chinese_can_fly.md`](../teams/Chinese_can_fly.md). This document records design considerations and acceptance details; the requirements file prevails if they differ.

## 背景 / Background

- 组内转述：助教表示游戏开发方向可以自由选择。原始消息与适用范围尚未核实，需向助教确认新增需求是否需要重新登记。
  A teammate relayed that the TA allows a free choice of game features. The original message and its scope are unverified; we should ask whether new requirements must be re-registered.
- 3.1–3.7 已通过内部 PR #5–#12 合入团队 `main`（当前 `003a526`）。2026-10-15 记录了 104 项 records 检查与 35 项整局集成检查通过；这是历史证据，2026-11-03 未重新运行。
  Requirements 3.1–3.7 were merged into team `main` through internal PRs #5–#12. The 2026-10-15 checks are historical evidence and were not re-run on 2026-11-03.
- 其他组已负责主菜单、HUD、关卡与无尽模式、道具、货币、音频、飞船与 Boss。下面的提案都建立在**我们已有的记录数据**上，尽量不进入其他组的模块。
  Other teams own the menu, HUD, levels/Infinite Mode, items, currency, audio, and ships/bosses. These proposals build on data our records system already owns.

## 优先级 / Priority

1. **P0：先在当前团队 `main` 上重新核验 3.1–3.7**（Jira 现有工作项）。扩展不能挤掉核验。
   P0: re-verify 3.1–3.7 on current team `main` first (existing Jira items).
2. **P1：幽灵对手**，作为展示主打。/ P1: Ghost Run as the headline feature.
3. **P2：风格成就**与**赛后战报**，可多人并行的小块。/ P2: style achievements and the run report, split into small parallel pieces.

---

## A. 幽灵对手 / Ghost Run（推荐 / Recommended）

**玩家体验**：开局后出现一架半透明飞船，重演你个人最佳那一局的走位；HUD 实时显示与当时同一活跃时刻的分数差，例如 `+120` / `-80`。这一局成绩更好时，幽灵替换为这一局。

**Player experience**: A translucent ship replays the movement of your personal-best run. The HUD shows the score difference against that run at the same active time, such as `+120` or `-80`. A better run replaces the ghost.

**需求 / Requirement**：3.8，见 [`teams/Chinese_can_fly.md`](../teams/Chinese_can_fly.md#3-detailed-requirements)。

**验收细节 / Acceptance details**

- [ ] 每 100 ms 活跃时间采样一次（倒计时、结束动画不采样），与 `RunSession` 的活跃计时口径一致。
      Sample every 100 ms of active time; exclude countdown and ending animation, matching `RunSession`.
- [ ] Campaign 与 Infinite Mode 分别保存一条幽灵；只有已完成且刷新该模式最高分的局才替换。放弃的局不替换。
      One ghost per mode; only a completed run with a new mode high score replaces it. Abandoned runs never do.
- [ ] 幽灵不参与碰撞、不发射、不影响得分、道具或成就。
      The ghost never collides, shoots, or affects score, items, or achievements.
- [ ] 幽灵文件单独存放，沿用 `ProfileStore` 的“临时文件 → 回读校验 → 替换”写法；损坏或缺失时不显示幽灵、记录日志，不影响记录档案。
      Stored separately with the same temp-file/validate/replace approach as `ProfileStore`. Corruption disables the ghost only.
- [ ] 幽灵采样结束后（对方那局已结束）显示终点标记，分数差按最终分数比较。
      After the ghost's run ends, show an end marker and compare against its final score.

**实现落点 / Touchpoints**：`GameScreen` / `InfiniteGameScreen` 的 `update()` 采样；`RunSession` 活跃时间；`RecordsService.completeRun()` 判断是否刷新最高分；`DrawManager` 新增幽灵与分数差绘制；新类建议 `records.GhostTrack`、`records.GhostRecorder`、`records.GhostStore`。

**跨组 / Cross-team**：分数差的 HUD 位置需与 HUD 组（friends）确认，沿用现有 DEP-2；如需设置开关，与 Settings 负责人确认。

**数据量估算 / Size**：每秒 10 个样本，Campaign 全程约几分钟，约数千行文本，可接受。

---

## B. 风格成就 / Style Achievements

在正式五项之外新增五项“玩法风格”成就，并支持隐藏成就（未解锁显示 `???`）。需求 3.9 选定下表前五项；后两项作为备选，未纳入需求。

Five style achievements are added beyond the original five, with hidden ones shown as `???` until unlocked. Requirement 3.9 selects the first five rows; the last two remain alternates outside the requirement.

| 成就 / Achievement | 条件 / Condition | 需要的事实事件 / Needed gameplay facts |
| --- | --- | --- |
| Sharpshooter | 一个已通过的 Campaign 关卡内射击 ≥20 次且命中率 ≥80% / ≥80% accuracy in a cleared stage with ≥20 shots | 射击、未命中出界 / shot fired, bullet missed |
| Untouchable | 无损失生命通过一个 Campaign 关卡 / Clear a stage without losing a life | 玩家受击、关卡通过 / player hit, stage cleared |
| UFO Hunter | 击落神秘飞船 / Defeat the special ship | 击败事件带是否为神秘飞船 / special-ship flag on defeat |
| Long Haul | Infinite Mode 存活 120 活跃秒 / Survive 120 active seconds in Infinite Mode | 已有活跃计时 / existing active time |
| Stage Pioneer（隐藏 / hidden） | 首次通过 Campaign 关卡（Octopus 提出过）/ First Campaign stage clear (requested by Octopus) | 关卡通过 / stage cleared |
| *备选 / Alternate*：Chain Reaction | 连续 10 次命中且中间没有打空 / 10 consecutive hits without a miss | 射击结果 / shot outcome |
| *备选 / Alternate*：Overkill | Orbital Annihilator 一次光束击败 ≥5 个敌人 / ≥5 defeats with one Annihilator beam | 击败来源 / defeat source |

**设计约束 / Constraints**

- 事件只传递游戏事实，成就判断留在 records 模块，沿用 `GameplayEventPublisher` 的约定。新增事件需和事件来源方（关卡、道具、敌人组）确认字段。
  Events carry gameplay facts only; achievement logic stays in records, following `GameplayEventPublisher`.
- `DrawManager.drawAchievementList()` 当前把所有成就竖排在一页，超过五项需要翻页或滚动。
  The achievements page lists all entries in one column and needs paging beyond five.
- **档案兼容风险**：`ProfileStore` 读到未知成就 ID 时会拒绝该档案。新版本写出的档案被旧版本读取时会进入损坏保护流程。新增成就前需决定：未知 ID 保留而不报错，或升级档案版本并写迁移。
  Compatibility risk: `ProfileStore` rejects unknown achievement IDs, so an older build would treat a newer profile as invalid. Decide on tolerant loading or a versioned migration before adding achievements.

---

## C. 赛后战报 / Run Report

结算页和记录页增加本局分关数据：每关用时、命中率、击败数柱状图，以及与个人最佳的对比箭头。

Add per-stage time, accuracy, a defeats-per-stage bar chart, and comparison arrows against personal bests to the results and records screens.

- 需要在 `RunRecord` 中加入分关数据，属于档案格式变更，同样需要版本迁移（见 B 的兼容风险）。
  Requires per-stage data in `RunRecord`, a profile format change with the same migration concern.
- 只读展示，不改变已有排名与个人最佳规则（3.2、3.3）。
  Display only; existing ranking and personal-best rules are unchanged.

---

## 不推荐 / Not Recommended：每日挑战 / Daily Challenge

同一天使用固定随机种子，让所有人打同一局。需要把敌人射击、冷却和道具掉落的随机数改为可注入种子，涉及关卡、敌人和道具组的代码，冲突风险高，暂不推荐。

Seeded daily runs would require injectable randomness in enemy shooting, cooldowns, and item drops owned by other teams.

---

## 分工与节奏 / Owners and Schedule

团队已确认以下分工；日期是规划目标，不是课程截止。课件明确的展示日期是 2026-12-08（Week 15）。Jira 工作项是进度的准确来源。

The team confirmed these owners. Dates are planning targets; the only course-given date is the Week 15 presentation on 2026-12-08. Jira is the source of truth for progress.

| 工作 / Work | 负责人 / Owner | 目标 / Target |
| --- | --- | --- |
| 向助教确认新增需求的登记方式、协调跨组事件 / Confirm with the TA how new requirements are registered; coordinate cross-team events | 진혜청 / clover0409 | 2026-11-10 |
| 幽灵采样接入两种模式 / Ghost sampling in both modes | 양천시 / MiooYoung | 2026-11-20 |
| 幽灵存储与损坏保护 / Ghost storage and corruption handling | 담조곤 / wrxtzk | 2026-11-20 |
| 幽灵绘制与 HUD 分数差 / Ghost rendering and HUD delta | 허린호 / woshi777 | 2026-11-24 |
| 风格成就规则与档案兼容 / Style achievement rules and profile compatibility | 하함준 / Godovo666 | 2026-11-24 |
| 新事实事件与跨组确认 / New gameplay events and cross-team agreement | 위준걸 / arjen12138 | 2026-11-20 |
| 成就翻页、隐藏成就显示与赛后战报 / Achievement paging, hidden display, run report | 손첸디 / sunchendi | 2026-11-27 |

每项仍按现有规则：内部 PR 指向 `clover0409/Invaders-SDP-24592:main`，由非作者审查，附测试证据。

Each item follows the existing workflow: internal PRs target `clover0409/Invaders-SDP-24592:main`, are reviewed by a non-author, and include test evidence.
