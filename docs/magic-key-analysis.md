# Magic Key Analysis — MagicSturdy Layout

Analysis performed using oxeylyzer (modified to support magic/adaptive keys).
Scoring uses oxeylyzer's weighted composite of SFBs, finger speed, rolls, alternates, redirects, etc.

## Layout Reference

### Current MagicSturdy
```
v m l c p   q * o u j       (* = magic key, position 6, Right Index top)
s t r d y   f n e i a       (home row)
z k x g w   b h , . ;       (bottom row)

Fingers:
LP LR LM LI LI   RI RI RM RR RP
```

### Best Variant: ms_ea_fy (E↔A + F↔Y swap)
```
v m l c p   q * o u j
s t r d f   y n a i e       (E↔A swapped, F↔Y swapped)
z k x g w   b h , . ;

Fingers:
LP LR LM LI LI   RI RI RM RR RP
```

Home row mods: S=Shift T=Ctrl R=Alt D=Gui | N=Gui E=Alt I=Ctrl A=Shift

Note: OS layout is German QWERTZ, so ZMK `KC_Z` outputs Y and `KC_Y` outputs Z.
The layout above shows **actual character output**.

## Scoring Summary (W = 60% English + 40% German)

| # | Configuration                    | EN    | DE    | W(60/40)  |
|---|----------------------------------|-------|-------|-----------|
| 1 | **ms_ea_fy + optimized 21 rules**| 0.454 | 0.454 | **0.454** |
| 2 | ms_ea_fy + old eafy-opt 20 rules | 0.438 | 0.435 | 0.437     |
| 3 | ms_ea_fy + adapted 21 rules      | 0.445 | 0.413 | 0.432     |
| 4 | ms_ea_fy + old 21 rules          | 0.423 | 0.412 | 0.419     |
| 5 | MagicSturdy + ms-opt 21 rules    | 0.440 | 0.368 | 0.411     |
| 6 | ms_ea_fb + 21 rules              | 0.432 | 0.365 | 0.405     |
| 7 | ms_ea_fy (no magic)              | 0.417 | 0.371 | 0.399     |
| 8 | Sturdy (original)                | 0.454 | 0.266 | 0.379     |
| 9 | MagicSturdy + 8 rules (current)  | 0.422 | 0.308 | 0.376     |
| 10| MagicSturdy (no magic)           | 0.402 | 0.308 | 0.364     |

Higher is better. **ms_ea_fy with fully optimized rules is the clear winner:**
- Beats current MagicSturdy+8 by **+0.078 (+20.7%)**
- Beats original Sturdy by **+0.075 (+19.8%)**
- Beats previous eafy-opt 20 by **+0.017** (output swaps + u→i re-add + j→e addition)
- Total magic benefit: +0.055 over no-magic baseline

**Key insight**: Rules must be re-optimized when the layout changes. The E↔A and
F↔Y swaps change which keys share fingers, making some old rules harmful and
enabling new beneficial ones.

## Head-to-Head: MagicSturdy vs ms_ea_fy (Each With Optimized Rules)

The definitive comparison — each layout paired with its own optimized rule set:

### Score Matrix (2 layouts × 2 rule sets × 2 languages)

| Layout | Rules | EN | DE | Weighted (60/40) |
|---|---|---|---|---|
| **ms_ea_fy** | **optimized 21** (matched) | **0.454** | **0.454** | **0.454** |
| ms_ea_fy | ms-opt 21 (mismatched) | 0.423 | 0.412 | 0.419 |
| **MagicSturdy** | **ms-opt 21** (matched) | 0.440 | 0.368 | 0.411 |
| MagicSturdy | eafy-opt 21 (mismatched) | 0.421 | 0.360 | 0.397 |

### Direct Comparison (matched rules only)

| Language | MagicSturdy + ms-opt 21 | ms_ea_fy + optimized 21 | Delta | Winner |
|---|---|---|---|---|
| **English** | 0.440 | **0.454** | +0.014 | ms_ea_fy |
| **German** | 0.368 | **0.454** | +0.086 | ms_ea_fy (dominant) |
| **Weighted (60/40)** | 0.411 | **0.454** | **+0.043** | **ms_ea_fy** |

### Per-Metric English Comparison (matched rules)

