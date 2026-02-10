# Aerospace Setup Notes

This document contains configuration notes and solutions for the Aerospace window manager setup.

## App Launching

### Using Aerospace `exec-and-forget` Command

Aerospace can launch applications directly using the `exec-and-forget` command. This is the cleanest approach for frequently-used apps.

**Add to `~/.config/aerospace/aerospace.toml`:**

```toml
[mode.main.binding]
# Launch frequently used applications
cmd-alt-t = 'exec-and-forget open -a Ghostty'
cmd-alt-b = 'exec-and-forget open -a "Arc Browser"'  # or "Safari", "Google Chrome"
cmd-alt-z = 'exec-and-forget open -a Zed'
cmd-alt-s = 'exec-and-forget open -a Slack'
cmd-alt-f = 'exec-and-forget open -a Finder'
cmd-alt-m = 'exec-and-forget open -a Mail'

# Alternative: Launch by bundle identifier
# cmd-alt-t = 'exec-and-forget open -b com.mitchellh.ghostty'
```

**Benefits:**
- Apps open in current workspace
- No additional tools needed
- Can be triggered from external keyboard macros
- Fast and reliable

**Usage from ZMK Keyboard:**
- Add macros to WM layer that send `Cmd+Alt+T`, etc.
- Or use left hand available keys (Y, K, X, G, W) for app launchers

## Laptop Mode (Without External Keyboard)

### Problem
When using the laptop without external keyboard, the full keyboard-driven WM setup is inconvenient on the built-in QWERTZ keyboard.

### Solution: Aerospace Modes

Aerospace supports multiple modes that can be switched on-the-fly. Create a minimal "laptop" mode for mouse-driven operation.

**Add to `~/.config/aerospace/aerospace.toml`:**

```toml
# ============================================
# MAIN MODE - Full keyboard-driven WM
# (Used with external keyboard)
# ============================================
[mode.main.binding]

# Mode switching
cmd-shift-f12 = 'mode laptop'  # Switch to laptop mode

# Window focus (OEIA cluster from external keyboard)
# These would be bound to your ZMK keyboard macros
cmd-alt-o = 'focus up'
cmd-alt-e = 'focus left'
cmd-alt-i = 'focus down'
cmd-alt-a = 'focus right'

# ... all your other main mode bindings ...

# ============================================
# LAPTOP MODE - Minimal, mouse-friendly
# (Used with built-in keyboard)
# ============================================
[mode.laptop.binding]

# Mode switching
cmd-shift-f12 = 'mode main'  # Switch back to main mode

# Essential workspace switching (standard number keys)
cmd-1 = 'workspace 1'
cmd-2 = 'workspace 2'
cmd-3 = 'workspace 3'
cmd-4 = 'workspace 4'
cmd-5 = 'workspace 5'
cmd-6 = 'workspace 6'
cmd-7 = 'workspace 7'
cmd-8 = 'workspace 8'

# Move window to workspace (with Shift)
cmd-shift-1 = 'move-node-to-workspace 1'
cmd-shift-2 = 'move-node-to-workspace 2'
cmd-shift-3 = 'move-node-to-workspace 3'
cmd-shift-4 = 'move-node-to-workspace 4'
cmd-shift-5 = 'move-node-to-workspace 5'
cmd-shift-6 = 'move-node-to-workspace 6'
cmd-shift-7 = 'move-node-to-workspace 7'
cmd-shift-8 = 'move-node-to-workspace 8'

# Basic navigation using arrow keys
cmd-alt-left = 'focus left'
cmd-alt-right = 'focus right'
cmd-alt-up = 'focus up'
cmd-alt-down = 'focus down'

# Window operations
cmd-shift-f = 'fullscreen'
cmd-shift-w = 'close'
cmd-shift-space = 'layout floating tiling'

# Monitor switching (for multi-monitor at office)
cmd-shift-left = 'focus-monitor left'
cmd-shift-right = 'focus-monitor right'

# App launching (same as main mode)
cmd-alt-t = 'exec-and-forget open -a Ghostty'
cmd-alt-b = 'exec-and-forget open -a "Arc Browser"'
cmd-alt-z = 'exec-and-forget open -a Zed'
```

