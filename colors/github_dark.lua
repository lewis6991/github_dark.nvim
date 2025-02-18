local bit = require'bit'

local gray = {
  [0] = 0x0d1117, [1] = 0x161b22, [2] = 0x21262d, [3] = 0x30363d, [4] = 0x484f58,
  [5] = 0x6e7681, [6] = 0x8b949e, [7] = 0xb1bac4, [8] = 0xc9d1d9, [9] = 0xf0f6fc
}

local blue = {
  [0] = 0x051d4d, [1] = 0x0c2d6b, [2] = 0x0d419d, [3] = 0x1158c7, [4] = 0x1f6feb,
  [5] = 0x388bfd, [6] = 0x58a6ff, [7] = 0x79c0ff, [8] = 0xa5d6ff, [9] = 0xcae8ff
}

local green = {
  [0] = 0x04260f, [1] = 0x033a16, [2] = 0x0f5323, [3] = 0x196c2e, [4] = 0x238636,
  [5] = 0x2ea043, [6] = 0x3fb950, [7] = 0x56d364, [8] = 0x7ee787, [9] = 0xaff5b4
}

local yellow = {
  [0] = 0x341a00, [1] = 0x4b2900, [2] = 0x693e00, [3] = 0x845306, [4] = 0x9e6a03,
  [5] = 0xbb8009, [6] = 0xd29922, [7] = 0xe3b341, [8] = 0xf2cc60, [9] = 0xf8e3a1
}

local orange = {
  [0] = 0x3d1300, [1] = 0x5a1e02, [2] = 0x762d0a, [3] = 0x9b4215, [4] = 0xbd561d,
  [5] = 0xdb6d28, [6] = 0xf0883e, [7] = 0xffa657, [8] = 0xffc680, [9] = 0xffdfb6
}

local red = {
  [0] = 0x490202, [1] = 0x67060c, [2] = 0x8e1519, [3] = 0xb62324, [4] = 0xda3633,
  [5] = 0xf85149, [6] = 0xff7b72, [7] = 0xffa198, [8] = 0xffc1ba, [9] = 0xffdcd7
}

local purple = {
  [0] = 0x271052, [1] = 0x3c1e70, [2] = 0x553098, [3] = 0x6e40c9, [4] = 0x8957e5,
  [5] = 0xa371f7, [6] = 0xbc8cff, [7] = 0xd2a8ff, [8] = 0xe2c5ff, [9] = 0xeddeff
}

local pink = {
  [0] = 0x42062a, [1] = 0x5e103e, [2] = 0x7d2457, [3] = 0x9e3670, [4] = 0xbf4b8a,
  [5] = 0xdb61a2, [6] = 0xf778ba, [7] = 0xff9bce, [8] = 0xffbedd, [9] = 0xffdaec
}

local black    = 0x010409
local white = gray[9]

-- local ansi_black          = gray_0
-- local ansi_black_bright   = gray_1
-- local ansi_white          = gray_7
-- local ansi_white_bright   = gray_8
-- local ansi_gray           = gray_5
-- local ansi_red            = red_6
-- local ansi_red_bright     = red_7
-- local ansi_green          = green_6
-- local ansi_green_bright   = green_7
-- local ansi_yellow         = yellow_6
-- local ansi_yellow_bright  = yellow_7
-- local ansi_blue           = blue_6
-- local ansi_blue_bright    = blue_7
-- local ansi_magenta        = purple_6
-- local ansi_magenta_bright = purple_7
-- local ansi_cyan           = 0x76e3ea
-- local ansi_cyan_bright    = 0xb3f0ff

local selection_bg = 0x29384B

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

local function dim(c, ratio)
  return merge(c, gray[0], ratio)
end

vim.cmd.highlight'clear'
vim.cmd.syntax'reset'

vim.g.colors_name = 'github_dark'