| Metric | MagicSturdy + ms-opt | ms_ea_fy + eafy-opt | Winner |
|---|---|---|---|
| SFB | 1.093% | **0.943%** | ms_ea_fy |
| DSFB | 4.555% | **4.044%** | ms_ea_fy |
| Finger Speed | -1.704 | **-1.568** | ms_ea_fy |
| Stretches | **-16.385%** | -14.679% | MagicSturdy |
| Scissors | **0.355%** | 0.521% | MagicSturdy |
| Lsbs | **2.924%** | 2.418% | ms_ea_fy |
| Pinky Ring | **1.222%** | 1.276% | MagicSturdy |
| Inrolls | 19.778% | **20.733%** | ms_ea_fy |
| Outrolls | **24.500%** | 22.139% | MagicSturdy |
| Total Rolls | **44.278%** | 42.872% | MagicSturdy |
| Alternates | 26.557% | **28.805%** | ms_ea_fy |
| Bad SFBs | 1.777% | **1.252%** | ms_ea_fy |
| SFT | 0.050% | **0.048%** | ~tied |

### Analysis

1. **ms_ea_fy wins the weighted comparison by +0.043** — a decisive margin
2. English is also won by ms_ea_fy (+0.014) after rule re-optimization — the
   old rules left significant English performance on the table
3. German is where ms_ea_fy dominates (+0.086) — more balanced vowel
   distribution across fingers dramatically reduces SFBs in German text
4. Using mismatched rules costs ~0.014–0.034 weighted, confirming rules
   must always be tailored to the specific layout
5. **Verdict: ms_ea_fy is clearly the better choice for any EN/DE mix**

## Layout Swap Variants Tested

- **ms_ea_only**: E and A swapped (A to RM home, E to RP home)
- **ms_ea_fb**: E/A swap + F and B swapped
- **ms_ea_fy**: E/A swap + F and Y swapped (**winner**)
- **ms_magic_rp**: magic key moved to Right Pinky (position 9)
- **ms_magic_lp**: magic key moved to Left Pinky (position 0)

## Key Findings

### 1. Magic Key Position

Right Index (position 6, current) is definitively the best position.

| Position | W(60/40) with 21 rules |
|----------|------------------------|
| **RI (pos 6)** | **0.411** |
| RP (pos 9) | 0.396 |
| LP (pos 0) | 0.360 |

Moving magic to RP is catastrophic when E/A swap is active — `[magic, e]` creates
massive RP SFBs when both are on the same finger.

### 2. Magic Key Rules — More Is Better

Going from 8 to 21 rules tripled the improvement over no-magic:

| Rules | W(60/40) | Delta vs no-magic |
|-------|----------|-------------------|
| 0     | 0.364    | baseline          |
| 8     | 0.376    | +0.012            |
| 21    | 0.411    | +0.047            |

The model is "optimistic": it assumes the user always uses the magic key when
it would be beneficial. More rules = more opportunities to avoid SFBs.

**Critical constraint**: Context chars on the same finger as the magic key
(q, f, n, b, h — all RI for current layout; q, y, n, b, h for ms_ea_fy)
must be AVOIDED as rule contexts, since pressing magic after them creates
an SFB with the magic key itself.

### 3. Layout Swaps

**E/A + F/Y is the best swap combination** at 60/40 weighting:
- Costs -0.017 English (0.440 -> 0.423)
- Gains +0.044 German (0.368 -> 0.412)
- Net: +0.008 weighted

The F/B swap is strictly worse than F/Y — it hurts English without helping German.
The E/A-only swap is decent but F/Y adds significant German benefit.

Whether to swap depends on language priority:
- **Any EN/DE mix**: ms_ea_fy is clearly better (wins both EN and DE with optimized rules)
- **Pure English**: ms_ea_fy still wins with optimized rules (0.454 vs 0.440)

### 4. Re-optimizing Rules for ms_ea_fy (Major Finding)

When the layout changes (E↔A, F↔Y), the SFB landscape shifts:
- **E and A swap fingers** → `e→o` (RM SFB fix) becomes irrelevant; `a→b` (RM→RI redistribution) becomes needed
- **F moves to LI, Y moves to RI** → `y→d` creates SFBs with magic (Y is now RI!); `f→g` becomes available (F is now LI)
- **`u→i` was actively harmful on the old base** — removing it improved EN score;
  however re-testing on the optimized base showed it's +0.001, so it was re-added
- **`q→u` violates the RI avoid list** — Q is RI, creates SFB with magic key

