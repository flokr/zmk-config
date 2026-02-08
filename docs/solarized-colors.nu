# Solarized Dark Color Palette
# Organized format for Nushell
# Source: https://ethanschoonover.com/solarized/

# Base colors (background shades - dark to light)
export const base03 = {
    hex: "#002b36"
    rgb: [0, 43, 54]
    hsb: [193, 100, 21]
    lab: [15, -12, -12]
    termcol: "brblack"
    xterm: 234
}

export const base02 = {
    hex: "#073642"
    rgb: [7, 54, 66]
    hsb: [192, 90, 26]
    lab: [20, -12, -12]
    termcol: "black"
    xterm: 235
}

export const base01 = {
    hex: "#586e75"
    rgb: [88, 110, 117]
    hsb: [194, 25, 46]
    lab: [45, -7, -7]
    termcol: "brgreen"
    xterm: 240
}

export const base00 = {
    hex: "#657b83"
    rgb: [101, 123, 131]
    hsb: [195, 23, 51]
    lab: [50, -7, -7]
    termcol: "bryellow"
    xterm: 241
}

export const base0 = {
    hex: "#839496"
    rgb: [131, 148, 150]
    hsb: [186, 13, 59]
    lab: [60, -6, -3]
    termcol: "brblue"
    xterm: 244
}

export const base1 = {
    hex: "#93a1a1"
    rgb: [147, 161, 161]
    hsb: [180, 9, 63]
    lab: [65, -5, -2]
    termcol: "brcyan"
    xterm: 245
}

export const base2 = {
    hex: "#eee8d5"
    rgb: [238, 232, 213]
    hsb: [44, 11, 93]
    lab: [92, 0, 10]
    termcol: "white"
    xterm: 254
}

export const base3 = {
    hex: "#fdf6e3"
    rgb: [253, 246, 227]
    hsb: [44, 10, 99]
    lab: [97, 0, 10]
    termcol: "brwhite"
    xterm: 230
}

# Accent colors
export const yellow = {
    hex: "#b58900"
    rgb: [181, 137, 0]
    hsb: [45, 100, 71]
    lab: [60, 10, 65]
    termcol: "yellow"
    xterm: 136
}

export const orange = {
    hex: "#cb4b16"
    rgb: [203, 75, 22]
    hsb: [18, 89, 80]
    lab: [50, 50, 55]
    termcol: "brred"
    xterm: 166
}

export const red = {
    hex: "#d30102"
    rgb: [211, 1, 2]
    hsb: [0, 99, 83]
    lab: [45, 70, 60]
    termcol: "red"
    xterm: 124
}

export const magenta = {
    hex: "#d33682"
    rgb: [211, 54, 130]
    hsb: [331, 74, 83]
    lab: [50, 65, -5]
    termcol: "magenta"
    xterm: 125
}

export const violet = {
    hex: "#6c71c4"
    rgb: [108, 113, 196]
    hsb: [237, 45, 77]
    lab: [50, 15, -45]
    termcol: "brmagenta"
    xterm: 61
}

export const blue = {
    hex: "#268bd2"
    rgb: [38, 139, 210]
    hsb: [205, 82, 82]
    lab: [55, -10, -45]
    termcol: "blue"
    xterm: 33
}

export const cyan = {
    hex: "#2aa198"
    rgb: [42, 161, 152]
    hsb: [175, 74, 63]
    lab: [60, -35, -5]
    termcol: "cyan"
    xterm: 37
}

export const green = {
    hex: "#859900"
    rgb: [133, 153, 0]
    hsb: [68, 100, 60]
    lab: [60, -20, 65]
    termcol: "green"
    xterm: 64
}

# Convenience accessors
export def get_hex [color: string] {
    match $color {
        "base03" => $base03.hex,
        "base02" => $base02.hex,
        "base01" => $base01.hex,
        "base00" => $base00.hex,
        "base0" => $base0.hex,
        "base1" => $base1.hex,
        "base2" => $base2.hex,
        "base3" => $base3.hex,
        "yellow" => $yellow.hex,
        "orange" => $orange.hex,
        "red" => $red.hex,
        "magenta" => $magenta.hex,
        "violet" => $violet.hex,
        "blue" => $blue.hex,
        "cyan" => $cyan.hex,
        "green" => $green.hex,
        _ => null
    }
}

# List all colors
export def list_colors [] {
    [
        [name type hex rgb]
        ["base03" "background" $base03.hex $base03.rgb]
        ["base02" "background" $base02.hex $base02.rgb]
        ["base01" "content" $base01.hex $base01.rgb]
        ["base00" "content" $base00.hex $base00.rgb]
        ["base0" "content" $base0.hex $base0.rgb]
        ["base1" "content" $base1.hex $base1.rgb]
        ["base2" "background" $base2.hex $base2.rgb]
        ["base3" "background" $base3.hex $base3.rgb]
        ["yellow" "accent" $yellow.hex $yellow.rgb]
        ["orange" "accent" $orange.hex $orange.rgb]
        ["red" "accent" $red.hex $red.rgb]
        ["magenta" "accent" $magenta.hex $magenta.rgb]
        ["violet" "accent" $violet.hex $violet.rgb]
        ["blue" "accent" $blue.hex $blue.rgb]
        ["cyan" "accent" $cyan.hex $cyan.rgb]
        ["green" "accent" $green.hex $green.rgb]
    ]
}

# Solarized Dark theme mapping (recommended usage)
export const dark_theme = {
    background: $base03.hex
    background_highlights: $base02.hex
    secondary_content: $base01.hex
    body_text: $base0.hex
    primary_content: $base1.hex
    emphasized_content: $base2.hex
}

# Solarized Light theme mapping
export const light_theme = {
    background: $base3.hex
    background_highlights: $base2.hex
    secondary_content: $base1.hex
    body_text: $base00.hex
    primary_content: $base01.hex
    emphasized_content: $base02.hex
}
