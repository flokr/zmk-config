# Aerospace WM Layer Design (v2.1)

## Design Principles

1. **WASD-style navigation** on both hands, centered on middle finger home position
2. **Split-hand**: left = monitors/screens, right = windows/workspaces
3. **Shift modifier** doubles every key: base = focus/switch, shift = move/send
4. **Dedicated keys** for 3 monitors and 8 workspaces (no modifier gymnastics)
5. **Two WM sub-layers**: WM (navigation) + SCR (reshape/resize)
6. **App launchers on base layer** — independent of WM layer

## Keyboard Reference

```
MagicSturdy base layer (Corne Choc Pro, 46 keys):

         Left                              Right
Top:  V  M  L  C  P              Q  ß  O  U  J
Home: S  T  R  D  Z              F  N  E  I  A
Bot:  Y  K  X  G  W              B  H  ,  .  ?
Thumbs:     NUM SPC/NAV [WM]  ENT BSPC SYM

WM layer activated by holding LH0 (left inner thumb).
SCR layer activated by holding LH0 + RH1 (both thumbs).
Shift available on outer bottom row keys (LB5/RB5).
```

## Layer Architecture

```
┌─────────────────────────────────────────────────┐
│ BASE LAYER                                       │
│   Hold LH0 ──► WM LAYER (navigation/workspaces) │
│                   Hold RH1 ──► SCR LAYER         │
│                                (resize/layout)   │
│                   Tap RH1  ──► float toggle      │
└─────────────────────────────────────────────────┘

WM layer:  Focus, move, workspaces, monitors, close, fullscreen
SCR layer: Resize, balance, layout orientation, flatten, reload
```

## WM Layer

```
WM LAYER (hold LH0)
Shift variants shown in parentheses

         Left hand                                Right hand
    ╭───────────────────────────────╮    ╭───────────────────────────────╮
    │     MON  MON  MON            │    │  W1  W2   ↑   W3  W4        │
TOP │  .   M    L    C    .   .   │    │  .   .  focus  .   .    .   │
    │    (mvws)(mvws)(mvws)        │    │ (mv  (mv  ↑  (mv  (mv      │
    │                              │    │  w)   w) win  w)   w)       │
    ├───────────────────────────────┤    ├───────────────────────────────┤
    │     mon        mon           │    │       ←   ↓    →             │
HOM │  .   ←   WBF   →    .  .   │    │close focus focus focus BAL  │
    │    (mv        (mv            │    │     (mv  (mv  (mv           │
    │     ←)         →)            │    │      ←)   ↓)   →)           │
    ├───────────────────────────────┤    ├───────────────────────────────┤
    │                               │    │  W5  W6   W7  W8           │
BOT │  .   .    .    .    .        │    │ (mv  (mv  (mv  (mv    .    │
    │                               │    │  w)   w)  w)   w)          │
    ├───────────────────────────────┤    ├───────────────────────────────┤
THM │          .      .  [WM hold] │    │ FULL [SCR]  .               │
    ╰───────────────────────────────╯    ╰───────────────────────────────╯

Legend:
  ↑↓←→  = directional focus (base) / move (shift)
  MON   = focus-monitor by pattern (shift = move-workspace-to-monitor)
  mon←→ = focus-monitor left/right (shift = move-node-to-monitor)
  W1-W8 = workspace (shift = move-node-to-workspace)
  WBF   = workspace-back-and-forth
  FULL  = fullscreen toggle
  [SCR] = hold for SCR layer, tap for float toggle
  BAL   = balance-sizes
```

## SCR Layer (Screen Reshape)

```
SCR LAYER (hold LH0 + hold RH1)
Only home row positions used — fingers stay on resting position.

         Left hand                                Right hand
    ╭───────────────────────────────╮    ╭───────────────────────────────╮
TOP │  .   .  RELOAD .    .   .   │    │  .   .    .    .   .    .   │
    ├───────────────────────────────┤    ├───────────────────────────────┤
HOM │  .  ORIENT BAL FLAT  .  .   │    │  .  SHRINK .  GROW  .   .  │
    ├───────────────────────────────┤    ├───────────────────────────────┤
BOT │  .   .    .    .    .        │    │  .   .    .    .    .       │
    ├───────────────────────────────┤    ├───────────────────────────────┤
THM │          .      .  [WM hold] │    │  .  [SCR hold] .            │
    ╰───────────────────────────────╯    ╰───────────────────────────────╯

Legend:
  ORIENT = layout tiles horizontal vertical (toggle split)
  BAL    = balance-sizes
  FLAT   = flatten-workspace-tree
  RELOAD = reload-config
  SHRINK = resize smart -50
  GROW   = resize smart +50
```

## Detailed Key Assignments

### Modifier Scheme