The full optimization journey:
1. Initial re-optimization: 0.419 → 0.437 (+0.018) — new triggers/outputs for ms_ea_fy
2. Output swap optimization: 0.437 → 0.451 (+0.014) — 4 output swaps + removal of u→i
3. j→e addition: 0.451 → 0.453 (+0.002) — second-round candidate search
4. u→i re-add: 0.453 → 0.454 (+0.001) — re-tested on optimized base, now positive
5. **Total improvement: 0.419 → 0.454 (+0.035, +8.4%)**

This is the single biggest score improvement found in the entire analysis.
Rule re-optimization is non-optional when the layout changes.

### 5. Original Sturdy Comparison

MagicSturdy's German performance is dramatically better than original Sturdy:

| Metric          | Sturdy (DE) | MS+21 (DE) | Change      |
|-----------------|-------------|------------|-------------|
| SFB             | 2.371%      | 1.025%     | -57% (!!!)  |
| Finger Speed    | -3.080      | -1.724     | -44%        |
| Bad SFBs        | 3.222%      | 2.098%     | -35%        |
| SFT             | 0.187%      | 0.037%     | -80%        |
| Pinky Ring      | 5.395%      | 1.623%     | -70%        |

English is slightly worse (0.454 -> 0.440) but the German gains are massive.

## Optimized Magic Key Rules for ms_ea_fy

The ms_ea_fy layout changes the finger assignments: F moves to LI (pos 14),
Y moves to RI (pos 15), E moves to RP (pos 19), A moves to RM (pos 17).

**RI avoid list**: q, **y**, n, b, h (y replaces f on RI; f becomes available as context)

### LOO Tier List (Leave-One-Out weighted delta on 21-rule set)

| Rule | LOO ΔW | Tier |
|------|--------|------|
| o→f | +0.020 | ESSENTIAL |
| k→t | +0.012 | ESSENTIAL |
| a→b | +0.011 | ESSENTIAL |
| r→l | +0.010 | ESSENTIAL |
| m→t | +0.007 | VALUABLE |
| s→v | +0.006 | VALUABLE |
| t→m | +0.006 | VALUABLE |
| i→u | +0.003 | VALUABLE |
| p→f | +0.003 | VALUABLE |
| j→e | +0.003 | VALUABLE |
| v→s | +0.002 | NICE-TO-HAVE |
| l→r | +0.002 | NICE-TO-HAVE |
| d→w | +0.002 | NICE-TO-HAVE |
| f→g | +0.002 | NICE-TO-HAVE |
| z→s | +0.001 | NICE-TO-HAVE |
| e→j | +0.001 | NICE-TO-HAVE |
| u→i | +0.001 | MARGINAL |
| g→w | +0.000 | MARGINAL |
| c→w | +0.000 | MARGINAL |
| w→g | +0.000 | MARGINAL |
| x→l | +0.000 | MARGINAL |

All 21 rules are positive — no harmful rules remain.

### What Changed from MagicSturdy Rules

**Removed** (harmful or irrelevant for ms_ea_fy):
- `y→d` — Y is now RI, creates SFB with magic key
- `e→o` — E/O no longer same finger (E moved to RP)
- `j→a` / `a→j` — J/A no longer same finger (A moved to RM)
- `c→y` — Y is now RI, creates SFB with magic key
- `d→y` — Y is now RI, creates SFB with magic key
- `q→u` — Q is RI, creates SFB with magic key
- `u→i` — was harmful on old rule base; re-tested and re-added in final 21-rule set (+0.001)

**Added** (new SFBs created by the swap):
- `a→b` — AB RM→RI redistribution (A is now RM)
- `j→e` — fixes JE RP SFB (J and E now share RP)
- `e→j` — fixes EJ RP SFB (reverse of j→e)
- `f→g` — fixes FG LI SFB (F is now LI)
- `d→w` — fixes DW LI SFB
- `c→w` — fixes CW LI SFB

**Output swaps** (optimized from initial eafy rules):
- `a→o` → **`a→b`** (+0.004 ΔW) — better frequency redistribution
- `t→k` → **`t→m`** (+0.004 ΔW) — TM LR same-finger SFB fix
- `p→c` → **`p→f`** (+0.003 ΔW) — PF LI same-finger SFB fix
- `s→z` → **`s→v`** (+0.002 ΔW) — SV LP same-finger SFB fix

