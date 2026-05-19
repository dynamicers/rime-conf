# Custom Rime Configuration (Based on rime-ice)

[Rime Input Method Engine](https://rime.im/) is a cross-platform input method algorithmic framework.

Based on this framework, Rime developers and open-source community contributors have created various input method frontends across multiple platforms.

This repository contains a customized Rime configuration. To use it, download the [corresponding frontend for your platform](https://github.com/rime/librime/#frontends) and apply these files to your Rime configuration directory.

This configuration is customized and modified based on [rime-ice (雾凇拼音)](https://github.com/iDvel/rime-ice).

## Key Features

This configuration introduces the following modifications to rime-ice:

1. **Xiaohe Double Pinyin Only**: Retains exclusively the FlyPinyin (小鹤双拼) scheme, removing all other pinyin schemes.

2. **ex_vim_mode**: An enhanced Vim mode. Compared to the built-in `vim_mode` in Rime, `ex_vim_mode` automatically restores your previous input state when switching from Vim's Normal Mode back to Insert Mode. When typing in Chinese, switching to Normal Mode and back to Insert Mode will automatically reactivate the Chinese input state, eliminating the need for manual toggling. See [ex_vim_mode.lua](https://github.com/dynamicers/rime-conf/blob/main/lua/ex_vim_mode.lua) for implementation details.

3. **key_log_mode**: A debugging tool. When enabled, it records the keystrokes received by Rime in chronological order with timestamps. See [key_log_mode.lua](https://github.com/dynamicers/rime-conf/blob/main/lua/key_log_mode.lua) for implementation details.

---

## Installation Guide (macOS Example)

### 1. Download and Install Rime Frontend

Download and install the appropriate Rime frontend for your operating system:

* **macOS**: [Squirrel (鼠须管)](https://github.com/rime/squirrel/releases)
>>  * **Linux**: [ibus-rime](https://github.com/rime/ibus-rime) 或 [fcitx5-rime](https://github.com/fcitx/fcitx5-rime)
>>  * **Windows**: [Weasel (小狼毫)](https://github.com/rime/weasel/releases)

### 2. Sync Configuration Directory

1. Backup your default configuration:

```bash
mv ~/Library/Rime ~/Library/Rime.bak

```

2. Clone this repository to your Library directory and symlink it to Rime:

```bash
git clone https://github.com/dynamicers/rime-conf.git ~/Library/rime-conf
ln -s ~/Library/rime-conf ~/Library/Rime

```

### 3. Deploy and System Setup

1. Add and select the Rime input method in your system settings:

```
System Settings -> Keyboard -> Input Sources -> Add Chinese -> Squirrel

```

2. Run the Rime **Deploy** function:

```
System Menu Bar -> Input Method Icon -> Squirrel -> Deploy

```

---

## Special Modes Configuration

The integrated `ex_vim_mode` and `key_log_mode` are disabled by default. They can be activated for specific applications by targetting their Bundle IDs in the configuration file.

### 1. ex_vim_mode (Enhanced Vim Mode)

This mode automatically synchronizes the input state for designated editors or terminals, providing functionality similar to [im-select](https://github.com/daipeihust/im-select).

#### Activation Steps

1. Open `squirrel.yaml`:

```bash
vim ~/Library/Rime/squirrel.yaml

```

2. Add the application Bundle IDs to the `app_options` allowlist (using VSCode and Zed as examples):

```yaml
app_options:
  com.microsoft.VSCode:
    ex_vim_mode: true
  dev.zed.Zed:
    ex_vim_mode: true

```

3. Deploy Rime to apply changes:

```
System Menu Bar -> Input Method Icon -> Squirrel -> Deploy

```

### 2. key_log_mode (Keystroke Logging Mode)

This mode logs keystrokes with timestamps to debug input anomalies in specific applications.

#### Activation Steps

1. Open `squirrel.yaml`:

```bash
vim ~/Library/Rime/squirrel.yaml

```

2. Add the application Bundle IDs to the `app_options` allowlist (using VSCode and Zed as examples):

```yaml
app_options:
  com.microsoft.VSCode:
    # ex_vim_mode: true
    key_log_mode: true
  dev.zed.Zed:
    # ex_vim_mode: true
    key_log_mode: true

```

3. Deploy Rime to apply changes. When typing in the specified applications, keystroke data will be written to the designated path. Track the log output using the `tail` command:

```
System Menu Bar -> Input Method Icon -> Squirrel -> Deploy

```

```bash
# Monitor the keystroke log
tail -f /tmp/rime_key.log

```
