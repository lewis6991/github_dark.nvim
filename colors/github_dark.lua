local bit = require'bit'

-- Primer's light and dark ramps use different indices for the same semantic
-- color, so highlights below use named theme roles rather than raw indices.
local palettes = {
  dark = {
    gray = {
      [0] = 0x0d1117, [1] = 0x161b22, [2] = 0x21262d, [3] = 0x30363d, [4] = 0x484f58,
      [5] = 0x6e7681, [6] = 0x8b949e, [7] = 0xb1bac4, [8] = 0xc9d1d9, [9] = 0xf0f6fc
    },
    blue = {
      [0] = 0x051d4d, [1] = 0x0c2d6b, [2] = 0x0d419d, [3] = 0x1158c7, [4] = 0x1f6feb,
      [5] = 0x388bfd, [6] = 0x58a6ff, [7] = 0x79c0ff, [8] = 0xa5d6ff, [9] = 0xcae8ff
    },
    green = {
      [0] = 0x04260f, [1] = 0x033a16, [2] = 0x0f5323, [3] = 0x196c2e, [4] = 0x238636,
      [5] = 0x2ea043, [6] = 0x3fb950, [7] = 0x56d364, [8] = 0x7ee787, [9] = 0xaff5b4
    },
    yellow = {
      [0] = 0x341a00, [1] = 0x4b2900, [2] = 0x693e00, [3] = 0x845306, [4] = 0x9e6a03,
      [5] = 0xbb8009, [6] = 0xd29922, [7] = 0xe3b341, [8] = 0xf2cc60, [9] = 0xf8e3a1
    },
    orange = {
      [0] = 0x3d1300, [1] = 0x5a1e02, [2] = 0x762d0a, [3] = 0x9b4215, [4] = 0xbd561d,
      [5] = 0xdb6d28, [6] = 0xf0883e, [7] = 0xffa657, [8] = 0xffc680, [9] = 0xffdfb6
    },
    red = {
      [0] = 0x490202, [1] = 0x67060c, [2] = 0x8e1519, [3] = 0xb62324, [4] = 0xda3633,
      [5] = 0xf85149, [6] = 0xff7b72, [7] = 0xffa198, [8] = 0xffc1ba, [9] = 0xffdcd7
    },
    purple = {
      [0] = 0x271052, [1] = 0x3c1e70, [2] = 0x553098, [3] = 0x6e40c9, [4] = 0x8957e5,
      [5] = 0xa371f7, [6] = 0xbc8cff, [7] = 0xd2a8ff, [8] = 0xe2c5ff, [9] = 0xeddeff
    },
    pink = {
      [0] = 0x42062a, [1] = 0x5e103e, [2] = 0x7d2457, [3] = 0x9e3670, [4] = 0xbf4b8a,
      [5] = 0xdb61a2, [6] = 0xf778ba, [7] = 0xff9bce, [8] = 0xffbedd, [9] = 0xffdaec
    },
  },
  light = {
    gray = {
      [0] = 0xf6f8fa, [1] = 0xeaeef2, [2] = 0xd0d7de, [3] = 0xafb8c1, [4] = 0x8c959f,
      [5] = 0x6e7781, [6] = 0x57606a, [7] = 0x424a53, [8] = 0x32383f, [9] = 0x24292f
    },
    blue = {
      [0] = 0xddf4ff, [1] = 0xb6e3ff, [2] = 0x80ccff, [3] = 0x54aeff, [4] = 0x218bff,
      [5] = 0x0969da, [6] = 0x0550ae, [7] = 0x033d8b, [8] = 0x0a3069, [9] = 0x002155
    },
    green = {
      [0] = 0xdafbe1, [1] = 0xaceebb, [2] = 0x6fdd8b, [3] = 0x4ac26b, [4] = 0x2da44e,
      [5] = 0x1a7f37, [6] = 0x116329, [7] = 0x044f1e, [8] = 0x003d16, [9] = 0x002d11
    },
    yellow = {
      [0] = 0xfff8c5, [1] = 0xfae17d, [2] = 0xeac54f, [3] = 0xd4a72c, [4] = 0xbf8700,
      [5] = 0x9a6700, [6] = 0x7d4e00, [7] = 0x633c01, [8] = 0x4d2d00, [9] = 0x3b2300
    },
    orange = {
      [0] = 0xfff1e5, [1] = 0xffd8b5, [2] = 0xffb77c, [3] = 0xfb8f44, [4] = 0xe16f24,
      [5] = 0xbc4c00, [6] = 0x953800, [7] = 0x762c00, [8] = 0x5c2200, [9] = 0x471700
    },
    red = {
      [0] = 0xffebe9, [1] = 0xffcecb, [2] = 0xffaba8, [3] = 0xff8182, [4] = 0xfa4549,
      [5] = 0xcf222e, [6] = 0xa40e26, [7] = 0x82071e, [8] = 0x660018, [9] = 0x4c0014
    },
    purple = {
      [0] = 0xfbefff, [1] = 0xecd8ff, [2] = 0xd8b9ff, [3] = 0xc297ff, [4] = 0xa475f9,
      [5] = 0x8250df, [6] = 0x6639ba, [7] = 0x512a97, [8] = 0x3e1f79, [9] = 0x2e1461
    },
    pink = {
      [0] = 0xffeff7, [1] = 0xffd3eb, [2] = 0xffadda, [3] = 0xff80c8, [4] = 0xe85aad,
      [5] = 0xbf3989, [6] = 0x99286e, [7] = 0x772057, [8] = 0x611347, [9] = 0x4d0336
    },
  },
}