### Usage

**Switch to laptop mode:**
Press `Cmd+Shift+F12` when disconnecting external keyboard

**Switch back to main mode:**
Press `Cmd+Shift+F12` again when reconnecting external keyboard

**In laptop mode:**
- Use mouse for most window management
- Use Cmd+1/2/3/4 for workspace switching
- Use Cmd+Arrow keys for basic navigation
- Minimal keybindings, focused on essentials

### Optional: Sketchybar Mode Indicator

Add a visual indicator in Sketchybar showing current Aerospace mode.

**Step 1: Add `on-mode-changed` hook to `~/.config/aerospace/aerospace.toml`:**

```toml
# Notify Sketchybar when Aerospace mode changes
on-mode-changed = ['exec-and-forget sketchybar --trigger aerospace_mode_change MODE=$(aerospace list-modes --current)']
```

**Step 2: Create `~/.config/sketchybar/plugins/aerospace-mode.sh`:**

```bash
#!/bin/bash

MODE="$MODE"  # Passed via Sketchybar event variable

if [ "$MODE" = "laptop" ]; then
    sketchybar --set aerospace_mode label="💻 Laptop"
else
    sketchybar --set aerospace_mode label="⌨️ Main"
fi
```

**Step 3: Add to `~/.config/sketchybar/sketchybarrc`:**

```bash
sketchybar --add item aerospace_mode right \
           --set aerospace_mode script="$PLUGIN_DIR/aerospace-mode.sh" \
           --subscribe aerospace_mode aerospace_mode_change
```

> **Note:** This uses Aerospace's `on-mode-changed` callback to trigger a custom Sketchybar event (`aerospace_mode_change`) whenever the mode switches, rather than polling.

## Sketchybar Gap Issue

### Problem
Windows in Aerospace overlay the Sketchybar, making it invisible.

### Solution: Configure Gaps

Aerospace needs to be told about Sketchybar's position to reserve space for it.

**Add to `~/.config/aerospace/aerospace.toml`:**

```toml
[gaps]
inner.horizontal = 10
inner.vertical =   10
outer.left =       10
outer.bottom =     10
outer.top =        10
outer.right =      60  # Reserve space for Sketchybar (adjust based on your bar width)
```

**If Sketchybar is on the right (vertical):**
- Use `outer.right` to reserve horizontal space
- Set value = Sketchybar width + desired gap
- Example: If bar is 50px wide, use `outer.right = 60` or `70`

**If Sketchybar is on top (horizontal):**
- Use `outer.top` instead
- Set value = Sketchybar height + desired gap

### Testing Gap Values

After changing gaps, reload Aerospace config:
```bash
aerospace reload-config
```

Windows should reposition immediately after reloading. Verify visually that Sketchybar is no longer overlapped.

### Limitation: Per-Monitor Gaps

Aerospace does not support per-monitor gap configuration. Gaps are global. If Sketchybar is only on one monitor, the reserved gap will apply to all monitors.

As a workaround, you can assign specific workspaces to specific monitors, but the gap values remain the same everywhere:

```toml
[workspace-to-monitor-force-assignment]
1 = 'main'       # Laptop screen
2 = 'main'
3 = 'secondary'  # External monitor 1
4 = 'secondary'
5 = 'tertiary'   # External monitor 2
6 = 'tertiary'
```

## Related Resources

- Aerospace documentation: https://github.com/nikitabobko/AeroSpace
- Aerospace mode switching: `aerospace list-modes --help` or see [aerospace-mode docs](https://nikitabobko.github.io/AeroSpace/commands#mode)
- Sketchybar examples: https://github.com/FelixKratz/SketchyBar
