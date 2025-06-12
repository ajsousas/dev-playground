#!/bin/bash

# Start Xvfb (virtual framebuffer)
Xvfb :1 -screen 0 1280x720x24 &

# Start fluxbox (window manager)
fluxbox &

# Start x11vnc (VNC server)
x11vnc -display :1 -forever -shared -nopw &

# Start code-server
code-server --host 0.0.0.0 --port 8080 --auth none --disable-telemetry --user-data-dir /home/developer/.vscode-server &

# Keep the container running
tail -f /dev/null