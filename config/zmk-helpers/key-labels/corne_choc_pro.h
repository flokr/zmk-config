/*                                      46 KEY MATRIX / LAYOUT MAPPING

  ╭────────────────────────────────────────────────────────────╮ ╭───────────────────────────────────────────────────────────╮
  │  0   1   2   3   4   5   6 │  7   8   9  10  11  12  13    │ │ LT6 LT5 LT4 LT3 LT2 LT1 LT0 │ RT0 RT1 RT2 RT3 RT4 RT5 RT6 │
  │ 14  15  16  17  18  19  20 │ 21  22  23  24  25  26  27    │ │ LM6 LM5 LM4 LM3 LM2 LM1 LM0 │ RM0 RM1 RM2 RM3 RM4 RM5 RM6 │
  │ 28  29  30  31  32  33     │     34  35  36  37  38  39    │ │ LB6 LB5 LB4 LB3 LB2 LB1     │     RB0 RB1 RB2 RB3 RB4 RB5 │
  ╰───────────────╮ 40  41  42 | 43  44  45 ╭──────────────────╯ ╰───────────────╮ LH2 LH1 LH0 | RH0 RH1 RH2 ╭───────────────╯
                  ╰────────────┴────────────╯                                    ╰─────────────┴─────────────╯              */

#pragma once

// Left hand - top row
#define LT0  6
#define LT1  5
#define LT2  4
#define LT3  3
#define LT4  2
#define LT5  1
#define LT6  0

// Right hand - top row
#define RT0  7
#define RT1  8
#define RT2  9
#define RT3 10
#define RT4 11
#define RT5 12
#define RT6 13

// Left hand - middle row
#define LM0 20
#define LM1 19
#define LM2 18
#define LM3 17
#define LM4 16
#define LM5 15
#define LM6 14

// Right hand - middle row
#define RM0 21
#define RM1 22
#define RM2 23
#define RM3 24
#define RM4 25
#define RM5 26
#define RM6 27

// Left hand - bottom row (no LB0 - that position doesn't exist)
#define LB1 33
#define LB2 32
#define LB3 31
#define LB4 30
#define LB5 29
#define LB6 28

// Right hand - bottom row
#define RB0 34
#define RB1 35
#define RB2 36
#define RB3 37
#define RB4 38
#define RB5 39

// Thumbs
#define LH0 42  // Left thumb keys
#define LH1 41
#define LH2 40

#define RH0 43  // Right thumb keys
#define RH1 44
#define RH2 45

// Key groups for positional hold-tap (HRM helper)
#define KEYS_L LT0 LT1 LT2 LT3 LT4 LT5 LT6 LM0 LM1 LM2 LM3 LM4 LM5 LM6 LB1 LB2 LB3 LB4 LB5 LB6
#define KEYS_R RT0 RT1 RT2 RT3 RT4 RT5 RT6 RM0 RM1 RM2 RM3 RM4 RM5 RM6 RB0 RB1 RB2 RB3 RB4 RB5
#define THUMBS LH0 LH1 LH2 RH0 RH1 RH2