local is_light = vim.o.background == 'light'
local palette = is_light and palettes.light or palettes.dark
local gray = palette.gray
local blue = palette.blue
local green = palette.green
local yellow = palette.yellow
local orange = palette.orange
local red = palette.red
local purple = palette.purple
local pink = palette.pink

local theme = is_light and {
  canvas = 0xffffff,
  surface = gray[0],
  surface_muted = gray[1],
  border = gray[5],
  border_subtle = gray[4],
  inactive = 0x656d76,
  fg = 0x1f2328,
  strong_fg = 0x1f2328,
  muted = 0x656d76,
  selection = 0xcee1f8,
  menu_selection = 0xcee1f8,
  match = 0xcee1f8,
  search = yellow[0],
  search_inc = yellow[1],
  search_current = yellow[4],
  error = red[5],
  warning = yellow[5],
  success = green[5],
  mode = green[6],
  todo = yellow[5],
  spell = pink[5],
  title = purple[5],
  directory = purple[5],
  keyword = red[5],
  operator = red[5],
  comment = 0x656d76,
  func = purple[5],
  structure = green[6],
  string = blue[8],
  constant = blue[6],
  variable = orange[6],
  type = green[6],
  add = green[5],
  change = yellow[5],
  delete = red[5],
  add_secondary = green[5],
  change_secondary = yellow[5],
  delete_secondary = red[5],
  add_inline = green[1],
  add_inline_fg = green[6],
  change_bg = orange[0],
  change_inline = orange[1],
  change_inline_fg = orange[6],
  delete_inline = red[1],
  delete_inline_fg = red[6],
  virt_lnum = red[6],
  static = yellow[5],
  deprecated_bg = orange[0],
  scope_bg = purple[0],
  reference_read_bg = blue[0],
  reference_write_bg = pink[0],
  info = blue[5],
  info_bg = blue[0],
} or {
  canvas = gray[0],
  surface = gray[1],
  surface_muted = gray[2],
  border = gray[4],
  border_subtle = gray[3],
  inactive = gray[4],
  fg = gray[8],
  strong_fg = gray[9],
  muted = gray[5],
  selection = 0x29384B,
  menu_selection = gray[3],
  match = gray[2],
  search = yellow[0],
  search_inc = yellow[0],
  search_current = yellow[4],
  error = red[6],
  warning = yellow[6],
  success = green[6],
  mode = green[8],
  todo = yellow[6],
  spell = pink[1],
  title = purple[6],
  directory = purple[7],
  keyword = red[6],
  operator = red[7],
  comment = gray[4],
  func = purple[7],
  structure = blue[8],
  string = blue[8],
  constant = blue[7],
  variable = blue[9],
  type = green[8],
  add = green[4],
  change = purple[3],
  delete = red[4],
  add_secondary = green[1],
  change_secondary = purple[3],
  delete_secondary = red[1],
  add_inline = green[1],
  change_bg = purple[0],
  change_inline = purple[1],
  delete_inline = red[1],
  virt_lnum = red[2],
  static = yellow[2],
  deprecated_bg = orange[0],
  scope_bg = purple[1],
  reference_read_bg = blue[1],
  reference_write_bg = pink[1],
  info = gray[7],
  info_bg = gray[2],
}

--- @param def table<string,table<string,any>>
local function hi(def)
  for name, v in pairs(def) do
    vim.api.nvim_set_hl(0, name, v)
  end