The ZMK WM layer sends `Ctrl+Alt+Cmd` as a base modifier prefix on every key.
With Shift held (outer pinky key), it sends `Ctrl+Alt+Cmd+Shift`.

- **Base (WM only)**: read-only — focus windows, switch workspaces, switch monitors
- **Shift (WM + Shift)**: destructive — move windows, move workspaces

The SCR layer uses the same `Ctrl+Alt+Cmd` prefix but sends different keycodes
(F-keys) to avoid conflicts with WM layer bindings.

### LEFT HAND — Monitor & Screen Management

**Home row navigation:**

| Key | Position | Base (focus)            | Shift (move)                |
|-----|----------|-------------------------|-----------------------------|
| `T` | home row | `focus-monitor left`    | `move-node-to-monitor left` |
| `R` | home row | `workspace-back-and-forth` | *(unbound)*              |
| `D` | home row | `focus-monitor right`   | `move-node-to-monitor right`|

**Dedicated monitor keys (top row — M, L, C):**

| Key | Position | Base (focus)                  | Shift (move workspace)                  |
|-----|----------|-------------------------------|-----------------------------------------|
| `M` | top row  | `focus-monitor <pattern-1>`   | `move-workspace-to-monitor <pattern-1>` |
| `L` | top row  | `focus-monitor <pattern-2>`   | `move-workspace-to-monitor <pattern-2>` |
| `C` | top row  | `focus-monitor <pattern-3>`   | `move-workspace-to-monitor <pattern-3>` |

> Monitor patterns: set to `main`, `secondary`, or a regex matching your monitor
> names. Configure these in `aerospace.toml` once you know your monitor IDs.

**Bottom row:** Available for future use (layout controls moved to SCR layer).

**Available keys:** `S` (home pinky), `V` (top outer), `P` (top inner),
`Y` (bottom outer), `K`/`X`/`G`/`W` (bottom row), `Z` (home inner)

### RIGHT HAND — Window & Workspace Management

**Navigation cluster (ONEI — WASD shape):**

| Key | Position | Base (focus)    | Shift (move)  |
|-----|----------|-----------------|---------------|
| `O` | top row  | `focus up`      | `move up`     |
| `N` | home row | `focus left`    | `move left`   |
| `E` | home row | `focus down`    | `move down`   |
| `I` | home row | `focus right`   | `move right`  |

**Dedicated workspace keys (top row):**

| Key | Position | Base (switch)   | Shift (move window to) |
|-----|----------|-----------------|------------------------|
| `Q` | top row  | `workspace 1`   | `move-node-to-workspace 1` |
| `ß` | top row  | `workspace 2`   | `move-node-to-workspace 2` |
| `U` | top row  | `workspace 3`   | `move-node-to-workspace 3` |
| `J` | top row  | `workspace 4`   | `move-node-to-workspace 4` |

**Dedicated workspace keys (bottom row):**

| Key | Position | Base (switch)   | Shift (move window to) |
|-----|----------|-----------------|------------------------|
| `B` | bottom   | `workspace 5`   | `move-node-to-workspace 5` |
| `H` | bottom   | `workspace 6`   | `move-node-to-workspace 6` |
| `,` | bottom   | `workspace 7`   | `move-node-to-workspace 7` |
| `.` | bottom   | `workspace 8`   | `move-node-to-workspace 8` |

> 8 workspaces on 8 dedicated keys — no modifier doubling needed. Top row = 1-4,
> bottom row = 5-8. Physical position maps to workspace number left-to-right.

**Utility keys:**

| Key | Position     | Action                     |
|-----|--------------|----------------------------|
| `F` | home inner   | `close` (close window)     |
| `A` | home outer   | `balance-sizes`            |

**Thumb keys:**

| Key   | Position | Action                                      |
|-------|----------|---------------------------------------------|
| `ENT` | RH0     | `fullscreen` (toggle)                       |
| `BSPC`| RH1     | hold = SCR layer, tap = `layout floating tiling` |
| `SYM` | RH2     | Available for future use                    |

### SCR LAYER — Resize & Layout

Activated by holding RH1 while on the WM layer (conditional layer: WM + SCR trigger).
Uses F-key keycodes with `Ctrl+Alt+Cmd` prefix to avoid clashing with WM bindings.

**Left hand (layout utility, home row):**

| Key pos | SCR action                            | Keycode sent | Aerospace binding      |
|---------|---------------------------------------|--------------|------------------------|
| T pos   | `layout tiles horizontal vertical`    | `F1`         | `ctrl-alt-cmd-f1`     |
| R pos   | `balance-sizes`                       | `F2`         | `ctrl-alt-cmd-f2`     |
| D pos   | `flatten-workspace-tree`              | `F3`         | `ctrl-alt-cmd-f3`     |
| L pos   | `reload-config`                       | `F4`         | `ctrl-alt-cmd-f4`     |

