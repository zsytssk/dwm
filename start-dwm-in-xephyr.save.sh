#!/bin/bash

# 定义嵌套窗口的分辨率（如 800x600）
RESOLUTION="1400x900"

# 启动 Xephyr 嵌套窗口
Xephyr -br -ac -noreset -screen "$RESOLUTION" -resizeable :1 &
sleep 1 # 等待 Xephyr 初始化

# 在 Xephyr 中启动 dwm
DISPLAY=:1 ./dwm &

# 在 Xephyr 中启动测试程序（如 xterm）
DISPLAY=:1 firefox &

# 保持脚本运行（防止嵌套窗口退出）
wait