hi {
  StorageClass = { fg = red[6]  },
  LineNr       = { fg = gray[5] },
  SignColumn   = { fg = gray[5] },
  FoldColumn   = { fg = gray[3] },
  ColorColumn  = { bg = gray[2] },
  CursorLineNr = { bg = gray[1] },
  Visual       = { bg = selection_bg },
  Cursor       = { fg = white  },
  Normal       = { fg = gray[8], bg = gray[0] },
  NormalFloat  = { fg = gray[8], bg = gray[1] },
  FloatBorder  = { fg = gray[4], bg = gray[1] },
  FloatTitle   = { fg = purple[6], bg = gray[1] },
  WinSeparator = { fg = gray[3] },

  CursorLine    = { bg = gray[1]   },
  Todo          = { fg = yellow[6] },
  Directory     = { fg = purple[7] },
  Preproc       = { fg = purple[7] },
  StatusLine    = { fg = gray[8] , bg = gray[2]   },
  StatusLineNC  = { fg = gray[4] , bg = gray[1]   },
  Folded        = { fg = gray[6] , bg = gray[1]   },
  PMenu         = { fg = gray[8] , bg = gray[1]   },
  PMenuSel      = { fg = gray[8] , bg = gray[3]   },
  MatchParen    = { bg = gray[2] , bold = true   },
  NonText       = { fg = gray[3]   },
  Search        = { fg = white  , bg = yellow[0] },
  IncSearch     = { fg = white  , bg = yellow[0] },
  CurSearch     = { fg = white  , bg = yellow[4] },
  VertSplit     = { fg = gray[3]   },
  ErrorMsg      = { fg = red[6]    },
  WarningMsg    = { fg = yellow[6] },
  MoreMsg       = { fg = green[6]  },
  ModeMsg       = { fg = green[8]  },
  Question      = { fg = green[6]  },
  SpecialKey    = { fg = gray[6]   },
  SpellBad      = { undercurl=true, sp = pink[1]},
  TabLine       = { bg = gray[2] },
  TabLineFill   = { fg = gray[6], bg = gray[1] },
  TabLineSel    = {               bg = gray[3], bold=true },

  DiffAdd       = { bg = dim(green[0])  },
  DiffDelete    = { bg = dim(red[0])    },
  DiffChange    = { bg = dim(purple[0]) },
  DiffText      = { bg = dim(purple[1]) },
  Added         = { bg = green[0]  },
  Changed       = { bg = purple[0] },
  Removed       = { bg = red[0]    },

  -- nvim-cmp
  CmpItemAbbr      = {fg=gray[5]   },
  CmpItemAbbrMatch = {fg=gray[8]   },
  CmpItemMenu      = {fg=purple[6] },
  CmpItemKind      = {fg=blue[7]   },

  GitSignsAdd            = { fg = green[4]  },
  GitSignsChange         = { fg = purple[3] },
  GitSignsDelete         = { fg = red[4]    },

  GitSignsAddInline      = { bg = green[1]  },
  GitSignsChangeInline   = { bg = purple[1] },
  GitSignsDeleteInline   = { bg = red[1]    },

  -- GitSignsAddLnInline    = { bg = green[1]  },
  -- GitSignsChangeLnInline = { bg = purple[1] },
  -- GitSignsDeleteLnInline = { bg = red[1]    },

  GitSignsAddLnInline    = { bg = dim(green[0] , 0.8)},
  GitSignsChangeLnInline = { bg = dim(purple[0], 0.8)},
  GitSignsDeleteLnInline = { bg = dim(red[0]   , 0.8)},

  GitSignsAddLn          = { bg = green[0]  },
  GitSignsChangeLn       = { bg = purple[0] },
  GitSignsDeleteLn       = { bg = red[0]    },

  GitSignsAddSec         = { fg = green[1]  },
  GitSignsChangeSec      = { fg = purple[3] },
  GitSignsDeleteSec      = { fg = red[1]    },

  GitSignsVirtLnum       = { bg = red[0], fg = red[2]  },

  -- vim-gitgutter
  GitGutterAdd          = { link='GitSignsAdd'    },
  GitGutterChange       = { link='GitSignsChange' },
  GitGutterDelete       = { link='GitSignsDelete' },
  GitGutterChangeDelete = { link='GitSignsChange' },

  Operator    = { fg = red[7]    },
  Keyword     = { fg = red[6]    },
  Statement   = { fg = red[6]    },
  Conditional = { fg = red[6]    },
  Comment     = { fg = gray[4]   , italic=true},
  Function    = { fg = purple[7] },
  Structure   = { fg = blue[8]   },
  String      = { fg = blue[8]   },
  Constant    = { fg = blue[7]   },
  Special     = { fg = blue[7]   },
  Delimiter   = { fg = red[7]    },
  Identifier  = { fg = blue[9]   },
  Typedef     = { fg = green[8]  },
  Type        = { fg = green[8]  },
  Title       = { fg = purple[6] },

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
  ['@lsp.typemod.deprecated' ]    = { bg = orange[0] },
  ['@lsp.type.macro']             = { bg = gray[1], bold = true },
  ['@lsp.typemod.modification']   = { bg = red[0]},
  ['@lsp.typemod.parameter']      = { italic = true },
  ['@lsp.typemod.readonly']       = { bg = blue[0] },
  ['@lsp.typemod.static']         = { underdotted = true, sp = yellow[2] },
  ['@lsp.type.keyword']           = { link = 'Keyword' },
  ['@lsp.mod.documentation']      = { link = 'SpecialComment' },
  ['@lsp.typemod.variable.globalScope'] = { bg = dim(purple[1]) },

  LspInlayHint = { fg = gray[5], bg = gray[1], italic = true },

  LspReferenceText = { bg = gray[1] },
  LspReferenceRead = { bg = dim(blue[1]) },
  LspReferenceWrite = { bg = dim(pink[1]) },
}

for kind, colors in pairs{
  Error = { fg = red[5]    , bg = red[0] },
  Warn  = { fg = yellow[5] , bg = yellow[0] },
  Hint  = { fg = gray[5]   , bg = gray[1] },
  Info  = { fg = gray[7]   , bg = gray[2] },
} do
  hi {
    ['Diagnostic'..kind]            = {fg = colors.fg },
    ['DiagnosticVirtualText'..kind] = {fg = colors.fg, bg = colors.bg},
    ['DiagnosticUnderline'..kind]   = {sp = colors.fg, undercurl = true},
  }
end

hi {
  ['RenderMarkdownCode'] = {bg = gray[1] },
}
