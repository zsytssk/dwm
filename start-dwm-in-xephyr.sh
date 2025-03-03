#!/bin/bash

# 定义嵌套窗口的分辨率（如 800x600）
RESOLUTION="1400x900"

# 启动 Xephyr 嵌套窗口
Xephyr -br -ac -noreset -screen "$RESOLUTION" -resizeable :1 &
sleep 1
DISPLAY=:1 kitty &
DISPLAY=:1 feh --bg-scale ~/Downloads/253852.jpg &

# 在 Xephyr 中启动 dwm，并持续监听 dwm 进程
while pgrep -x "Xephyr" > /dev/null; do
    # 检查 dwm 是否运行
    if ! pgrep -x "dwm" > /dev/null; then
        echo "dwm 正在重启..."
        DISPLAY=:1 xrandr | grep ' connected'
        DISPLAY=:1 make
        DISPLAY=:1 ./dwm &
    fi
    sleep 1
done

# 当 Xephyr 关闭后，脚本退出
echo "Xephyr 已关闭，脚本退出。"