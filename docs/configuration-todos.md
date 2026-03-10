# Configuration Todo List

Status: Updated 2026-02-08

## Tools Requiring Configuration

### 1. Ghostty Terminal

**Status**: Minimal config exists (`~/.config/ghostty/config`)

**Current config:**
- Font: JetBrainsMono Nerd Font (14pt)
- Shell: Nushell
- Appearance: 95% opacity, hidden titlebar
- Basic mouse/keyboard settings

**Todo:**
- [ ] Add custom keybindings optimized for MagicSturdy layout
  - Split panes (currently using default Cmd+D which is QWERTY-based)
  - Tab management
  - Pane navigation
  - Copy/paste shortcuts
- [ ] Configure color scheme (currently using default)
- [ ] Set up window management integration with Aerospace
- [ ] Consider adding custom keybindings for common operations

**Priority**: High (daily driver terminal)

**Files:**
- Config: `~/.config/ghostty/config`
- Docs: https://ghostty.org/docs

---

### 2. Tmux

**Status**: Config exists but needs updates (`~/code/flokr/dotfiles/tmux/tmux.conf`)

**Current setup:**
- Prefix: Ctrl+A
- Plugins: TPM, sessionx, floax, resurrect, continuum, yank, thumbs, fzf
- Theme: Catppuccin
- sessionx with zoxide integration enabled

**Todo:**
- [ ] Fix hardcoded paths (lines 40, 42): `/Users/omerxx/dotfiles` → `~/code/flokr/dotfiles`
- [ ] Add custom keybindings for MagicSturdy layout
  - Pane navigation (currently using defaults)
  - Pane splits (currently using default % and ")
  - Window management
  - Copy mode navigation
- [ ] Verify config is linked to `~/.config/tmux/tmux.conf`
- [ ] Test sessionx integration (bound to `Ctrl+A o`)
- [ ] Test floax floating terminal (bound to `Ctrl+A p`)
- [ ] Configure color scheme to match terminal theme

**Priority**: High (tmux sessions for development)

**Files:**
- Config: `~/code/flokr/dotfiles/tmux/tmux.conf`
- Reset: `~/code/flokr/dotfiles/tmux/tmux.reset.conf`
- Scripts: `~/code/flokr/dotfiles/tmux/scripts/`

---

### 3. Yazi File Manager

**Status**: Installed (v0.3.3) but no config exists

**Current setup:**
- Yazi installed via Homebrew
- No custom configuration

**Todo:**
- [ ] Create yazi config directory and files
  - `~/.config/yazi/yazi.toml` - Main config
  - `~/.config/yazi/keymap.toml` - Custom keybindings
  - `~/.config/yazi/theme.toml` - Color scheme
- [ ] Configure path copying keybindings
  - Absolute path
  - Relative path
  - Filename only
  - Directory path
- [ ] Set up fzf integration for fuzzy search
- [ ] Configure preview settings (bat, images, etc.)
- [ ] Optimize keybindings for MagicSturdy layout
- [ ] Set up shell integration (cd on exit)

**Priority**: Medium (useful but not critical)

**Files:**
- Config dir: `~/.config/yazi/` (needs creation)
- Docs: https://yazi-rs.github.io/

---

### 4. Sketchybar Notifications

**Status**: Not implemented

**Current setup:**
- Sketchybar installed and configured
- Aerospace workspace indicators working

**Todo:**
- [ ] Create notification polling scripts for:
  - Microsoft Teams (unread count)
  - Microsoft Outlook (unread count)
- [ ] Add Sketchybar items for notification badges
- [ ] Configure refresh intervals
- [ ] Test notification visibility
- [ ] Style notification indicators (colors, icons)

**Priority**: Medium (quality of life improvement)

**Files:**
- Config: `~/.config/sketchybar/items/` (new items needed)
- Scripts: `~/.config/sketchybar/plugins/` (new scripts needed)

---

## Color Scheme Decision

**Status**: Decided - Base16 + Nord

**Current:**
- Using various default themes across tools
- User preference: Cyan/blue dominant themes (like Solarized Dark)
- Existing Nushell color module: `solarized-colors.nu` (can be template for Nord)

**Decision:**
- Use Base16 framework with Nord scheme for universal compatibility
- Ensures Nord works with new tools (Ghostty, Nushell) and established ones
- Existing `solarized-colors.nu` structure can be reused for `nord-colors.nu`

**Base16 Nord Color Values:**
```
base00: #2E3440  (polar night - darkest background)
base01: #3B4252  (polar night)
base02: #434C5E  (polar night)
base03: #4C566A  (polar night - comments)
base04: #D8DEE9  (snow storm)
base05: #E5E9F0  (snow storm - default text)
base06: #ECEFF4  (snow storm)
base07: #8FBCBB  (frost - cyan)
base08: #BF616A  (aurora - red)
base09: #D08770  (aurora - orange)
base0A: #EBCB8B  (aurora - yellow)
base0B: #A3BE8C  (aurora - green)
base0C: #88C0D0  (frost - cyan)
base0D: #81A1C1  (frost - blue)
base0E: #B48EAD  (aurora - purple)
base0F: #5E81AC  (frost - dark blue)
```

**Todo:**
- [ ] Create `nord-colors.nu` based on `solarized-colors.nu` structure
- [ ] Apply Base16 Nord to Ghostty terminal
- [ ] Apply Nord theme to tmux (official Nord tmux port exists)
- [ ] Apply Nord colors to yazi
- [ ] Configure Nushell to use `nord-colors.nu` module
- [ ] Optional: Apply to Neovim if applicable

**Priority**: Medium (enables consistent theming)

**Resources:**
- Base16 Nord: https://github.com/chriskempson/base16-nord-scheme
- Official Nord: https://www.nordtheme.com/docs/colors-and-palettes
- Existing color module: `~/code/flokr/kb/flokr/zmk-config/docs/solarized-colors.nu`

---

## QWERTY Shortcuts Strategy

**Status**: Decided to customize per-app

**Decision:**
- Ghostty: Customize keybindings to match Sturdy layout
- Tmux: Customize keybindings to match Sturdy layout
- Karabiner: Keep as backup for non-customizable apps

**Todo:**
- [ ] Document Sturdy character positions for reference
- [ ] Test app shortcuts after configuration
- [ ] Consider Karabiner setup for system-wide shortcuts if needed

**Priority**: High (affects daily usability)

---

## Summary

**Critical path:**
1. Ghostty keybindings (daily terminal use)
2. Tmux configuration fixes and keybindings (development workflow)
3. Yazi setup for file browsing
4. Sketchybar notifications (nice-to-have)
5. Color scheme unification (polish)

**Estimated effort:**
- Ghostty: 30 minutes
- Tmux: 45 minutes  
- Yazi: 30 minutes
- Sketchybar: 1-2 hours (scripting required)
- Color scheme: 15 minutes per tool

**Next session priorities:**
1. Choose color scheme
2. Configure Ghostty with keybindings + theme
3. Fix and enhance tmux config
4. Set up yazi configuration
