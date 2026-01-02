# RGB Underglow Feedback Module - Options

## Hardware Context

**Corne Choc Pro**: 23 WS2812 underglow LEDs per side (not per-key RGB)
- All LEDs show same color simultaneously
- Single shared resource requiring priority system

## Feedback Types

### 1. Layer Indicators
- **What**: Different color per layer
- **Use case**: Visual reminder of current layer
- **Example**: Base=blue, Nav=purple, Num=green, Sym=orange

### 2. Modifier Status
- **What**: Color changes when shift/ctrl/alt/gui held
- **Use case**: Confirm modifier is active
- **Example**: Shift=yellow, Ctrl=cyan, Alt=magenta, Gui=white

### 3. Caps Lock Indicator
- **What**: Override color when caps lock active
- **Use case**: Prevent accidental ALL CAPS typing
- **Example**: Red when caps lock on

### 4. Battery Level
- **What**: Show battery percentage or low battery warning
- **Use case**: Know when to charge
- **Example**: 
  - Green (>50%), Yellow (20-50%), Orange (<20%), Red pulsing (<10%)
  - Or: Show on special key combo

## Configuration Options

### Option A: Layer-Focused (Simple)
```
Priority:
1. Caps lock override (red when on)
2. Battery warning (orange pulse when <20%)  
3. Layer indicators (baseline color)

Use case: Clear layer awareness, critical warnings only
```

### Option B: Status-Rich (Complex)
```
Priority:
1. Caps lock (red - highest)
2. Modifiers (colors while held)
3. Layer indicators (baseline)
4. Battery check (on key combo)

Use case: Maximum information density
```

### Option C: Minimal (Clean)
```
Priority:
1. Caps lock (red)
2. Battery warning (<20%)
3. Normally off/dim

Use case: Distraction-free, warnings only
```

## Recommended Starting Point

**Layer Indicators + Caps Lock** (v1.0):
- ✅ Most useful day-to-day
- ✅ Simple 2-state priority
- ✅ Easy to implement
- ✅ Extensible (add modifiers/battery later)

## Implementation Notes

- Single shared underglow resource = priority system required
- Only one feedback type visible at a time
- Lower priority indicators hidden when higher priority active
- Smooth transitions between states

## Next Steps

1. Choose configuration option
2. Define layer color palette
3. Implement priority system
4. Add optional features (modifiers, battery) in v1.1

---

**Status**: Planning  
**Created**: 2026-01-02  
**Hardware**: Corne Choc Pro (underglow only)