### Optimal 21-Rule Set (scored 0.454)

```
o→f, k→t, a→b, r→l, m→t, s→v, t→m, i→u, p→f, j→e,
v→s, l→r, d→w, f→g, z→s, e→j, u→i, g→w, c→w, w→g, x→l
```

### Technical Insights

- **`o→f` doesn't fix an OF SFB** — O(RM) and F(LI) are cross-hand in ms_ea_fy.
  Instead it reduces magic→RI SFBs by diluting the magic key's follow-up frequency
  distribution away from RI keys (N, Y, H, B). Removing it causes `✦n` finger
  speed to jump from -1.979 to -7.949. This is a frequency redistribution effect,
  not a direct SFB elimination.
- **oxeylyzer fully models magic key interactions** — the `apply_magic_key_rules()`
  function transfers `same_finger_weighted_bigrams` and `stretch_weighted_bigrams`
  through the magic position, accounting for scissors, stretches, and finger speed.

## Legacy: MagicSturdy 21-Rule Set (for reference)

Sorted by marginal value (leave-one-out weighted delta on 19-rule set):

### Essential (removing costs >= +0.010 weighted)

| Rule | LOO delta | Purpose |
|------|-----------|---------|
| o -> f | +0.045 | Eliminates OF stretch — single highest-value rule |
| r -> l | +0.012 | Fixes rl/lr LM SFB, big DE benefit |
| k -> t | +0.011 | Fixes kt/tk LR SFB — #1 German SFB (0.238%) |

### Valuable (LOO delta >= +0.003)

| Rule | LOO delta | Purpose |
|------|-----------|---------|
| m -> t | +0.007 | Fixes mt/tm LR SFB, solid DE benefit |
| e -> o | +0.004 | Fixes eo/oe RM SFB |
| j -> a | +0.004 | Fixes ja/aj RP SFB |
| d -> y | +0.004 | Fixes dy LI SFB |
| s -> z | +0.003 | Fixes sz/zs LP SFB, DE benefit |
| c -> y | +0.003 | Fixes cy LI SFB |
| i -> u | +0.003 | Reverse: fixes iu RR SFB |
| l -> r | +0.003 | Reverse: fixes lr LM SFB |

### Nice-to-have (LOO delta >= +0.001)

| Rule | LOO delta | Purpose |
|------|-----------|---------|
| t -> k | +0.002 | Fixes tk LR SFB |
| a -> j | +0.002 | Reverse: fixes aj RP SFB |
| z -> s | +0.002 | Reverse: fixes zs LP SFB |
| g -> w | +0.001 | Fixes gw LI SFB |
| y -> d | +0.001 | Reverse: fixes yd LI SFB |
| p -> c | +0.001 | Fixes pc LI SFB |

### Marginal (LOO delta ~ 0, but zero cost to include)

| Rule | LOO delta | Purpose |
|------|-----------|---------|
| u -> i | +0.000 | Redundant with i -> u |
| w -> g | +0.000 | Redundant with g -> w |
| v -> s | — | vs LP SFB |
| x -> l | — | xl LM SFB |

## Magic Key SFB Tradeoff

The magic key eliminates SFBs for rule-covered bigrams but introduces new SFBs
between the magic key (RI) and other RI keys (n, f, h, b, q). With 21 rules
the net effect is strongly positive — the eliminated SFBs far outweigh the
introduced magic-RI SFBs.

## Finger Frequency Loads (ms_ea_fy)

| Finger | Keys | Notes |
|--------|------|-------|
| LP | v, s, z | ~6.9% (lowest) |
| RP | j, e, ; | E on RP (was A) |
| LM | l, r, x | ~9.5% |
| RR | u, i, . | ~10.6% |
| LR | m, t, k | ~11.7% |
| LI | c, p, d, f, g, w | F on LI (was RI) |
| RI | q, *, y, n, b, h | Y on RI (was LI), magic adds load |
| RM | o, a, , | A on RM (was RP) |

## Config (oxeylyzer) — ms_ea_fy Optimized

The optimized 21-rule set for ms_ea_fy in `config.toml`:

