# Space Invaders

> Course: Software Development Practices (CSE2024) · 2026-2 · Section 24592

This IC-PBL course project extends and improves the Java [Space Invaders](https://en.wikipedia.org/wiki/Space_Invaders) clone from [RobertoIA/Invaders](https://github.com/RobertoIA/Invaders). Students apply software engineering practices through requirements engineering, team development, code review, and pull-request-based integration into a shared codebase.

## Team Registration and Project Requirements

Register your team by adding one row to the table below and submitting the change through a pull request.

- In the **Name** column, link to your team's fork of this repository.
- In the **Members** column, link each team member to their GitHub profile.
- In the **Requirements** column, link to your team's document in the `teams/` directory, such as `teams/Instructors.md`.
- Name the team document `teams/<team_name>.md`. Include the team introduction and member roles, the overall requirements assigned to the team, at least five detailed requirements, and up to three dependencies on other teams.

| No. | Name | Members | Requirements |
| ---: | --- | --- | --- |
| 0 | [Instructors](teams/Instructors.md) | [Scott Uk-Jin Lee](https://github.com/scottukjinlee/scottukjinlee), [Seungho Kim](https://github.com/oh-gnues/oh-gnues), [Elkarmy Salma](https://github.com/salma5-cpu), [Eric Zhang](https://github.com/Eric-Zhang37) | [Course guidance](teams/Instructors.md#responsibilities) |
| 1 | [Chinese can fly](https://github.com/wrxtzk/Invaders-SDP-24592) | [진혜청 (Leader)](https://github.com/clover0409), [위준걸](https://github.com/arjen12138), [담조곤](https://github.com/wrxtzk), [손첸디](https://github.com/sunchendi), [하함준](https://github.com/Godovo666), [허린호](https://github.com/woshi777), [양천시](https://github.com/MiooYoung) | [Records & Achievements System](teams/Chinese_can_fly.md#2-team-requirements) |


## Screenshots

| Title Screen | Game Screen | Score Screen |
| :---: | :---: | :---: |
| ![Space Invaders title screen](https://user-images.githubusercontent.com/69495129/136980139-7ad6adab-3f11-4711-b0a6-341080aa3361.png) | ![Space Invaders game screen](https://user-images.githubusercontent.com/69495129/136980236-c5d9ef85-f09a-47a7-b9d9-948f7b624002.png) | ![Space Invaders score screen](https://user-images.githubusercontent.com/69495129/136980681-93dcadaf-08cb-48d8-90c9-68c651a115c9.png) |

## Development

- Recommended IDE: IntelliJ IDEA
- Runtime requirement inherited from the upstream project: Java 7 or later
- Before implementing a feature, build and run the baseline game and analyze the relevant source code.

To run the baseline in IntelliJ IDEA, mark `src` as **Sources Root** and `res` as **Resources Root**, then run `engine.Core`. The resource directory must be on the runtime classpath: the game loads `graphics`, `scores`, and `font.ttf` from its root. Installing the font in your operating system does not make it available to the game.

## Attribution and Licensing

This course project is based on [RobertoIA/Invaders](https://github.com/RobertoIA/Invaders). The upstream repository does not currently declare an open-source license. This repository therefore does not assert a new open-source license over the upstream code or third-party assets. Any permission or licensing terms confirmed by the relevant rights holders should be documented here before redistribution beyond the permissions provided through GitHub.

The bundled `res/font.ttf` is **Space Invaders** by [kylemaoin](https://fontstruct.com/fontstructions/show/282751/space_invaders_9) (© 2010), shared under [Creative Commons Attribution-ShareAlike 3.0](https://creativecommons.org/licenses/by-sa/3.0/). It came from the [official FontStruct download](https://fontstruct.com/fontstructions/download/282751); its font data is unchanged, and its filename was changed from `space-invaders.ttf` to `font.ttf` to match the game's resource lookup. The accompanying [license](res/font-license/license.txt) and [readme](res/font-license/readme.txt) are included as required by that download. This license applies to the font, not to the upstream game code or other assets. Verify those assets' licenses separately before redistributing them.
