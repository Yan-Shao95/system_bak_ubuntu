# Ubuntu 系统配置备份

Ubuntu 24.04 系统配置备份仓库，用于保存和恢复系统环境配置。

## 系统环境

- **系统**: Ubuntu 24.04.4 LTS (Noble Numbat)
- **内核**: 6.17.0-14-generic
- **桌面**: GNOME on X11 + zsh (Oh-My-Zsh + Powerlevel10k)
- **ROS**: ROS 2 Jazzy

详细硬件信息见 [system_info.txt](./system_info.txt)。

## 包含内容

### 配置文件 (`config_selected/`)

| 目录 | 内容 |
|------|------|
| `dconf/` | GNOME 桌面配置 |
| `tiling-assistant/` | 窗口平铺扩展配置 |
| `autostart/` | 自启动应用配置 (ToDesk, Clash Verge) |
| `nvim/` | Neovim 配置 (lazy.nvim + LSP + treesitter) |
| `Code/` | VSCode 用户配置、扩展、设置同步 |
| `fcitx5/` | Fcitx5 中文输入法配置 |
| `gtk-3.0/` | GTK 主题配置 |

### Shell 配置

- `.bashrc` - Bash shell 配置
- `.zshrc` - Zsh shell 配置 (含 Powerlevel10k)
- `.p10k.zsh` - Powerlevel10k 主题配置
- `.profile` / `.zprofile` - 环境变量配置

### 开发工具配置

- `local_bin/` - 本地二进制工具
- `.zcompdump*` - Zsh 补全缓存

### ROS 相关

- `ros_distro.txt` - ROS 发行版信息
- `system_info.txt` - 系统信息快照

## 使用方法

### 恢复配置

```bash
./restore.sh
```

恢复脚本会将 `config_selected/` 中的配置复制到对应的用户目录。

### 修改后保存

```bash
# 提交更改
git add .
git commit -m "描述你的修改"
git push
```

## 未来修改说明

所有系统配置修改基于本版本进行：

1. 修改配置文件后，运行 `restore.sh` 确认无误
2. 将修改后的对应文件复制到 `config_selected/` 目录
3. 提交并推送到 GitHub

## 主要 Alias

```bash
cb        # colcon build --symlink-install
cbfast    # 并行编译
cbrel     # Release 模式编译
cbdbg     # Debug 模式编译
cbp       # 编译单个包
cleanws   # 清理 ROS 工作区
```

## 注意事项

- 敏感信息（如 SSH known_hosts）已包含在备份中
- VSCode 扩展和设置通过 VSCode 自带的设置同步功能管理