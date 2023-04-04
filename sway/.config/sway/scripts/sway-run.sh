#!/usr/bin/env bash

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit

export CALIBRE_USE_DARK_PALETTE=1

export MOZ_ENABLE_WAYLAND=1

export QT_QPA_PLATFORM=wayland-egl
# export QT_WAYLAND_FORCE_DPI=physical
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# Qt5 theme - install qt5ct first
export QT_QPA_PLATFORMTHEME=qt5ct

export ECORE_EVAS_ENGINE=wayland_egl
export ELM_ENGINE=wayland_egl

export SDL_VIDEODRIVER=wayland

exec sway
