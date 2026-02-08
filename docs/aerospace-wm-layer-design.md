# Aerospace WM Layer Design

## Layout Philosophy

The design splits functionality between hands:
- **Left hand**: Monitor/screen management ("which screen?")
- **Right hand**: Window/workspace management ("what's on this screen?")

Both sides use WASD-style directional navigation adapted for MagicSturdy layout.

**Key insight**: Side-by-side monitor setup only needs left/right monitor navigation, not up/down.

## MagicSturdy Base Layer Reference
```
Top row:    V M L C P | Q ß O U J
Home row:   S T R D Z | F N E I A  
Bottom row: Y K X G W | B H , . ?
Thumbs:     NUM SPC/NAV WM | ENT BSPC SYM
```

## WM Layer Mapping

### LEFT HAND - Monitor Management

**Monitor Navigation (Home Row):**
- `T` = `focus-monitor left`
- `D` = `focus-monitor right`

**Shift Layer - Move Window to Monitor:**
- `Shift+T` = `move-node-to-monitor left` (move window to left monitor)
- `Shift+D` = `move-node-to-monitor right` (move window to right monitor)

**Dedicated Monitor Keys (Top Row):**
- `M` = `focus-monitor <pattern-1>` (monitor 1 by pattern/name)
- `L` = `focus-monitor <pattern-2>` (monitor 2 by pattern/name)
- `C` = `focus-monitor <pattern-3>` (monitor 3 by pattern/name)

**With Shift - Move Workspace to Monitor:**
- `Shift+M` = `move-workspace-to-monitor <pattern-1>`
- `Shift+L` = `move-workspace-to-monitor <pattern-2>`
- `Shift+C` = `move-workspace-to-monitor <pattern-3>`

**Special:**
- `V` = `summon-workspace <number>` (bring workspace to current monitor)

**Available for future use:** S, R, Y, K, X, G, W, Z, P

### RIGHT HAND - Window & Workspace Management

**Window Focus (OEIA - Home Row):**
- `O` = `focus up`
- `E` = `focus left`
- `I` = `focus down`
- `A` = `focus right`

**Shift Layer - Move Window Position:**
- `Shift+O` = `move up`
- `Shift+E` = `move left`
- `Shift+I` = `move down`
- `Shift+A` = `move right`

**Workspace Switching (Top Row - 8 workspaces with Ctrl modifier):**

Base layer (workspaces 1-4):
- `Q` = `workspace 1`
- `ß` = `workspace 2`
- `U` = `workspace 3`
- `J` = `workspace 4`

Ctrl layer (workspaces 5-8):
- `Ctrl+Q` = `workspace 5`
- `Ctrl+ß` = `workspace 6`
- `Ctrl+U` = `workspace 7`
- `Ctrl+J` = `workspace 8`

**Shift - Move Window to Workspace:**

Base (move to workspaces 1-4):
- `Shift+Q` = `move-node-to-workspace 1`
- `Shift+ß` = `move-node-to-workspace 2`
- `Shift+U` = `move-node-to-workspace 3`
- `Shift+J` = `move-node-to-workspace 4`

Ctrl+Shift (move to workspaces 5-8):
- `Ctrl+Shift+Q` = `move-node-to-workspace 5`
- `Ctrl+Shift+ß` = `move-node-to-workspace 6`
- `Ctrl+Shift+U` = `move-node-to-workspace 7`
- `Ctrl+Shift+J` = `move-node-to-workspace 8`
Currently not assigned:
- `join-with` (create splits/containers manually)
- `move` (move windows around)
- `close-all-windows-but-current`
- `reload-config`
- App launchers (like Alt+W for terminal)

### 5. Smart Shortcuts
From current WM layer we're replacing:
- ⌃⌥⌘+Enter = swap with main (Amethyst specific - not needed in Aerospace)
- ⌃⌥⌘+D = fullscreen layout (keeping as F key)
**Layout Controls (Bottom Row):**
- `B` = `layout floating tiling` (toggle window floating/tiling)
- `H` = `resize smart -50` (shrink window)
- `,` = `layout tiles accordion` (toggle layout type)
- `.` = `resize smart +50` (grow window)
- `?` = `flatten-workspace-tree` (reset complex layouts)

