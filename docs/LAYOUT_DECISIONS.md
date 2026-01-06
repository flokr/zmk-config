# Layout Design Decisions

**Date:** January 3, 2026  
**Keyboard:** Corne Choc Pro (46-key)  
**Base Layout:** MagicSturdy  

## Overview

This document captures all design decisions for the keyboard layout configuration before implementation.

---

## 1. Home Row Mods (HRMs)

### Configuration
- **Timing:** 280ms tapping-term, 175ms quick-tap, 150ms prior-idle
- **Flavor:** Balanced
- **Strategy:** Timeless HRMs (urob's approach)

### Left Hand (STRD)
- **LM5** (S): Shift
- **LM4** (T): Ctrl
- **LM3** (R): Alt
- **LM2** (D): Gui/Cmd

### Right Hand (NEIA)
- **RM2** (N): Gui/Cmd
- **RM3** (E): Alt
- **RM4** (I): Ctrl
- **RM5** (A): Shift

### Rationale
- **Symmetrical design:** Same finger = same modifier on both hands
- **macOS optimized:** Cmd on index fingers (most used modifier on macOS)
- **Follows urob's proven pattern:** Battle-tested by community
- **Ergonomic:** Frequently used modifiers on stronger fingers

---

## 2. Thumb Keys

### Physical Layout Reference
```
Left:  LH2 (outer) | LH1 (center) | LH0 (inner)
Right: RH0 (inner) | RH1 (center) | RH2 (outer)
```

### Base Layer Assignments

**Left Thumb Cluster:**
- **LH2** (outer/40): TBD
- **LH1** (center/41): SPACE (hold: NAV layer)
- **LH0** (inner/42): REPEAT key

**Right Thumb Cluster:**
- **RH0** (inner/43): BSPC/DEL morph (tap: backspace, shift: delete)
- **RH1** (center/44): ENTER (hold: FN layer)
- **RH2** (outer/45): SMART_NUM (tap: num-word, double-tap: sticky NUM, hold: NUM layer)

### Rationale
- **Center positions for most frequent keys:** SPACE and ENTER in most comfortable spots
- **BSPC/DEL morph:** Saves a key, frequently needed together
- **SMART_NUM on outer:** Makes double-tap easier for sticky layer
- **Symmetric layer access:** Space→NAV on left, Enter→FN on right
- **ESC on pinky column:** Quick access without thumb movement

---

## 3. Pinky Columns (Outer Columns)

### Left Outer Column
- **LT6**: ESC ✅
- **LM6**: (TBD - possibly shift or another modifier)
- **LB5**: (TBD)

### Right Outer Column
- **RT6**: (TBD)
- **RM6**: (TBD)
- **RB5**: (TBD)

### Status
⚠️ **TO BE DECIDED:** Exact assignments for outer columns pending

---

## 4. NUM Layer (Right Hand)

### Layout Design
```
╭─────────────────────────────────────────────────────────────╮
│  -    -    7    8    9    */   =   │ RT0-RT6
│  -    0₄   4₃   5₂   6₁   +-   -   │ RM0-RM6 (HRMs: ₄=Gui,₃=Alt,₂=Shift,₁=Ctrl)
│       -    1    2    3    ,.   -   │ RB0-RB5
╰────────────╮ &trans &trans &trans ╭──────────────────────────────────╯
             ╰─────────────────────╯  (BSPC/DEL, ENTER, SMART_NUM)
```

### Key Mappings
**Top Row (RT0-RT6):**
- RT2: 7
- RT3: 8
- RT4: 9
- RT5: multiply_slash (tap: *, shift: /)
- RT6: =

**Home Row (RM0-RM6) with HRMs:**
- RM1: 0 (Gui/Cmd mod)
- RM2: 4 (Alt mod)
- RM3: 5 (Shift mod)
- RM4: 6 (Ctrl mod)
- RM5: plus_minus (tap: +, shift: -)

**Bottom Row (RB0-RB5):**
- RB1: 1
- RB2: 2
- RB3: 3
- RB4: comma_dot (tap: comma, shift: dot)

**Thumb Keys:**
- RH0: &trans (passes through to BSPC/DEL from base)
- RH1: &trans (passes through to ENTER from base)
- RH2: &trans (SMART_NUM trigger)

### Mod-Morphs to Implement
```c
// Tap: * | Shift: /
SIMPLE_MORPH(multiply_slash, SFT, &kp STAR, &kp FSLH)

// Tap: + | Shift: -
SIMPLE_MORPH(plus_minus, SFT, &kp PLUS, &kp MINUS)

// Tap: , | Shift: .
SIMPLE_MORPH(comma_dot, SFT, &kp COMMA, &kp DOT)
```

### Rationale
- **Numpad alignment:** 7-8-9 / 4-5-6 / 1-2-3 / 0 matches traditional numpad
- **HRMs on home row:** Allows shortcuts like Cmd+4 for tab switching
- **0 on index finger:** Most ergonomic position for frequently used zero
- **Mod-morphs save keys:** 3 keys provide 6 operators (*, /, +, -, comma, dot)
- **Transparent thumbs:** ENTER and BSPC work seamlessly while typing numbers
- **Equals accessible:** For calculator-style usage

### Usage Examples
- Type `1,234.56`: `1` + `comma` + `2` + `3` + `4` + `Shift+comma` + `5` + `6`
- Type `10/2`: `1` + `0` + `Shift+*` + `2`
- Type `5-3`: `5` + `Shift++` + `3`
- Type `42` + ENTER: `4` + `2` + `RH1` (ENTER passes through)

---

## 5. NAV Layer (Improved)

### Design Concept
```
LEFT HAND (Modifiers & System):         RIGHT HAND (Navigation):
╭────────────────────────────────────╮  ╭──────────────────────────────────────────╮
│ ESC   -    -     Tab  Sh+Tab  -  - │  │  -    PgUp   Home    UP↑    End   -   - │
│  -    GUI↓ Alt↓ Shift↓ Ctrl↓  -  - │  │  -    PgDn  LEFT→↖  DOWN↓  RIGHT→↗ Enter - │
│  -    BT1  BT2   BT3   BT4  BT5    │  │       Ins   Tab   Bspc⌫  Del⌦    -   - │
╰────────────╮ -  [SPACE/NAV] - ╭────╯  ╰────╮ Enter Bspc  Del ╭─────────────────╯
             ╰─────────────────╯              ╰─────────────────╯

Legend:
↑ = Hold for Ctrl+Home (document start)
↓ = Hold for Ctrl+End (document end)
→↖ = Tap: left, Hold: Home (line start)
→↗ = Tap: right, Hold: End (line end)
⌫ = Hold for Ctrl+Bspc (word delete backward)
⌦ = Hold for Ctrl+Del (word delete forward)
↓ = Sticky modifier
```

### Key Mappings

**LEFT HAND - Modifiers & System Controls:**

**Top Row (LT):**
- LT6: ESC (already on base)
- LT3: Tab
- LT2: Shift+Tab (reverse tab)

**Home Row (LM) - Sticky Modifiers:**
- LM5: Sticky GUI (for Cmd+Arrow, Cmd+Bspc on macOS)
- LM4: Sticky Alt (for Alt+Arrow = word movement on macOS)
- LM3: Sticky Shift (for selecting while moving)
- LM2: Sticky Ctrl

**Bottom Row (LB) - Bluetooth Controls:**
- LB5: BT Profile 1 (bt BT_SEL 0)
- LB4: BT Profile 2 (bt BT_SEL 1)
- LB3: BT Profile 3 (bt BT_SEL 2)
- LB2: BT Profile 4 (bt BT_SEL 3)
- LB1: BT Profile 5 (bt BT_SEL 4)
- LB0: BT Clear (bt BT_CLR)

**Alternative Bottom Row - System Controls:**
- LB4: BT Clear
- LB3: RGB Toggle
- LB2: System Reset
- LB1: Bootloader
- LB0: Studio Unlock

**RIGHT HAND - Navigation:**

**Top Row (RT):**
- RT1: PgUp
- RT2: Home (physical key)
- RT3: NAV_UP (tap: Up, hold: Ctrl+Home - document start)
- RT4: End (physical key)

**Home Row (RM):**
- RM1: PgDn
- RM2: NAV_LEFT (tap: Left, hold: Home - line start)
- RM3: NAV_DOWN (tap: Down, hold: Ctrl+End - document end)
- RM4: NAV_RIGHT (tap: Right, hold: End - line end)
- RM6: Enter

**Bottom Row (RB):**
- RB0: Insert
- RB1: Tab
- RB2: NAV_BSPC (tap: Backspace, hold: Ctrl+Bspc - delete word backward)
- RB3: NAV_DEL (tap: Delete, hold: Ctrl+Del - delete word forward)

**Thumb Keys:**
- All transparent (pass through to base layer)

### Enhanced Navigation Behaviors

**Implementation:**
```c
// Enhanced arrows with hold behaviors
ZMK_HOLD_TAP(mt_home, bindings = <&masked_home>, <&kp>; MT_CORE)
ZMK_HOLD_TAP(mt_end, bindings = <&masked_end>, <&kp>; MT_CORE)

#define NAV_LEFT  &mt_home 0   LEFT    // Tap: ←  | Hold: Home
#define NAV_RIGHT &mt_end 0    RIGHT   // Tap: →  | Hold: End  
#define NAV_UP    &mt LC(HOME) UP      // Tap: ↑  | Hold: Ctrl+Home (doc start)
#define NAV_DOWN  &mt LC(END)  DOWN    // Tap: ↓  | Hold: Ctrl+End (doc end)
#define NAV_BSPC  &mt LC(BSPC) BSPC    // Tap: Bspc | Hold: Ctrl+Bspc (word delete)
#define NAV_DEL   &mt LC(DEL)  DEL     // Tap: Del  | Hold: Ctrl+Del (word delete fwd)

// Mask CTRL on left/right to avoid accidental doc jumps
MASK_MODS(masked_home, (MOD_LCTL), &kp HOME)
MASK_MODS(masked_end,  (MOD_LCTL), &kp END)
```

### Word Movement Strategy

**Using Sticky Modifiers (Recommended):**

**Move by word:**
1. Tap LM4 (Sticky Alt)
2. Tap arrow → Cursor moves by word
3. Example: Alt + Right = word forward

**Delete by word:**
- Hold RB2 (Backspace position) → Deletes word backward
- Hold RB3 (Delete position) → Deletes word forward

**Select while moving:**
1. Tap LM3 (Sticky Shift)
2. Use arrows → Selects text
3. Combine: Shift + Alt + Arrow = select by word

**Jump to document start/end:**
- Hold RT3 (Up) → Jump to document start
- Hold RM3 (Down) → Jump to document end

### Rationale
- **Sticky mods on left home row:** Most flexible, works for all combinations
- **Enhanced arrows:** Double-duty keys save positions
- **Word deletion integrated:** Natural positions (same as Bspc/Del)
- **Bluetooth controls grouped:** Easy profile switching
- **PgUp/Dn around arrows:** Logical positioning
- **Two-handed operation:** Left hand mods, right hand navigation

---

## 6. FN/Media Layer

### Access
- **Activation:** Hold ENTER (RH1)

### Status
⚠️ **TO BE DESIGNED:** Full layer layout pending

### Planned Features
- Function keys (F1-F12)
- Media controls (play/pause, volume, etc.)
- Desktop/window management (macOS spaces)
- System controls

---

## 7. Behaviors to Implement

### SMART_NUM (Auto-layer)
```c
// Tap: num-word | double-tap: sticky num-layer | Hold: num-layer
ZMK_HOLD_TAP(smart_num, bindings = <&mo>, <&num_dance>; 
             flavor = "balanced";
             tapping-term-ms = <200>; 
             quick-tap-ms = <QUICK_TAP_MS>;)
ZMK_TAP_DANCE(num_dance, bindings = <&num_word NUM>, <&sl NUM>;
              tapping-term-ms = <200>;)
```

### BSPC/DEL Mod-Morph
```c
ZMK_MOD_MORPH(bspc_del, bindings = <&kp BSPC>, <&kp DEL>;
              mods = <(MOD_LSFT|MOD_RSFT)>;)
```

### Base Layer Punctuation Mod-Morphs
```c
// Tap: comma | Shift: semicolon (on base layer)
SIMPLE_MORPH(comma_semi, SFT, &kp COMMA, &kp SEMI)

// Tap: dot | Shift: colon (on base layer)
SIMPLE_MORPH(dot_colon, SFT, &kp DOT, &kp COLON)
```

### LT_SPC (Smart Space)
```c
// Tap: space | Hold: NAV layer
ZMK_HOLD_TAP(lt_spc, bindings = <&mo>, <&kp>; 
             flavor = "balanced";
             tapping-term-ms = <200>; 
             quick-tap-ms = <QUICK_TAP_MS>;)
```

### LT_ENT (Smart Enter)
```c
// Tap: enter | Hold: FN layer
ZMK_HOLD_TAP(lt_ent, bindings = <&mo>, <&kp>; 
             flavor = "balanced";
             tapping-term-ms = <200>; 
             quick-tap-ms = <QUICK_TAP_MS>;)
```

---

## 8. Combos

### Strategy
- **Left hand:** Editing operations (cut, copy, paste, undo, redo)
- **Right hand:** Code symbols (brackets, operators)
- **Cross-hand:** Rare, only when needed

### Left Hand Combos (Editing)

```
╭──────────────────────────────────────────────────────────╮
│  ESC   @LT5  LT4   LT3   LT2   LT1   LT0  │
│  LM6   LM5   LM4  undoLM3redoLM2   LM1   LM0  │
│  LB5   LB4  copyLB3 cutLB2pasteLB1   LB0        │
╰────────╮ LH2   LH1   LH0  ╭─────────────────╯
         ╰──────────────────╯
```

**Combo Definitions:**
```c
// Editing operations
ZMK_COMBO(copy,   &kp LG(C),      LB4 LB3,  DEF NAV NUM, ...) // Copy
ZMK_COMBO(cut,    &kp LG(X),      LB4 LB2,  DEF NAV NUM, ...) // Cut
ZMK_COMBO(paste,  &kp LG(V),      LB3 LB2,  DEF NAV NUM, ...) // Paste
ZMK_COMBO(undo,   &kp LG(Z),      LM3 LM2,  DEF NAV NUM, ...) // Undo
ZMK_COMBO(redo,   &kp LG(LS(Z)),  LM2 LM1,  DEF NAV NUM, ...) // Redo

// Symbols on left
ZMK_COMBO(at,     &kp AT,         LT5 LT4,  DEF NAV NUM, ...) // @
```

### Right Hand Combos (Symbols)

```
╭──────────────────────────────────────────────────────────╮
│  RT0   RT1  /RT2| #RT3& RT4   RT5   RT6  │
│              \│ * │ ^ │                    │
│  RM0   RM1  (RM2) <RM3> -RM4_ +RM5=  RM6  │
│              │     │     │     │            │
│         RB0  [RB1] {RB2} 'RB3" RB4   RB5  │
╰────────────╮ RH0   RH1   RH2  ╭────────────╯
             ╰──────────────────╯
```

**Combo Definitions:**
```c
// Parentheses/Angle brackets (mod-morph)
SIMPLE_MORPH(lpar_lt, SFT, &kp LPAR, &kp LT)
SIMPLE_MORPH(rpar_gt, SFT, &kp RPAR, &kp GT)
ZMK_COMBO(lpar, &lpar_lt,   RM1 RM2,  DEF NAV NUM, ...) // ( → Shift: <
ZMK_COMBO(rpar, &rpar_gt,   RM2 RM3,  DEF NAV NUM, ...) // ) → Shift: >

// Brackets/Braces (mod-morph)
SIMPLE_MORPH(lbkt_lbrc, SFT, &kp LBKT, &kp LBRC)
SIMPLE_MORPH(rbkt_rbrc, SFT, &kp RBKT, &kp RBRC)
ZMK_COMBO(lbkt, &lbkt_lbrc, RB0 RB1,  DEF NAV NUM, ...) // [ → Shift: {
ZMK_COMBO(rbkt, &rbkt_rbrc, RB1 RB2,  DEF NAV NUM, ...) // ] → Shift: }

// Quotes (mod-morph)
SIMPLE_MORPH(sqt_dqt, SFT, &kp SQT, &kp DQT)
ZMK_COMBO(quote, &sqt_dqt,  RB2 RB3,  DEF NAV NUM, ...) // ' → Shift: "

// Minus/Underscore, Plus/Equals (mod-morph)
SIMPLE_MORPH(minus_under, SFT, &kp MINUS, &kp UNDER)
SIMPLE_MORPH(plus_equal, SFT, &kp PLUS, &kp EQUAL)
ZMK_COMBO(minus, &minus_under, RM3 RM4,  DEF NAV NUM, ...) // - → Shift: _
ZMK_COMBO(plus, &plus_equal,  RM4 RM5,  DEF NAV NUM, ...) // + → Shift: =

// Vertical combos (standalone symbols)
ZMK_COMBO(pipe,  &kp PIPE,      RT2 RM2,  DEF NAV NUM, ...) // |
ZMK_COMBO(hash,  &kp HASH,      RT3 RM3,  DEF NAV NUM, ...) // #
ZMK_COMBO(amp,   &kp AMPS,      RT4 RM4,  DEF NAV NUM, ...) // & (alternative position)

// Top row combos (optional)
SIMPLE_MORPH(fslh_bslh, SFT, &kp FSLH, &kp BSLH)
SIMPLE_MORPH(astrk_caret, SFT, &kp ASTRK, &kp CARET)
ZMK_COMBO(slash, &fslh_bslh,    RT1 RT2,  DEF NAV NUM, ...) // / → Shift: \
ZMK_COMBO(star,  &astrk_caret,  RT2 RT3,  DEF NAV NUM, ...) // * → Shift: ^
```

### Base Layer Changes
**Comma and Dot with Mod-Morphs:**
- Comma position on base layer → `&comma_semi` (tap: comma, shift: semicolon)
- Dot position on base layer → `&dot_colon` (tap: dot, shift: colon)
- **Benefit:** Frees up RB5 for other uses, keeps punctuation easily accessible

### Symbol Coverage
**Available via combos:**
- Brackets: `( ) [ ] { } < >`
- Quotes: `' "`
- Math: `- _ + = / \ * ^`
- Special: `| # & @`
- Punctuation: `, ; . :` (on base layer with mod-morphs)

**RB5 Status:** ✅ **FREE** (semicolon and colon moved to mod-morphs)

---

## 9. Advanced Features (Future Consideration)

### Combos
- Cut/Copy/Paste on left bottom row
- Esc on top row combo
- Backspace/Delete on right top row combo
- Brackets/Parens on right side combos

### Leader Key Sequences
- Special characters (arrows, emoji)
- International characters (if needed)

### Magic Shift
- Tap after alpha → Repeat last key
- Tap after non-alpha → Sticky shift
- Shift+tap → Caps word
- Hold → Shift

---

## 9. Open Questions

### 1. LH2 (Outer Thumb Left)
**Question:** What should LH2 (outer left thumb) be assigned to?

**Options:**
- Tab (for quick navigation)
- GUI/Cmd (for Mac shortcuts)
- Layer toggle/lock
- Escape (alternative position)
- Media control (play/pause)

**Priority:** Medium

### 2. FN/Media Layer Design
**Question:** Full layout for function and media layer?

**Needs:**
- F1-F12 key placement
- Media controls (play, pause, volume, brightness)
- Desktop management shortcuts (macOS spaces)
- Other system functions

**Priority:** HIGH - Last major decision needed

### 3. Remaining Outer Pinky Columns
**Question:** What should be assigned to outer pinky columns?

**Positions:**
- LM6, LB5 (left middle/bottom outer)
- RT6, RM6, RB5 (right outer column)

**Options:**
- Additional symbols
- Extra modifiers
- Layer toggles
- Leave transparent/unused
- Media controls

**Priority:** Low

### 4. System Controls Location
**Question:** Should system controls (RGB, Reset, Bootloader, Studio Unlock) be:
- On NAV layer bottom left (with BT controls)?
- On separate SYS layer?
- Distributed across layers?

**Current proposal:** Bottom left of NAV layer (LB row)

**Priority:** Low (can use current NAV layer proposal)

### 5. Repeat Key Behavior
**Question:** Should repeat key have any special behaviors?

**Options:**
- Simple repeat (QMK-style)
- Alternate repeat (urob-style, for magic key integration)
- Context-aware repeat

**Priority:** Low (simple repeat is fine to start)

---

## 10. Implementation Checklist

### Phase 1: Core Functionality (Ready to Implement)
- [ ] Update HRM definitions with correct symmetry (STRD left, NEIA right)
- [ ] Add base layer punctuation mod-morphs (comma_semi, dot_colon)
- [ ] Add BSPC/DEL mod-morph for thumb key
- [ ] Add LT_SPC (space with NAV hold)
- [ ] Add LT_ENT (enter with FN hold)
- [ ] Add SMART_NUM behavior and num_word support
- [ ] Create NUM layer with mod-morphs (multiply_slash, plus_minus, comma_dot)
- [ ] Add repeat key behavior

### Phase 2: Advanced Navigation (Ready to Implement)
- [ ] Implement NAV layer with sticky modifiers
- [ ] Add enhanced arrow behaviors (NAV_LEFT, NAV_RIGHT, NAV_UP, NAV_DOWN)
- [ ] Add enhanced delete behaviors (NAV_BSPC, NAV_DEL)
- [ ] Add masked home/end behaviors
- [ ] Configure Bluetooth controls on NAV layer

### Phase 3: Combos (Ready to Implement)
- [ ] Left hand editing combos (cut, copy, paste, undo, redo, @)
- [ ] Right hand symbol combos with mod-morphs
  - [ ] Parentheses/angle brackets (lpar_lt, rpar_gt)
  - [ ] Brackets/braces (lbkt_lbrc, rbkt_rbrc)
  - [ ] Quotes (sqt_dqt)
  - [ ] Minus/underscore, equals/plus
  - [ ] Slash/backslash, asterisk/caret
  - [ ] Vertical combos (pipe, hash, ampersand)

### Phase 4: Additional Layers (Pending Design)
- [ ] Design and implement FN/Media layer ⚠️ HIGH PRIORITY
- [ ] Assign LH2 (outer thumb left)
- [ ] Assign remaining outer pinky columns (optional)

### Phase 5: Testing & Refinement
- [ ] Test all HRMs for timing and accuracy
- [ ] Test all combos for timing and conflicts
- [ ] Test num-word behavior and NUM layer
- [ ] Test NAV layer navigation and word movement
- [ ] Test enhanced arrow behaviors
- [ ] Adjust timing parameters if needed
- [ ] Fine-tune combo positions if needed

---

## References

- **urob's ZMK config:** https://github.com/urob/zmk-config
- **getreuer's QMK keymap:** https://github.com/getreuer/qmk-keymap
- **ZMK auto-layer module:** https://github.com/urob/zmk-auto-layer
- **Key label reference:** `config/zmk-helpers/key-labels/corne_choc_pro.h`
