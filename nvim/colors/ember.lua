vim.cmd.highlight 'clear'
if vim.fn.exists 'syntax_on' == 1 then
  vim.cmd.syntax 'reset'
end
vim.o.background = 'dark'
vim.g.colors_name = 'ember'

-- ── Palette
local c = {
  base     = '#1A161C', -- background
  base_hi  = '#241E22', -- derived: cursor line, quiet panels
  surface  = '#3F3532', -- raised surfaces (menus, statusline)
  overlay  = '#534D4F', -- borders, line numbers, inactive
  muted    = '#88756A', -- comments, punctuation
  subtle   = '#DDD1C4', -- secondary text
  text     = '#FFF0E2', -- main text
  white    = '#FFF8F2', -- brightest text
  peach    = '#FEAF72', -- frames, keywords, focus
  peach_dk = '#BE8355', -- PLACEHOLDER: replace with your dark peach
  burgundy = '#6F2119', -- selection backgrounds
  urgent   = '#D00003', -- sharp red (blocks, never small text)
  error    = '#E5483E', -- readable red for text
  sage     = '#9AA36B',
  steel    = '#7E97A6',
  plum     = '#B07A8C',
  teal     = '#7FA39A',
  -- bright variants (used for the terminal palette)
  error_br = '#FF6B5E',
  sage_br  = '#B8BF8A',
  steel_br = '#A3B6C0',
  plum_br  = '#C99AAA',
  teal_br  = '#A2C2B9',
}

