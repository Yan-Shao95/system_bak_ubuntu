# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ================================
# Engineer Practical ZSH Config
# Ubuntu 24.04 + ROS2 + C++ + Python
# ================================

export ZSH="$HOME/.oh-my-zsh"

# ===== Theme =====
ZSH_THEME="powerlevel10k/powerlevel10k"

# ===== Plugins =====
plugins=(
  git
  sudo
  z
  extract
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ==========================================
# ROS2 Environment
# ==========================================

# 修改为你的 ROS 版本 (humble / iron / jazzy 等)
if [ -f /opt/ros/jazzy/setup.zsh ]; then
  source /opt/ros/jazzy/setup.zsh
fi

# 自动 source 工作空间
if [ -f ~/ros2_ws/install/setup.zsh ]; then
  source ~/ros2_ws/install/setup.zsh
fi

export ROS_DOMAIN_ID=0
export RCUTILS_COLORIZED_OUTPUT=1

# ==========================================
# Colcon & Build Optimization
# ==========================================

export CC="ccache gcc"
export CXX="ccache g++"

alias cb='colcon build --symlink-install'
alias cbfast='colcon build --symlink-install --parallel-workers $(nproc)'
alias cbrel='colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release'
alias cbdbg='colcon build --cmake-args -DCMAKE_BUILD_TYPE=Debug'
alias cbp='colcon build --packages-select'
alias cleanws='rm -rf build install log'

rebuild() {
  rm -rf build install log
  colcon build --symlink-install
  source install/setup.zsh
}

# ==========================================
# ROS2 Shortcuts
# ==========================================

alias cw='cd ~/ros2_ws'
alias cs='cd ~/ros2_ws/src'

alias rr='ros2 run'
alias rl='ros2 launch'
alias rt='ros2 topic'
alias rn='ros2 node list'
alias rp='ros2 pkg list'
alias rbag='ros2 bag record -a'

rtfreq() {
  ros2 topic hz $1
}

alias tftree='ros2 run tf2_tools view_frames'

# ==========================================
# C++ Development
# ==========================================

gpp() {
  g++ -std=c++17 -O2 "$1" -o "${1%.*}"
}

gdbg() {
  g++ -g "$1" -o debug_exec && gdb ./debug_exec
}

alias fmt='clang-format -i'

# ==========================================
# Python Development
# ==========================================

alias py='python3'
alias pipi='pip install'
alias pipu='pip install --upgrade pip'
alias req='pip freeze > requirements.txt'

# 自动激活 .venv
autoload -U add-zsh-hook
load-venv() {
  if [[ -f .venv/bin/activate ]]; then
    source .venv/bin/activate
  fi
}
add-zsh-hook chpwd load-venv

# ==========================================
# Git Shortcuts
# ==========================================

alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# ==========================================
# System Improvements
# ==========================================

export EDITOR=nvim
export VISUAL=nvim

# 提高 inotify 限制（避免 colcon 报错）
# 只需执行一次
# echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
# sudo sysctl -p

# ==========================================
# History Settings
# ==========================================

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# ==========================================
# Powerlevel10k Minimal Engineer Layout
# ==========================================

# 如果第一次安装，可运行：
# p10k configure

# 建议手动选择：
# - Lean
# - Unicode
# - 显示 Git 状态
# - 显示 执行时间
# - 显示 Python venv
# - 显示 CPU 负载（Jetson 推荐）

# ==========================================
# Custom Prompt Add-ons (Optional)
# ==========================================

# 显示 ROS_DISTRO
prompt_ros() {
  if [[ -n "$ROS_DISTRO" ]]; then
    echo "%F{cyan}[ROS:$ROS_DISTRO]%f "
  fi
}
RPROMPT='$(prompt_ros)'

# ==========================================
# End of File
# ==========================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2026-02-28 06:04:59
export PATH="$PATH:/home/rj-1/.local/bin"
export PATH=$HOME/.npm-global/bin:$PATH
