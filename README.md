# 自用 Rime 输入方案（基于雾凇拼音）

[![License: GPL 3.0](https://img.shields.io/badge/License-GPL--3.0--only-34ad9b)](https://www.gnu.org/licenses/gpl-3.0.txt)

<br>

[Rime Input Method Engine / 中州韵输入法引擎](https://rime.im/) 是一个跨平台的输入法算法框架。

基于这一框架，Rime 开发者与其他开源社区的参与者在多个平台上创造了不同的输入法前端实现。

这里是 Rime 的一份配置仓库，用户需要下载 [各平台对应的前端](https://github.com/rime/librime/#frontends)，并将此配置应用到配置目录。

本方案基于 [雾凇拼音](https://github.com/iDvel/rime-ice) 进行了部分定制修改

<br>

## 基本介绍

本方案相比雾凇拼音进行了如下修改：

1. 只保留小鹤双拼方案，删除其他全拼、双拼方案

2. 增加 ex_vim_mode。相比 Rime 自带的 vim_mode，从 vim 的 Normal Mode 切换为 Insert Mode 时，会自动恢复为上次使用的输入模式。这样在使用中文输入，切换到 Normal Mode 再切回 Insert Mode 时，Rime 会自动切回中文模式，无须手动切换。具体实现见 [ex_vim_mode.lua](https://github.com/dynamicers/rime-conf/blob/main/lua/ex_vim_mode.lua)