```toml
[magic_key]
enabled = true
default_output = "h"

[magic_key.rules]
# Optimized 21-rule set for ms_ea_fy layout (E↔A + F↔Y swap)
# Score: EN=0.454 DE=0.454 W(60/40)=0.454 (no magic: 0.399, +0.055 benefit)
# LOO-verified on 21-rule set: all rules ΔW ≥ 0
#
# Essential (LOO ΔW ≥ 0.010)
o = "f"    # +0.020 — reduces magic→RI SFB pressure (OF cross-hand, not SFB fix)
k = "t"    # +0.012 — KT LR SFB fix, huge DE benefit
a = "b"    # +0.011 — AB RM→RI redistribution
r = "l"    # +0.010 — RL LM SFB fix
# Valuable (LOO ΔW ≥ 0.003)
m = "t"    # +0.007 — MT LR SFB fix
s = "v"    # +0.006 — SV LP SFB fix
t = "m"    # +0.006 — TM LR SFB fix (reverse of m→t)
i = "u"    # +0.003 — IU RR SFB fix
p = "f"    # +0.003 — PF LI SFB fix
j = "e"    # +0.003 — JE RP SFB fix
# Nice-to-have (LOO ΔW ≥ 0.001)
v = "s"    # +0.002 — VS LP SFB fix (reverse of s→v)
l = "r"    # +0.002 — LR LM SFB fix (reverse of r→l)
d = "w"    # +0.002 — DW LI SFB fix
f = "g"    # +0.002 — FG LI SFB fix
z = "s"    # +0.001 — ZS LP SFB fix (reverse of s→v direction)
e = "j"    # +0.001 — EJ RP SFB fix (reverse of j→e)
# Marginal (LOO ΔW ≈ 0, zero cost)
u = "i"    # +0.001 — UI RR SFB fix (reverse of i→u)
g = "w"    # +0.000 — GW LI SFB fix
c = "w"    # +0.000 — CW LI SFB fix
w = "g"    # +0.000 — WG LI reverse
x = "l"    # +0.000 — XL LM SFB fix
```

## Methodology Notes

- oxeylyzer was modified to support magic keys (rules-only frequency transfer model)
- The model redistributes bigram/trigram frequencies: when rule `ctx -> out` fires,
  frequency transfers from `[ctx, out_pos]` to `[ctx, magic_pos]`
- Magic key character frequency = sum of all rule firing frequencies
- The `[magic, Y]` weighted sum distributes magic's "following character" frequencies
  across all rule outputs, weighted by firing frequency
- The model is optimistic — assumes the user always uses magic when beneficial
- Frequency data is global (shared across layouts), so magic must be disabled
  when benchmarking non-magic layouts to avoid penalizing them
- All scores are from oxeylyzer's composite scoring function using the weights
  defined in config.toml
- **Rules must be re-optimized per layout variant** — the E↔A/F↔Y swaps change
  which keys share fingers, invalidating some old rules and enabling new ones

## Future Work

- **Multi-character magic outputs** — word endings like `-ung`, `-ment`, `-tion`, `-sch`
  could provide even greater benefit, especially for German. Requires oxeylyzer
  source changes to model n-gram outputs.
- **Corpus tuning** — build custom corpus from the user's actual typing patterns
  (code, prose, chat) for more personalized scoring.
- **Weight tuning** — the oxeylyzer scoring weights are defaults; personalizing
  them to the user's priorities (e.g., weighting comfort vs speed) could shift results.
- **Other layer analysis** — NUM/NAV/SYM/FUN/SYS/WM layers have not been analyzed.

## Completed Investigations

- **Combo conflict analysis** — verified combos.dtsi has no conflicts with magic
  rules or the E↔A/F↔Y swap. All clear.
- **Magic key position** — RI (pos 6) definitively best; RP and LP much worse.
- **Rule exhaustion** — all viable single-char alphabetic triggers are covered;
  no more single-char improvements possible. Second-round search confirmed only
  `j→e` (+0.003) was viable; `n→b` (+0.001) violates RI avoid list.
- **Cross-layout rule penalty** — quantified at ~0.014–0.034 weighted.
- **Output swap optimization** — exhaustive search of all alternative outputs for
  all existing triggers found 4 beneficial swaps: a→b, t→m, p→f, s→v.
  Combined improvement +0.014, LOO-verified independently positive.
- **Full LOO verification** — all 21 rules verified positive on the final combined
  set (EN=0.454, DE=0.454, W=0.454). No harmful rules remain.
- **u→i re-evaluation** — was harmful on old rule base but positive (+0.001) on the
  optimized base after output swaps. Rule interactions are non-trivial.
