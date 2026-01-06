# RGB Underglow Feedback Module - Implementation Plan

## Hardware Context

**Corne Choc Pro**: 23 WS2812 underglow LEDs per side (not per-key RGB)
- All LEDs show same color simultaneously
- Single shared resource requiring priority system

## ZMK Implementation Research (2026-01-06)

### ✅ Available APIs
From ZMK source code analysis (`zmk/app/src/rgb_underglow.c`):

**Core Functions:**
```c
int zmk_rgb_underglow_set_hsb(struct zmk_led_hsb color);  // Set color (H: 0-360, S: 0-100, B: 0-100)
int zmk_rgb_underglow_toggle(void);                        // On/off
int zmk_rgb_underglow_on(void);
int zmk_rgb_underglow_off(void);
```

**Event System:**
```c
zmk_layer_state_changed        // Fired when layer activated/deactivated
  - uint8_t layer              // Layer ID (0-5 for our config)
  - bool state                 // true = activated, false = deactivated
  
zmk_battery_state_changed      // Fired when battery level changes
  - uint8_t state_of_charge    // Battery percentage (0-100)
```

**Built-in Effects:**
- `UNDERGLOW_EFFECT_SOLID` - Static color (what we'll use)
- `UNDERGLOW_EFFECT_BREATHE` - Pulsing (for battery warning)
- `UNDERGLOW_EFFECT_SPECTRUM` - Rainbow cycle
- `UNDERGLOW_EFFECT_SWIRL` - Rainbow wave

### ❌ Not Available (Would Need Custom Implementation)
- ❌ Modifier status events (Shift/Ctrl/Alt/Gui held)
- ❌ Caps lock status events
- ❌ Built-in layer-to-color mapping
- ❌ Built-in priority system
- ❌ Smooth color transitions/fading

## Implementation Strategy

### Phase 1: Layer Indicators (Custom ZMK Module)
**Goal**: Automatic color change based on active layer

**Implementation**: Create `zmk-config/config/rgb_layer_indicator.c`
```c
// Subscribe to layer_state_changed events
// Map layer ID → HSB color
// Call zmk_rgb_underglow_set_hsb() on change
```

**Layer Color Palette** (Colorblind-friendly):
```c
BASE (0):    Blue      { h: 240, s: 80, b: 40 }  // Calm, neutral
NUM (1):     Green     { h: 120, s: 80, b: 40 }  // Numbers = money = green
NAV (2):     Purple    { h: 280, s: 80, b: 40 }  // Navigation = exploration
FUN (3):     Cyan      { h: 180, s: 80, b: 40 }  // Function keys = utility
SYMBOL (4):  Orange    { h: 30,  s: 80, b: 40 }  // Symbols = caution/attention
SYS (5):     Magenta   { h: 300, s: 80, b: 40 }  // System = special/danger
```

**Files to Create:**
- `config/rgb_layer_indicator.c` - Event listener and color logic
- `config/rgb_layer_indicator.h` - Header file
- Update `config/west.yml` - Add custom module reference

### Phase 2: Battery Warning Override (Priority System)
**Goal**: Show red when battery < 20%, pulsing red when < 10%

**Implementation**: Extend `rgb_layer_indicator.c`
```c
// Subscribe to battery_state_changed events
// Priority logic:
//   - state_of_charge < 10%  → Red pulsing (BREATHE effect)
//   - state_of_charge < 20%  → Red solid
//   - state_of_charge >= 20% → Show layer color (normal)
```

**Battery Colors:**
```c
CRITICAL (<10%):  Red Pulsing  { h: 0, s: 100, b: 60 } + BREATHE effect
LOW (<20%):       Red Solid    { h: 0, s: 100, b: 60 }
NORMAL (>=20%):   Layer color  (from phase 1)
```

### Phase 3: Manual RGB Controls (SYS Layer)
**Goal**: User control for on/off and brightness

**Implementation**: Add to SYS layer keymap
```c
&rgb_ug RGB_TOG    // Toggle on/off
&rgb_ug RGB_BRI    // Brightness up  
&rgb_ug RGB_BRD    // Brightness down
```

Position on SYS layer (accessed via NAV + FUN):
```
Top row positions for quick access
```

## Technical Architecture

### Module Structure
```
rgb_layer_indicator.c
├── State Management
│   ├── current_layer (uint8_t)
│   ├── battery_level (uint8_t)
│   └── is_on (bool)
├── Event Listeners
│   ├── layer_changed_listener()    → Update current_layer, recalculate color
│   └── battery_changed_listener()  → Update battery_level, recalculate color
├── Priority Logic
│   └── calculate_current_color()
│       ├── IF battery < 10%  → Red + BREATHE
│       ├── ELSE IF battery < 20% → Red
│       └── ELSE → layer_colors[current_layer]
└── RGB Update
    └── apply_color(hsb)
```

### Build System Integration
**File**: `config/CMakeLists.txt`
```cmake
target_sources(app PRIVATE rgb_layer_indicator.c)
```

**File**: `build.yaml`
```yaml
# Ensure RGB underglow is enabled in build
```

## Configuration Options (After Initial Implementation)

### Brightness Levels (Configurable)
```c
#define RGB_BRT_ACTIVE  40   // Normal usage brightness
#define RGB_BRT_DIM     15   // Dimmed (idle mode)
#define RGB_BRT_WARNING 60   // Battery warning (more visible)
```

### Color Customization (User Preference)
Users can modify layer colors in `rgb_layer_indicator.c`:
```c
static const struct zmk_led_hsb layer_colors[] = {
    [0] = { .h = 240, .s = 80, .b = 40 },  // BASE - modify values here
    // ...
};
```

## Known Limitations

1. **No Caps Lock Indicator**: ZMK doesn't expose caps lock state to modules
2. **No Modifier Status**: No events fired when Shift/Ctrl/Alt held
3. **No Smooth Transitions**: Color changes are instant, not faded
4. **Effect Switching**: Battery warning BREATHE effect overrides layer color completely
5. **Memory Overhead**: Custom module adds ~2KB to firmware

## Future Enhancements (Post v1.0)

- [ ] Idle dimming (reduce brightness after inactivity)
- [ ] Per-layer brightness levels
- [ ] Configuration via settings/EEPROM (persist user color choices)
- [ ] Layer stack visualization (show multiple active layers somehow?)
- [ ] Animation speed control for BREATHE effect

## Next Steps

1. ✅ Research ZMK implementation feasibility
2. **→ Create rgb_layer_indicator.c module** (Phase 1+2)
3. Add RGB controls to SYS layer keymap (Phase 3)
4. Test on hardware (validate colors, battery thresholds)
5. Iterate on brightness and color values based on usage

---

**Status**: Planning → Implementation Ready  
**Created**: 2026-01-02  
**Updated**: 2026-01-06 (ZMK source analysis)  
**Hardware**: Corne Choc Pro (underglow only)  
**Decision**: Implement Phase 1+2 (Layer Indicators + Battery Warning) as v1.0