-- ── Highlight groups ──────────────────────────────────────────
local groups = {
  -- Special UI -----------------------------------------------
  EmberSignal = { fg = c.urgent, bg = c.base },
  -- Editor UI ------------------------------------------------
  Normal       = { fg = c.text, bg = c.base },
  NormalNC     = { fg = c.text, bg = c.base },
  NormalFloat  = { fg = c.text, bg = c.base },
  FloatBorder  = { fg = c.peach_dk, bg = c.base },
  FloatTitle   = { fg = c.base, bg = c.text, bold = true },
  Cursor       = { fg = c.base, bg = c.peach },
  CursorLine   = { bg = c.base_hi },
  CursorColumn = { bg = c.base_hi },
  ColorColumn  = { bg = c.base_hi },
  CursorLineNr = { fg = c.peach_dk, bold = true },
  LineNr       = { fg = c.overlay },
  SignColumn   = { bg = c.base },
  FoldColumn   = { fg = c.overlay, bg = c.base },
  Folded       = { fg = c.muted, bg = c.base_hi, italic = true },
  WinSeparator = { fg = c.overlay },
  EndOfBuffer  = { fg = c.base },
  NonText      = { fg = c.overlay },
  Whitespace   = { fg = c.overlay },
  SpecialKey   = { fg = c.overlay },
  Conceal      = { fg = c.muted },

  Visual       = { bg = c.burgundy },
  VisualNOS    = { bg = c.burgundy },
  Search       = { fg = c.text, bg = c.surface, underline = true, sp = c.peach },
  CurSearch    = { fg = c.base, bg = c.peach, bold = true },
  IncSearch    = { link = 'CurSearch' },
  Substitute   = { fg = c.text, bg = c.burgundy },
  MatchParen   = { fg = c.peach, bold = true, underline = true },

  Pmenu        = { fg = c.subtle, bg = c.surface },
  PmenuSel     = { fg = c.text, bg = c.burgundy, bold = true },
  PmenuSbar    = { bg = c.surface },
  PmenuThumb   = { bg = c.overlay },
  PmenuKind    = { fg = c.steel, bg = c.surface },
  PmenuExtra   = { fg = c.muted, bg = c.surface },
  WildMenu     = { link = 'PmenuSel' },

  StatusLine   = { fg = c.subtle, bg = c.surface },
  StatusLineNC = { fg = c.muted, bg = c.base_hi },
  TabLine      = { fg = c.muted, bg = c.base_hi },
  TabLineFill  = { bg = c.base },
  TabLineSel   = { fg = c.base, bg = c.text, bold = true },
  WinBar       = { fg = c.subtle, bg = c.base },
  WinBarNC     = { fg = c.muted, bg = c.base },

  Title        = { fg = c.text, bold = true },
  Directory    = { fg = c.steel },
  QuickFixLine = { bg = c.surface, bold = true },
  ModeMsg      = { fg = c.urgent, bold = true },
  MoreMsg      = { fg = c.sage },
  Question     = { fg = c.teal },
  WarningMsg   = { fg = c.peach },
  ErrorMsg     = { fg = c.error, bold = true },

  SpellBad     = { undercurl = true, sp = c.error },
  SpellCap     = { undercurl = true, sp = c.peach },
  SpellRare    = { undercurl = true, sp = c.plum },
  SpellLocal   = { undercurl = true, sp = c.teal },

  -- Syntax (classic groups; Treesitter links to these) -------
  Comment        = { fg = c.muted, italic = true },
  Constant       = { fg = c.plum },
  String         = { fg = c.sage },
  Character      = { fg = c.sage },
  Number         = { fg = c.plum },
  Boolean        = { fg = c.plum, bold = true },
  Float          = { fg = c.plum },
  Identifier     = { fg = c.text },
  Function       = { fg = c.teal },
  Statement      = { fg = c.peach },
  Keyword        = { fg = c.peach },
  Conditional    = { fg = c.peach },
  Repeat         = { fg = c.peach },
  Label          = { fg = c.peach },
  Exception      = { fg = c.peach },
  Operator       = { fg = c.subtle },
  PreProc        = { fg = c.plum },
  Include        = { fg = c.peach },
  Define         = { fg = c.plum },
  Macro          = { fg = c.plum },
  Type           = { fg = c.steel },
  StorageClass   = { fg = c.steel },
  Structure      = { fg = c.steel },
  Typedef        = { fg = c.steel },
  Special        = { fg = c.teal },
  SpecialChar    = { fg = c.teal },
  Delimiter      = { fg = c.muted },
  SpecialComment = { fg = c.subtle, italic = true },
  Tag            = { fg = c.peach },
  Underlined     = { underline = true },
  Bold           = { bold = true },
  Italic         = { italic = true },
  Error          = { fg = c.error },
  Todo           = { fg = c.text, bg = c.burgundy, bold = true },

  -- Treesitter refinements -----------------------------------
  ['@variable']              = { fg = c.text },
  ['@variable.builtin']      = { fg = c.plum, italic = true },
  ['@variable.parameter']    = { fg = c.subtle, italic = true },
  ['@variable.member']       = { fg = c.subtle },
  ['@property']              = { fg = c.subtle },
  ['@module']                = { fg = c.steel },
  ['@constructor']           = { fg = c.steel },
  ['@function.builtin']      = { fg = c.teal, italic = true },
  ['@keyword.return']        = { fg = c.peach, bold = true },
  ['@punctuation.delimiter'] = { fg = c.muted },
  ['@punctuation.bracket']   = { fg = c.muted },
  ['@string.escape']         = { fg = c.teal },
  ['@tag']                   = { fg = c.peach },
  ['@tag.attribute']         = { fg = c.subtle },
  ['@markup.heading']        = { fg = c.text, bold = true },
  ['@markup.strong']         = { bold = true },
  ['@markup.italic']         = { italic = true },
  ['@markup.link']           = { fg = c.steel, underline = true },
  ['@markup.link.url']       = { fg = c.steel, underline = true },
  ['@markup.raw']            = { fg = c.sage },
  ['@markup.list']           = { fg = c.peach },
  ['@comment.todo']          = { link = 'Todo' },
  ['@comment.note']          = { fg = c.base, bg = c.teal, bold = true },
  ['@comment.warning']       = { fg = c.base, bg = c.peach, bold = true },
  ['@comment.error']         = { fg = c.text, bg = c.urgent, bold = true },
  ['@diff.plus']             = { fg = c.sage },
  ['@diff.minus']            = { fg = c.error },
  ['@diff.delta']            = { fg = c.peach },

  -- LSP ------------------------------------------------------
  LspReferenceText            = { bg = c.surface },
  LspReferenceRead            = { bg = c.surface },
  LspReferenceWrite           = { bg = c.surface, underline = true },
  LspInlayHint                = { fg = c.overlay, italic = true },
  LspSignatureActiveParameter = { fg = c.peach, bold = true },

  -- Diagnostics ----------------------------------------------
  DiagnosticError            = { fg = c.error },
  DiagnosticWarn             = { fg = c.peach },
  DiagnosticInfo             = { fg = c.steel },
  DiagnosticHint             = { fg = c.teal },
  DiagnosticOk               = { fg = c.sage },
  DiagnosticUnderlineError   = { undercurl = true, sp = c.error },
  DiagnosticUnderlineWarn    = { undercurl = true, sp = c.peach },
  DiagnosticUnderlineInfo    = { undercurl = true, sp = c.steel },
  DiagnosticUnderlineHint    = { undercurl = true, sp = c.teal },
  DiagnosticVirtualTextError = { fg = c.error, italic = true },
  DiagnosticVirtualTextWarn  = { fg = c.peach, italic = true },
  DiagnosticVirtualTextInfo  = { fg = c.steel, italic = true },
  DiagnosticVirtualTextHint  = { fg = c.teal, italic = true },

  -- Diff / git -----------------------------------------------
  DiffAdd        = { fg = c.sage, bg = c.base_hi },
  DiffChange     = { fg = c.peach, bg = c.base_hi },
  DiffDelete     = { fg = c.error, bg = c.base_hi },
  DiffText       = { fg = c.base, bg = c.peach },
  Added          = { fg = c.sage },
  Changed        = { fg = c.peach },
  Removed        = { fg = c.error },
  GitSignsAdd    = { fg = c.sage },
  GitSignsChange = { fg = c.peach_dk },
  GitSignsDelete = { fg = c.error },

  -- Telescope (fuzzy finder) ---------------------------------
  TelescopeBorder         = { link = 'FloatBorder' },
  TelescopeTitle          = { link = 'FloatTitle' },
  TelescopePromptBorder   = { fg = c.peach, bg = c.base },
  TelescopePromptPrefix   = { fg = c.peach },
  TelescopeSelection      = { fg = c.text, bg = c.burgundy },
  TelescopeSelectionCaret = { fg = c.peach, bg = c.burgundy },
  TelescopeMatching       = { fg = c.peach, bold = true },

  -- which-key (Space menu) -----------------------------------
  WhichKey          = { fg = c.peach },
  WhichKeyGroup     = { fg = c.steel },
  WhichKeyDesc      = { fg = c.subtle },
  WhichKeySeparator = { fg = c.overlay },
  WhichKeyBorder    = { link = 'FloatBorder' },

  -- mini.statusline: the mode block is a HUD "title bar" -----
  MiniStatuslineModeNormal  = { fg = c.base, bg = c.text, bold = true },
  MiniStatuslineModeInsert  = { fg = c.base, bg = c.peach, bold = true },
  MiniStatuslineModeVisual  = { fg = c.text, bg = c.burgundy, bold = true },
  MiniStatuslineModeReplace = { fg = c.text, bg = c.burgundy, bold = true },
  MiniStatuslineModeCommand = { fg = c.base, bg = c.subtle, bold = true },
  MiniStatuslineModeOther   = { fg = c.base, bg = c.muted, bold = true },
  MiniStatuslineDevinfo     = { fg = c.subtle, bg = c.surface },
  MiniStatuslineFilename    = { fg = c.subtle, bg = c.base_hi },
  MiniStatuslineFileinfo    = { fg = c.subtle, bg = c.surface },
  MiniStatuslineInactive    = { fg = c.muted, bg = c.base_hi },

  -- blink.cmp (completion menu) ------------------------------
  BlinkCmpMenu          = { link = 'Pmenu' },
  BlinkCmpMenuBorder    = { link = 'FloatBorder' },
  BlinkCmpMenuSelection = { link = 'PmenuSel' },
  BlinkCmpLabelMatch    = { fg = c.peach, bold = true },
  BlinkCmpKind          = { fg = c.steel },
  BlinkCmpDoc           = { link = 'NormalFloat' },
  BlinkCmpDocBorder     = { link = 'FloatBorder' },
}

for group, spec in pairs(groups) do
  vim.api.nvim_set_hl(0, group, spec)
end

-- ── :terminal colors (same 16 slots as kitty) ─────────────────
local terminal = {
  c.surface, c.error,    c.sage,    c.peach_dk, c.steel,    c.plum,    c.teal,    c.subtle,
  c.muted,   c.error_br, c.sage_br, c.peach,    c.steel_br, c.plum_br, c.teal_br, c.white,
}
for i, color in ipairs(terminal) do
  vim.g['terminal_color_' .. (i - 1)] = color
end