end

local function merge(c1, c2, ratio)
  ratio = ratio or 0.5
  assert(ratio <= 1 and ratio >= 0)
  local r1 = bit.arshift(bit.band(c1, 0xFF0000), 16)
  local r2 = bit.arshift(bit.band(c2, 0xFF0000), 16)
  local g1 = bit.arshift(bit.band(c1, 0x00FF00), 8)
  local g2 = bit.arshift(bit.band(c2, 0x00FF00), 8)
  local b1 = bit.band(c1, 0x0000FF)
  local b2 = bit.band(c2, 0x0000FF)

  local r = bit.band((r1 * ratio) + (r2 * (1 - ratio)), 0xFF)
  local g = bit.band((g1 * ratio) + (g2 * (1 - ratio)), 0xFF)
  local b = bit.band((b1 * ratio) + (b2 * (1 - ratio)), 0xFF)

  return bit.lshift(r, 16) + bit.lshift(g, 8) + b
end

local function subtle(c, ratio)
  -- Light ramps are already pale; only blend them when explicitly requested.
  return is_light and not ratio and c or merge(c, theme.canvas, ratio)
end

vim.cmd.highlight'clear'
vim.cmd.syntax'reset'

vim.g.colors_name = 'github_dark'

hi {
  StorageClass = { fg = theme.keyword },
  LineNr       = { fg = theme.muted },
  SignColumn   = { fg = theme.muted },
  FoldColumn   = { fg = theme.border_subtle },
  ColorColumn  = { bg = theme.surface_muted },
  CursorLineNr = { bg = theme.surface },
  Visual       = { bg = theme.selection },
  Cursor       = { fg = theme.strong_fg },
  Normal       = { fg = theme.fg, bg = theme.canvas },
  NormalFloat  = { fg = theme.fg, bg = theme.surface },
  FloatBorder  = { fg = theme.border, bg = theme.surface },
  FloatTitle   = { fg = theme.title, bg = theme.surface },
  WinSeparator = { fg = theme.border_subtle },

  CursorLine    = { bg = theme.surface },
  Todo          = { fg = theme.todo },
  Directory     = { fg = theme.directory },
  Preproc       = { fg = theme.directory },
  StatusLine    = { fg = theme.fg, bg = theme.surface_muted },
  StatusLineNC  = { fg = theme.inactive, bg = theme.surface },
  Folded        = { fg = gray[6], bg = theme.surface },
  PMenu         = { fg = theme.fg, bg = theme.surface },
  PMenuSel      = { fg = theme.fg, bg = theme.menu_selection },
  MatchParen    = { bg = theme.match, bold = true },
  NonText       = { fg = theme.border_subtle },
  Search        = { fg = theme.strong_fg, bg = theme.search },
  IncSearch     = { fg = theme.strong_fg, bg = theme.search_inc },
  CurSearch     = { fg = theme.strong_fg, bg = theme.search_current },
  VertSplit     = { fg = theme.border_subtle },
  ErrorMsg      = { fg = theme.error },
  WarningMsg    = { fg = theme.warning },
  MoreMsg       = { fg = theme.success },
  ModeMsg       = { fg = theme.mode },
  Question      = { fg = theme.success },
  SpecialKey    = { fg = gray[6] },
  SpellBad      = { undercurl=true, sp = theme.spell },
  TabLine       = { bg = theme.surface_muted },
  TabLineFill   = { fg = gray[6], bg = theme.surface },
  TabLineSel    = { bg = theme.menu_selection, bold=true },

  DiffAdd       = { bg = subtle(green[0]) },
  DiffDelete    = { bg = subtle(red[0]) },
  DiffChange    = { bg = subtle(theme.change_bg) },
  DiffText      = { fg = theme.change_inline_fg, bg = subtle(theme.change_inline) },
  Added         = { bg = green[0]  },
  Changed       = { bg = theme.change_bg },
  Removed       = { bg = red[0]    },

  -- nvim-cmp
  CmpItemAbbr      = {fg=theme.muted },
  CmpItemAbbrMatch = {fg=theme.fg },
  CmpItemMenu      = {fg=theme.title },
  CmpItemKind      = {fg=theme.constant },

  GitSignsAdd            = { fg = theme.add },
  GitSignsChange         = { fg = theme.change },
  GitSignsDelete         = { fg = theme.delete },

  GitSignsAddInline      = { fg = theme.add_inline_fg, bg = theme.add_inline },
  GitSignsChangeInline   = { fg = theme.change_inline_fg, bg = theme.change_inline },
  GitSignsDeleteInline   = { fg = theme.delete_inline_fg, bg = theme.delete_inline },

  -- GitSignsAddLnInline    = { bg = green[1]  },
  -- GitSignsChangeLnInline = { bg = purple[1] },
  -- GitSignsDeleteLnInline = { bg = red[1]    },

  GitSignsAddLnInline    = { fg = theme.add_inline_fg, bg = subtle(green[0], 0.8)},
  GitSignsChangeLnInline = { fg = theme.change_inline_fg, bg = subtle(theme.change_bg, 0.8)},
  GitSignsDeleteLnInline = { fg = theme.delete_inline_fg, bg = subtle(red[0], 0.8)},

  GitSignsAddLn          = { bg = green[0]  },
  GitSignsChangeLn       = { bg = theme.change_bg },
  GitSignsDeleteLn       = { bg = red[0]    },

  GitSignsAddSec         = { fg = theme.add_secondary },
  GitSignsChangeSec      = { fg = theme.change_secondary },
  GitSignsDeleteSec      = { fg = theme.delete_secondary },

  GitSignsVirtLnum       = { bg = red[0], fg = theme.virt_lnum },

  -- vim-gitgutter
  GitGutterAdd          = { link='GitSignsAdd'    },
  GitGutterChange       = { link='GitSignsChange' },
  GitGutterDelete       = { link='GitSignsDelete' },
  GitGutterChangeDelete = { link='GitSignsChange' },

  Operator    = { fg = theme.operator },
  Keyword     = { fg = theme.keyword },
  Statement   = { fg = theme.keyword },
  Conditional = { fg = theme.keyword },
  Comment     = { fg = theme.comment, italic=true},
  Function    = { fg = theme.func },
  Structure   = { fg = theme.structure },
  String      = { fg = theme.string },
  Constant    = { fg = theme.constant },
  Special     = { fg = theme.constant },
  Delimiter   = { fg = theme.operator },
  Identifier  = { fg = theme.variable },
  Typedef     = { fg = theme.type },
  Type        = { fg = theme.type },
  Title       = { fg = theme.title },

  ['@conditional']  = { link = 'Conditional' },
  ['@define']       = { link = 'Define' },
  ['@repeat']       = { link = 'Repeat' },
  ['@storageclass'] = { link = 'StorageClass' },
  ['@type']         = { link = 'Type' },
  ['@class']        = { link = 'Type' },
  ['@type.builtin'] = { link = 'Type' },
  ['@variable']     = { link = 'Identifier' },
  ['@include']      = { link = 'Include' },
  ['@preproc']      = { link = 'PreProc' },

  -- Semtantic tokens
  ['@lsp.typemod.defaultLibrary'] = { italic = true },
  ['@lsp.typemod.deprecated' ]    = { bg = theme.deprecated_bg },
  ['@lsp.type.macro']             = { bg = theme.surface, bold = true },
  ['@lsp.typemod.modification']   = { bg = red[0]},
  ['@lsp.typemod.parameter']      = { italic = true },
  ['@lsp.typemod.readonly']       = { bg = blue[0] },
  ['@lsp.typemod.static']         = { underdotted = true, sp = theme.static },
  ['@lsp.type.keyword']           = { link = 'Keyword' },
  ['@lsp.mod.documentation']      = { link = 'SpecialComment' },
  ['@lsp.typemod.variable.globalScope'] = { bg = subtle(theme.scope_bg) },

  LspInlayHint = { fg = theme.muted, bg = theme.surface, italic = true },

  LspReferenceText = { bg = theme.surface },
  LspReferenceRead = { bg = subtle(theme.reference_read_bg) },
  LspReferenceWrite = { bg = subtle(theme.reference_write_bg) },
}

for kind, colors in pairs{
  Error = { fg = red[5]    , bg = red[0] },
  Warn  = { fg = yellow[5] , bg = yellow[0] },
  Hint  = { fg = theme.muted, bg = theme.surface },
  Info  = { fg = theme.info, bg = theme.info_bg },
} do
  hi {
    ['Diagnostic'..kind]            = {fg = colors.fg },
    ['DiagnosticVirtualText'..kind] = {fg = colors.fg, bg = colors.bg},
    ['DiagnosticUnderline'..kind]   = {sp = colors.fg, undercurl = true},
  }
end

hi {
  ['RenderMarkdownCode'] = {bg = theme.surface },
}