**Utility (Home Row):**
- `F` = `close` (close focused window)
- `N` = `workspace next` (cycle to next workspace on current monitor)

**Thumbs (frequently used operations):**
- `RH0` (Enter) = `fullscreen` (toggle fullscreen - fills screen, auto-exits when focusing other window)
- `RH1` (Backspace) = `workspace-back-and-forth` (toggle between current and previous workspace)
- `RH2` (Symbol) = Available for future use

## Verified Aerospace Commands

All commands used in this design have been verified against the Aerospace source code at `/Users/florian.kren/code/flokr/AeroSpace/docs/`:

✅ `focus` (left|down|up|right) - Focus window in direction  
✅ `move` (left|down|up|right) - Move window position in direction  
✅ `focus-monitor` (left|right|next|prev) - Switch monitor focus  
✅ `move-node-to-monitor` (left|right|next|prev) - Move window to monitor  
✅ `move-workspace-to-monitor` (next|prev) - Move entire workspace  
✅ `workspace` <name> - Switch to workspace  
✅ `workspace next` - Cycle to next workspace  
✅ `move-node-to-workspace` <name> - Move window to workspace  
✅ `fullscreen` - Toggle fullscreen (default behavior)  
✅ `workspace-back-and-forth` - Toggle between current and previous workspace  
✅ `close` - Close focused window  
✅ `resize smart` [+|-]<number> - Resize window intelligently  
✅ `layout` (tiles|accordion) - Toggle layout type  
✅ `layout` (floating|tiling) - Toggle window tiling mode  
✅ `flatten-workspace-tree` - Reset layout structure  
✅ `summon-workspace` <name> - Bring workspace to current monitor

## Design Rationale

**Split-hand approach:**
- Left hand manages which *screen* you're looking at
- Right hand manages *what's on* that screen
- Clear mental model reduces cognitive load

**Shift for "move" operations:**
- Base layer: Focus/switch (read-only navigation)
- Shift layer: Move/send (modifying window placement)
- Ctrl modifier: Access workspaces 5-8 (doubles workspace capacity)
- Consistent pattern across all operations

**8 workspaces via Ctrl modifier:**
- Base: Q/ß/U/J = workspaces 1-4
- Ctrl: Q/ß/U/J = workspaces 5-8
- Same physical keys, more capacity

**Thumb placement for frequent operations:**
- Fullscreen toggle (RH0) - most common single-window view
- Workspace back-and-forth (RH1) - quick workspace switching
- Easy access for high-frequency operations

**Side-by-side monitor optimization:**
- Left/right navigation on T/D (matches physical arrangement)
- Direct monitor access via M/L/C (fast switching without cycling)
- No prev/next cycling needed - dedicated keys are clearer

**WASD-style navigation:**
- T/D on left hand (monitor left/right)
- OEIA on right hand (window management)
- Familiar pattern adapted for MagicSturdy layout
- All four directions available for window focus/move (up/down/left/right)

## ZMK Implementation Notes

**Shift detection:**
- Use `&kp LS(...)` for shifted commands
- Or use conditional layers with `&mo SHIFT` held

**Workspace numbers:**
- Aerospace uses string names, so `workspace 1` not `workspace N1`
- ZMK macros should send literal "1", "2", "3", "4"

**Command format:**
- All Aerospace commands via CLI: `/opt/homebrew/bin/aerospace <command>`
- Can be bound via macOS keyboard shortcuts in Aerospace config
- Or via ZMK macros sending the actual keypresses configured in aerospace.toml

## Next Steps

1. ✅ Verify all Aerospace commands exist
2. ✅ Adjust for side-by-side monitor setup  
3. ⏳ Implement WM layer in ZMK keymap
4. ⏳ Configure Aerospace keybindings in aerospace.toml
5. ⏳ Update draw/config.yaml for visualization
6. ⏳ Test workflow with actual keyboard
7. ⏳ Fine-tune based on usage patterns
