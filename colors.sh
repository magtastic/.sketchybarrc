#!/usr/bin/env bash
# macOS-native dark-menubar palette: translucent dark, pure white text,
# frosted pill for active state. ARGB hex.

# Bar — fully transparent (blur still applies if blur_radius > 0).
export COLOR_BAR=0x00000000

# Text & icons
export COLOR_TEXT=0xffffffff         # pure white
export COLOR_TEXT_MUTED=0x99ffffff   # 60% white — inactive workspace digit, etc.
export COLOR_TEXT_DIM=0x66ffffff     # 40% white — disabled / deactivated

# Active state — frosted highlight (think Control Center selection).
export COLOR_ACCENT=0x33ffffff       # 20% white pill
export COLOR_ACCENT_ON=0xffffffff    # full-white text on the pill

# No colored group bracket — native menubar has no group framing.
export COLOR_GROUP_BG=0x00000000

# Status colors
export COLOR_ATTENTION=0xfff9d56e    # warm yellow (caffeinate, etc.)
export COLOR_WARNING=0xffff6961      # soft red (low battery, etc.)

# Back-compat (referenced from existing item .sh scripts and plugins).
export COLOR_DEFAULT_ICON=$COLOR_TEXT
export COLOR_DEFAULT_LABEL=$COLOR_TEXT
export COLOR_ATTENTION_ICON=$COLOR_ATTENTION
export COLOR_ATTENTION_LABEL=$COLOR_ATTENTION
export COLOR_WARNING_ICON=$COLOR_WARNING
export COLOR_WARNING_LABEL=$COLOR_WARNING
export COLOR_DEACTIVATED_ICON=$COLOR_TEXT_DIM
export COLOR_DEACTIVATED_LABEL=$COLOR_TEXT_DIM
export COLOR_ACTIVATED_ICON=$COLOR_TEXT