**Right hand (resize, home row):**

| Key pos | SCR action                            | Keycode sent | Aerospace binding      |
|---------|---------------------------------------|--------------|------------------------|
| N pos   | `resize smart -50` (shrink)           | `F5`         | `ctrl-alt-cmd-f5`     |
| I pos   | `resize smart +50` (grow)             | `F6`         | `ctrl-alt-cmd-f6`     |

> Shrink on N (below/left = smaller), Grow on I (above/right = bigger).
> Matches the spatial logic of the navigation cluster.

### BASE LAYER — App Launchers (independent of WM)

These go in `aerospace.toml` under `[mode.main.binding]` and are triggered
by key combos sent from the base layer (not the WM layer). Using `Cmd+Alt`
prefix since it doesn't conflict with standard macOS shortcuts.

| Shortcut    | Action                                    |
|-------------|-------------------------------------------|
| `Cmd+Alt+T` | `exec-and-forget open -a Ghostty`        |
| `Cmd+Alt+B` | `exec-and-forget open -a "Arc Browser"`  |
| `Cmd+Alt+S` | `exec-and-forget open -a Slack`          |
| `Cmd+Alt+M` | `exec-and-forget open -a Mail`           |
| `Cmd+Alt+F` | `exec-and-forget open -a Finder`         |

> These can be sent from the base layer via ZMK macros on available keys,
> or just typed directly on the laptop keyboard. Not part of the WM layer.

## Workspace Assignments

Suggested workspace-to-app mapping for your workflow:

| Workspace | App                | Window rule           |
|-----------|--------------------|-----------------------|
| 1         | Browser (Arc)      | fullscreen            |
| 2         | MS Teams           | fullscreen            |
| 3         | MS Outlook         | fullscreen            |
| 4         | Terminal(s)        | tiled                 |
| 5         | Secondary terminal | tiled                 |
| 6-8       | Available          |                       |

## Design Rationale

**Two-layer WM architecture (WM + SCR):**
- WM layer stays focused on navigation — the actions you do 100x/day
- SCR layer holds reshape operations — things you do a few times per session
- SCR activation is ergonomic: just add right thumb to existing WM hold
- Both layers use the same home row finger positions

**WASD shape on middle finger home (ONEI for windows):**
- Natural finger curl — middle finger reaches up, index/ring reach sideways
- O(up) N(left) E(down) I(right) — window directions

**Left hand: monitors + workspace-back-and-forth:**
- T(left) D(right) — monitor focus, matches physical side-by-side layout
- R = workspace-back-and-forth on the best key (middle finger home)
- M/L/C on top row — direct monitor access by pattern
- No up/down monitor keys (side-by-side only setup)

**8 workspaces without modifier stacking:**
- Top row (Q/ß/U/J) = workspaces 1-4
- Bottom row (B/H/,/.) = workspaces 5-8
- Shift + workspace key = move window to that workspace
- Only two modifier states to remember: base and shift

**Shift for all "move" operations — consistent across everything:**
- Shift + navigation = move window in direction
- Shift + workspace = move window to workspace
- Shift + monitor = move workspace to monitor
- One mental model: "shift = pick up and move"

**3 dedicated monitor keys (M/L/C):**
- Instant access, no cycling through monitors
- Shift variant moves entire workspace to that monitor
- Pattern-based: works regardless of physical arrangement

**SCR layer uses F-key keycodes:**
- F1-F6 are unused in WM bindings, won't conflict
- Same `Ctrl+Alt+Cmd` prefix — Aerospace config just adds 6 more bindings
- Clear separation: letter keys = WM, F-keys = SCR

**Thumbs for high-frequency toggles:**
- Fullscreen on ENT (most common single-window view)
- Float toggle on BSPC tap (quick escape from tiling)
- BSPC hold = SCR layer (natural thumb extension)

## ZMK Implementation Notes

**Layer setup:**
- Layer 6 = WM (activated by hold LH0)
- Layer 7 = SCR (conditional layer: WM + SCR trigger key)
- SCR trigger: RH1 position on the WM layer uses `&lt SCR <float-toggle-keycode>`
  (hold = activate SCR layer, tap = send float toggle to Aerospace)

**How the WM layer works with Aerospace:**
1. ZMK WM layer key sends `Ctrl+Alt+Cmd+<keycode>` (via `&kp LC(LA(LG(...)))`)
2. Aerospace intercepts the hotkey and runs the bound command
3. For shift variants: user holds WM thumb + shift pinky + taps key
4. ZMK sends `Ctrl+Alt+Cmd+Shift+<keycode>`, Aerospace runs the shifted command

