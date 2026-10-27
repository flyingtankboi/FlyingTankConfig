pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    // Returns a color with a different opacity (0.0 – 1.0)
    function alpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a);
    }

    // ── Colors ────────────────────────────────────────────────
    readonly property QtObject colors: QtObject {
        // Palette (raw values)
        readonly property color base:     "#1A161C"  // background
        readonly property color baseHi:   "#241E22"  // quiet panels, hover
        readonly property color surface:  "#3F3532"  // raised surfaces
        readonly property color overlay:  "#534D4F"  // borders, inactive
        readonly property color muted:    "#88756A"  // dim text, hairlines
        readonly property color subtle:   "#DDD1C4"  // secondary text
        readonly property color text:     "#FFF0E2"  // main text, title bars
        readonly property color white:    "#FFF8F2"  // brightest
        readonly property color peach:    "#FEAF72"  // frames, focus
        readonly property color peachHi:  "#FFCBA3"  // brighter peach
        readonly property color peachDk:  "#BE8355"  // dark peach (placeholder)
        readonly property color burgundy: "#6F2119"  // deep accent
        readonly property color urgent:   "#D00003"  // the sharp red signal
        readonly property color error:    "#E5483E"  // readable red for text
        readonly property color sage:     "#9AA36B"
        readonly property color steel:    "#7E97A6"
        readonly property color plum:     "#B07A8C"
        readonly property color teal:     "#7FA39A"

        // Roles (what things ARE, mapped to palette values).
        // Prefer these in modules: restyling = changing one line here.
        readonly property color barBg:       base
        readonly property color barBorder:   peachDk
        readonly property color fg:          text
        readonly property color fgDim:       muted
        readonly property color fgSoft:      subtle
        readonly property color accent:      peach
        readonly property color signal:      urgent    // active workspace, alerts
        readonly property color titleBg:     text      // cream HUD title bars
        readonly property color titleFg:     base
        readonly property color trackBg:     surface   // empty part of bars/meters
        readonly property color fill:        text      // filled part of meters
        readonly property color hover:       baseHi
        readonly property color warning:     peach
        readonly property color good:        sage
    }

    // ── Fonts ─────────────────────────────────────────────────
    readonly property QtObject fonts: QtObject {
        readonly property string family: "JetBrainsMono Nerd Font"       // UI text
        readonly property string mono:   "JetBrainsMono Nerd Font Mono"  // icons, fixed-width

        // Pixel sizes
        readonly property int xs:    9    // tiny labels, units
        readonly property int sm:    11   // secondary readouts
        readonly property int md:    13   // default bar text
        readonly property int lg:    16   // emphasis
        readonly property int xl:    22   // popup titles
        readonly property int clock: 19   // the clock in the top tab

        // HUD lettering: slight tracking reads more "technical"
        readonly property real tracking: 1.0
    }

    // ── Sizes ─────────────────────────────────────────────────
    readonly property QtObject size: QtObject {
        // Frame
        readonly property int barHeight:  30   // top bar
        readonly property int stripWidth: 30   // left column
        readonly property int border:     1    // hairlines
        readonly property int borderThick: 2   // frames, outlines
        readonly property int radius:     0    // square everywhere

        // Clock tab (hangs below the bar)
        readonly property int tabWidth:  140
        readonly property int tabDepth:  10    // how far it hangs below the bar
        readonly property int tabSlant:  14    // horizontal size of the angled sides

        // Icons
        readonly property int icon:      16
        readonly property int iconSmall: 12

        // Workspaces
        readonly property int wsWidth:  18
        readonly property int wsHeight: 12
        readonly property int wsSlant:  5
        readonly property int wsDot:    4

        // Segment meter (battery cells)
        readonly property int cellWidth:  6
        readonly property int cellHeight: 12
        readonly property int cellGap:    2
        readonly property int cellCount:  10

        // Thin bars (volume, brightness) in the left strip
        readonly property int thinBar:         4    // resting width
        readonly property int thinBarExpanded: 12   // width on hover
        readonly property int thinBarLength:   80

        // Graph (sparkline in the bar)
        readonly property int graphWidth:  64
        readonly property int graphHeight: 16

        // Small square signal block
        readonly property int signalBlock: 8
    }

    // ── Spacing ───────────────────────────────────────────────
    readonly property QtObject space: QtObject {
        readonly property int xxs: 2
        readonly property int xs:  4
        readonly property int sm:  6
        readonly property int md:  10
        readonly property int lg:  16
        readonly property int xl:  24

        readonly property int barPadding: 10   // inner horizontal padding of the top bar
    }

    // ── Animation timings (ms) ────────────────────────────────
    readonly property QtObject anim: QtObject {
        readonly property int fast:   120   // hover, color changes
        readonly property int normal: 200   // expand/collapse
        readonly property int slow:   400   // popups appearing
        readonly property int blink:  600   // charging cell blink interval
    }

    // ── Thresholds (when things become signals) ───────────────
    readonly property QtObject limits: QtObject {
        readonly property int batteryLow:      20   // %: last cell turns red
        readonly property int batteryCritical: 10
        readonly property int chargeLimit:     80   // % — your asusctl limit (cells above are dimmed)
        readonly property int tempWarn:        80   // °C: graph turns peach
        readonly property int tempCritical:    90   // °C: graph turns red
    }
}
