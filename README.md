# 自定义 Rime 输入方案（基于雾凇拼音）

[![License: GPL 3.0](https://img.shields.io/badge/License-GPL--3.0--only-34ad9b)](https://www.gnu.org/licenses/gpl-3.0.txt)

<br>

[README in English](https://github.com/dynamicers/rime-conf/blob/main/README_EN.md)

<br>

[Rime Input Method Engine / 中州韵输入法引擎](https://rime.im/) 是一个跨平台的输入法算法框架。

基于这一框架，Rime 开发者与其他开源社区的参与者在多个平台上创造了不同的输入法前端实现。

这里是 Rime 的一份配置仓库，用户需要下载 [各平台对应的前端](https://github.com/rime/librime/#frontends)，并将此配置应用到配置目录。

本方案基于 [雾凇拼音](https://github.com/iDvel/rime-ice) 进行了部分定制修改

<br>

## 基本介绍

本仓库基于 [雾凇拼音](https://github.com/iDvel/rime-ice) 具体进行了如下修改：

1. 只保留小鹤双拼方案，删除其他全拼、双拼方案

2. 增加 ex_vim_mode。相比 Rime 自带的 vim_mode，从 vim 的 Normal Mode 切换为 Insert Mode 时，会自动恢复为上次使用的输入模式。这样在使用中文输入，切换到 Normal Mode 再切回 Insert Mode 时，Rime 会自动切回中文模式，无须手动切换。具体实现见 [ex_vim_mode.lua](https://github.com/dynamicers/rime-conf/blob/main/lua/ex_vim_mode.lua)

3. 增加 key_log_mode。打开后可以将 Rime 收到的按键按时间戳顺序记录到日志中，debug 场景使用。具体实现见 [key_log_mode.lua](https://github.com/dynamicers/rime-conf/blob/main/lua/key_log_mode.lua)

---

## 使用指南 (以 macOS 为例)

### 1. 下载与安装 Rime 前端

请根据您的操作系统下载并安装对应的 Rime 输入法前端：

* **macOS**: [鼠须管 (Squirrel)](https://github.com/rime/squirrel/releases)
>>  * **Linux**: [ibus-rime](https://github.com/rime/ibus-rime) 或 [fcitx5-rime](https://github.com/fcitx/fcitx5-rime)
>> * **Windows**: [小狼毫 (Weasel)](https://github.com/rime/weasel/releases)

### 2. 同步配置目录

1. 备份默认配置

```bash
mv ~/Library/Rime ~/Library/Rime.bak
```

2. 将本仓库的所有文件克隆或解压到该目录下：

```bash
git clone https://github.com/dynamicers/rime-conf.git ~/Library/
ln -s rime-conf Rime
```

### 3. 重新部署与系统设置

1. 在操作系统的键盘设置中，**添加并选择 Rime 输入法**。

```
系统设置 -> 键盘 -> 输入法 -> 添加中文 -> 鼠须管
```

2. 运行 Rime 的 **重新部署 (Deploy)** 功能。
```
系统菜单栏 -> 输入法图标 -> 鼠须管 -> 部署
```

---

## 特殊模式配置

本方案集成的 `ex_vim_mode` 和 `key_log_mode` 默认关闭，需要通过配置文件对指定软件（bundle ID）进行定向激活。

### 1. ex_vim_mode (增强型 Vim 模式)

此模式针对特定编辑器或终端自动同步输入状态，提供类似 [im-select](https://github.com/daipeihust/im-select) 的功能

#### 开启步骤

1. 打开 `squirrel.yaml`：

```bash
vim ~/Library/Rime/squirrel.yaml
```

2. 将需要启用该模式的应用程序进程名加入白名单( 以 VSCode 和 Zed 为例)：

```yaml
app_options:
  com.microsoft.VSCode:
    ex_vim_mode: true
  dev.zed.Zed:
    ex_vim_mode: true
```

3. 重新部署 Rime 即可生效。

```
系统菜单栏 -> 输入法图标 -> 鼠须管 -> 部署
```

### 2. key_log_mode (按键日志模式)

此模式用于调试特定软件下的输入异常，记录按键时间戳。

#### 开启步骤

1. 打开 `squirrel.yaml`：

```bash
vim ~/Library/Rime/squirrel.yaml
```

2. 将需要启用该模式的应用程序进程名加入白名单( 以 VSCode 和 Zed 为例)：

```yaml
app_options:
  com.microsoft.VSCode:
    # ex_vim_mode: true
    key_log_mode: true
  dev.zed.Zed:
    # ex_vim_mode: true
    key_log_mode: true
```

3. 重新部署 Rime 即可生效。在指定软件中输入时，按键数据会自动写入预订定路径，可以通过 `tail` 命令来跟踪日志输出：


```
系统菜单栏 -> 输入法图标 -> 鼠须管 -> 部署
```

```bash
# 查看按键日志
tail -f /tmp/rime_key.log
```

---