**How the SCR layer works:**
1. User holds LH0 (WM layer active)
2. User holds RH1 (SCR layer activates via conditional layer or hold-tap)
3. SCR layer keys send `Ctrl+Alt+Cmd+F1` through `F6`
4. Aerospace maps these to resize/layout commands

**Keycode for ß position:**
The ß key has no direct HID keycode. On the WM layer, this position sends
substitute keycode `Y` (not used elsewhere in WM bindings). Aerospace config
maps `ctrl-alt-cmd-y` to `workspace 2`.

**Smart WM tap action:**
`smart_wm` tap sends `Ctrl+Alt+Cmd+R` which Aerospace maps to
`workspace-back-and-forth`. Quick workspace toggle without entering the
full WM layer.

## Complete Keycode-to-Command Map

### WM Layer (Ctrl+Alt+Cmd prefix)

| Keycode | Base command                      | Shift command                           |
|---------|-----------------------------------|-----------------------------------------|
| `m`     | `focus-monitor main`              | `move-workspace-to-monitor main`        |
| `l`     | `focus-monitor secondary`         | `move-workspace-to-monitor secondary`   |
| `c`     | `focus-monitor 3`                 | `move-workspace-to-monitor 3`           |
| `t`     | `focus-monitor left`              | `move-node-to-monitor left`             |
| `r`     | `workspace-back-and-forth`        | *(unbound)*                             |
| `d`     | `focus-monitor right`             | `move-node-to-monitor right`            |
| `o`     | `focus up`                        | `move up`                               |
| `n`     | `focus left`                      | `move left`                             |
| `e`     | `focus down`                      | `move down`                             |
| `i`     | `focus right`                     | `move right`                            |
| `q`     | `workspace 1`                     | `move-node-to-workspace 1`              |
| `y`     | `workspace 2` (ß position)       | `move-node-to-workspace 2`              |
| `u`     | `workspace 3`                     | `move-node-to-workspace 3`              |
| `j`     | `workspace 4`                     | `move-node-to-workspace 4`              |
| `b`     | `workspace 5`                     | `move-node-to-workspace 5`              |
| `h`     | `workspace 6`                     | `move-node-to-workspace 6`              |
| `comma` | `workspace 7`                     | `move-node-to-workspace 7`              |
| `period`| `workspace 8`                     | `move-node-to-workspace 8`              |
| `f`     | `close`                           | *(unbound)*                             |
| `a`     | `balance-sizes`                   | *(unbound)*                             |
| `enter` | `fullscreen`                      | *(unbound)*                             |
| `backspace` | `layout floating tiling`      | *(unbound)*                             |

### SCR Layer (Ctrl+Alt+Cmd prefix, F-key keycodes)

| Keycode | Command                           |
|---------|-----------------------------------|
| `f1`    | `layout tiles horizontal vertical`|
| `f2`    | `balance-sizes`                   |
| `f3`    | `flatten-workspace-tree`          |
| `f4`    | `reload-config`                   |
| `f5`    | `resize smart -50`                |
| `f6`    | `resize smart +50`                |

## Verified Aerospace Commands

All commands verified against source at `~/code/flokr/AeroSpace/`:

| Command | Arguments | Description |
|---------|-----------|-------------|
| `focus` | left\|down\|up\|right | Focus window in direction |
| `move` | left\|down\|up\|right | Move window in direction |
| `focus-monitor` | left\|right\|up\|down\|next\|prev\|&lt;pattern&gt; | Switch monitor |
| `move-node-to-monitor` | left\|right\|up\|down\|next\|prev\|&lt;pattern&gt; | Move window to monitor |
| `move-workspace-to-monitor` | left\|right\|up\|down\|next\|prev\|&lt;pattern&gt; | Move workspace to monitor |
| `workspace` | &lt;name&gt; | Switch to workspace |
| `workspace next` | | Next workspace on monitor |
| `move-node-to-workspace` | &lt;name&gt; | Move window to workspace |
| `fullscreen` | | Toggle fullscreen |
| `workspace-back-and-forth` | | Toggle prev/current workspace |
| `close` | | Close focused window |
| `resize smart` | [+\|-]&lt;n&gt; | Resize window |
| `balance-sizes` | | Equalize window sizes |
| `layout` | tiles\|accordion\|floating\|tiling\|horizontal\|vertical | Toggle layout |
| `layout tiles horizontal vertical` | | Toggle split orientation |
| `flatten-workspace-tree` | | Reset layout tree |
| `reload-config` | | Reload aerospace.toml |

> Monitor `<pattern>`: `main`, `secondary`, 1-based number, or case-insensitive regex.

## Next Steps

1. Configure monitor patterns in aerospace.toml (need actual monitor names)
2. Test and iterate on key assignments
3. Consider assignments for available keys (left bottom row, left outer keys)
