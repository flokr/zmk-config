# Aerospace WM Layer Design Sketch

## Layout Philosophy
- **Navigation style**: WASD-like (O E I A) adapted for MagicSturdy layout
- **Modifier**: Ctrl+Alt+Cmd (⌃⌥⌘) - matches existing WM layer
- **Right hand focus**: Keep window management on right hand for ergonomics

## MagicSturdy Base Layer Reference
```
Top row:    V M L C P | Q ß O U J
Home row:   S T R D Z | F N E I A  
Bottom row: Y K X G W | B H , . ?
Thumbs:     WM SPC NUM | ENT BSPC SYM
```

## Proposed Aerospace WM Layer

### Navigation Core (OEIA - WASD style)
```
    O = focus up
E       I = focus down
    A = focus right
```

### Full Right Hand Layout
```
Top row (RT0-RT6):
- RT0: (transparent/unused)
- RT1: Q = workspace 1
- RT2: ß = workspace 2  
- RT3: O = focus up
- RT4: U = workspace 3
- RT5: J = workspace 4
- RT6: (transparent/unused)

Home row (RM0-RM6):
- RM0: F = fullscreen toggle
- RM1: N = ? (TBD - maybe monitor switch)
- RM2: E = focus left
- RM3: I = focus down
- RM4: A = focus right
- RM5: (transparent/unused)
- RM6: (transparent/unused)

Bottom row (RB0-RB5):
- RB0: B = toggle floating/tiling
- RB1: H = resize shrink (smart -50)
- RB2: , = layout tiles toggle horizontal/vertical
- RB3: . = resize grow (smart +50)
- RB4: ? = flatten workspace tree (reset layout)
- RB5: (transparent/unused)

Thumbs (RH0-RH2):
- RH0: Enter = ? (TBD - maybe new container/split)
- RH1: D/BSPC = workspace-back-and-forth
- RH2: Symbol layer = move-node-to-workspace (with shift?)
```

## Discussion Points

### 1. Movement vs Focus
- Current sketch only has **focus** commands (moving cursor between windows)
- Should we add **move** commands (moving windows themselves)?
- Option A: Add shift layer (hold WM + Shift for move instead of focus)
- Option B: Dedicate specific keys for move (but which ones?)

### 2. Monitor Management
- Need shortcuts for multi-monitor setups
- Commands available:
  - `focus-monitor --wrap-around next/prev`
  - `move-workspace-to-monitor next/prev`
- Where to place these? (Currently N is unassigned)

### 3. Workspace Operations
- Switch workspace: 1-4 on top row (Q ß U J)
- Move window to workspace: Need modifier or dedicated keys
  - Option A: Use thumb combo (RH2 + number)
  - Option B: Hold shift with number keys

### 4. Missing Functions
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
- ⌃⌥⌘+A = tall layout (changing to , key for layout toggle)

## Aerospace Commands Reference

### Window Focus
```
focus left/down/up/right
focus-monitor --wrap-around next/prev
```

### Window Movement
```
move left/down/up/right
move-node-to-workspace N [--focus-follows-window]
move-workspace-to-monitor next/prev
```

### Layout
```
layout tiles horizontal vertical
layout accordion horizontal vertical  
layout floating tiling
fullscreen
```

### Window Manipulation
```
resize smart +50 / -50
join-with left/down/up/right
flatten-workspace-tree
close-all-windows-but-current
```

### Workspace
```
workspace N
workspace-back-and-forth
```

## Next Steps
1. Decide on move vs focus priority
2. Assign monitor management keys
3. Design workspace switching + moving windows
4. Implement and test on actual keyboard
5. Update drawing configuration for visualization
