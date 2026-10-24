-- ──────────────────────────────────────────────────────────────
--  hyprbars.lua — HUD-style window title bars
--
--  Location:  ~/.config/hypr/hyprbars.lua
--  Load it:   require("hyprbars")   (in hyprland.lua)
--
--  Look:  a cream "title bar" with small dark monospace text on the
--  left, and small square controls on the right — like the panel
--  headers in the inspiration image (//SUBSYSTEM/EFFICIENCY UNIT ▢ ■).
-- ──────────────────────────────────────────────────────────────

local c = {
  base   = "rgb(1A161C)", -- dark text / icons
  text   = "rgb(FFF0E2)", -- cream bar
  muted  = "rgb(88756A)",
  urgent = "rgb(D00003)", -- the sharp red signal block
  none   = "rgba(00000000)", -- fully transparent
}

-- The plugin is loaded by hyprpm *after* the config is first read.
-- This guard skips the setup until the plugin exists, instead of
-- throwing an error on that first pass.
if not (hl.plugin and hl.plugin.hyprbars) then
  return
end

hl.config({
  plugin = {
    hyprbars = {
      enabled = true,

      -- the bar
      bar_height = 19,
      bar_color = c.text,
      bar_blur = false,
      bar_padding = 8,          -- space between the bar's edge and its content
      bar_part_of_window = true, -- your borders wrap around bar + window, like a HUD panel
      bar_precedence_over_border = false,

      -- the title
      bar_title_enabled = true,
      bar_text_font = "JetBrainsMono Nerd Font Mono bold", -- put your font's exact name here (kitty +list-fonts)
      bar_text_size = 11,
      bar_text_weight = "bold",
      bar_text_align = "left",
      col = { text = c.base },

      -- the buttons
      bar_buttons_alignment = "right",
      bar_button_padding = 6,

      -- double-click the bar: maximize / restore
      on_double_click = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
    },
  },
})

-- ── Buttons ───────────────────────────────────────────────────
-- hyprbars draws round buttons. To get the image's SQUARE controls,
-- the button background is made transparent and the square is drawn
-- by the icon glyph itself (■ ▣ □ are standard Unicode shapes).
-- If the order comes out reversed, swap the blocks below.

-- close: the red block (destructive action = red signal)
hl.plugin.hyprbars.add_button({
  bg_color = c.none,
  fg_color = c.urgent,
  size = 22,
  icon = "■",
  action = [[hyprctl dispatch 'hl.dsp.window.close()']],
})

-- maximize / restore
hl.plugin.hyprbars.add_button({
  bg_color = c.none,
  fg_color = c.base,
  size = 22,
  icon = "▣",
  action = [[hyprctl dispatch 'hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })']],
})

-- toggle floating
-- NOTE: check this dispatcher's exact Lua name on the wiki's
-- Dispatchers page; close and fullscreen above are taken from the
-- hyprbars README, this one is not.
hl.plugin.hyprbars.add_button({
  bg_color = c.none,
  fg_color = c.base,
  size = 22,
  icon = "□",
  action = [[hyprctl dispatch 'hl.dsp.window.float({ action = "toggle" })' && hyprctl dispatch 'hl.dsp.window.resize({ x = 800, y = 600 })' && hyprctl dispatch 'hl.dsp.window.center()']],
})
