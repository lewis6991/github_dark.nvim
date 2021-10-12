local api = vim.api

local function parse_expr(x)
  if not x then
    return 'NONE'
  end

  if type(x) == 'number' then
    return ('#%06x'):format(x)
  end

  return x
end

local function parse_attrs(x)
  local r = {}

  for k, a in pairs(x) do
    if type(a) == 'boolean' and a then
      r[#r+1] = k
    end
  end

  if #r > 0 then
    return table.concat(r, ',')
  end
  return 'NONE'
end

-- The Lua API currently doesn't modify the :highlight namespace so by default
-- we use vim.cmd to call the :highlight command. Note however the Lua API code
-- does work it just doesn't update the highlights outputted with :highlight. Once
-- this is fixed in the future we can use the Lua API by default.

local function hi_api(ns, def)
  for name, v in pairs(def) do
    api.nvim_set_hl(ns, name, {
      foreground    = v.fg,
      background    = v.bg,
      special       = v.sp,
      bold          = v.bold,
      underline     = v.underline,
      undercurl     = v.undercurl,
      strikethrough = v.strikethrough,
      reverse       = v.reverse,
      italic        = v.italic,
    })
  end
end

local function hi_viml(def)
  for name, v in pairs(def) do
    local hi_args = {}
    for k, val in pairs{
      guifg   = parse_expr(v.fg),
      guibg   = parse_expr(v.bg),
      guisp   = parse_expr(v.sp),
      gui     = parse_attrs(v),
      ctermfg = 'NONE',
      ctermbg = 'NONE',
      cterm   = 'NONE',
    } do
      table.insert(hi_args, k..'='..val)
    end
    vim.cmd('hi '..name..' '..table.concat(hi_args, ' '))
  end
end

local white    = 0xf0f6fc
-- local black    = 0x010409
local gray_0   = 0x0d1117
local gray_1   = 0x161b22
local gray_2   = 0x21262d
local gray_3   = 0x30363d
local gray_4   = 0x484f58
local gray_5   = 0x6e7681
local gray_6   = 0x8b949e
local gray_7   = 0xb1bac4
local gray_8   = 0xc9d1d9
-- local gray_9   = 0xf0f6fc
-- local blue_0   = 0x051d4d
-- local blue_1   = 0x0c2d6b
-- local blue_2   = 0x0d419d
-- local blue_3   = 0x1158c7
-- local blue_4   = 0x1f6feb
-- local blue_5   = 0x388bfd
-- local blue_6   = 0x58a6ff
local blue_7   = 0x79c0ff
local blue_8   = 0xa5d6ff
local blue_9   = 0xcae8ff
local green_0  = 0x04260f
local green_1  = 0x033a16
-- local green_2  = 0x0f5323
-- local green_3  = 0x196c2e
local green_4  = 0x238636
-- local green_5  = 0x2ea043
local green_6  = 0x3fb950
-- local green_7  = 0x56d364
local green_8  = 0x7ee787
-- local green_9  = 0xaff5b4
local yellow_0 = 0x341a00
-- local yellow_1 = 0x4b2900
-- local yellow_2 = 0x693e00
-- local yellow_3 = 0x845306
local yellow_4 = 0x9e6a03
-- local yellow_5 = 0xbb8009
local yellow_6 = 0xd29922
-- local yellow_7 = 0xe3b341
-- local yellow_8 = 0xf2cc60
-- local yellow_9 = 0xf8e3a1
-- local orange_0 = 0x3d1300
-- local orange_1 = 0x5a1e02
-- local orange_2 = 0x762d0a
-- local orange_3 = 0x9b4215
-- local orange_4 = 0xbd561d
-- local orange_5 = 0xdb6d28
-- local orange_6 = 0xf0883e
local orange_7 = 0xffa657
-- local orange_8 = 0xffc680
-- local orange_9 = 0xffdfb6
local red_0    = 0x490202
local red_1    = 0x67060c
-- local red_2    = 0x8e1519
-- local red_3    = 0xb62324
local red_4    = 0xda3633
-- local red_5    = 0xf85149
local red_6    = 0xff7b72
local red_7    = 0xffa198
-- local red_8    = 0xffc1ba
-- local red_9    = 0xffdcd7
local purple_0 = 0x271052
local purple_1 = 0x3c1e70
-- local purple_2 = 0x553098
local purple_3 = 0x6e40c9
-- local purple_4 = 0x8957e5
-- local purple_5 = 0xa371f7
local purple_6 = 0xbc8cff
local purple_7 = 0xd2a8ff
-- local purple_8 = 0xe2c5ff
-- local purple_9 = 0xeddeff
-- local pink_0   = 0x42062a
-- local pink_1   = 0x5e103e
-- local pink_2   = 0x7d2457
-- local pink_3   = 0x9e3670
-- local pink_4   = 0xbf4b8a
-- local pink_5   = 0xdb61a2
-- local pink_6   = 0xf778ba
-- local pink_7   = 0xff9bce
-- local pink_8   = 0xffbedd
-- local pink_9   = 0xffdaec

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

local M = {}

function M.apply(use_lua_api)
  vim.cmd('highlight clear')
  vim.cmd('syntax reset')

  vim.g.colors_name = 'github_dark'

  local ns
  if use_lua_api then
    ns = api.nvim_create_namespace('github_dark')
    api.nvim__set_hl_ns(ns)

    vim.cmd[[
      augroup github_dark
      autocmd ColorSchemePre * ++once call nvim_set_hl_ns(0)
      augroup END
    ]]
  end

  local function hi(def)
    if use_lua_api then
      return hi_api(ns, def)
    else
      return hi_viml(def)
    end
  end

  hi {
    StorageClass = { fg = red_6  },
    LineNr       = { fg = gray_5 },
    SignColumn   = { fg = gray_5 },
    FoldColumn   = { fg = gray_3 },
    CursorLineNr = { fg = gray_7 },
    Visual       = { bg = selection_bg },
    Cursor       = { fg = white  },
    Normal       = { fg = gray_8, bg = gray_0 },
    NormalFloat  = { fg = gray_8, bg = gray_1 },
    FloatBorder  = { fg = gray_4, bg = gray_1 },
  }

  hi {
    CursorLine    = { bg = gray_1   },
    Todo          = { fg = yellow_6 },
    Directory     = { fg = purple_7 },
    Preproc       = { fg = purple_7 },
    StatusLine    = { fg = gray_8  , bg = gray_2   },
    StatusLineNC  = { fg = gray_4  , bg = gray_1   },
    Folded        = { fg = gray_6  , bg = gray_1   },
    PMenu         = { fg = gray_8  , bg = gray_1   },
    PMenuSel      = { fg = gray_8  , bg = gray_3   },
    NonText       = { fg = gray_4   },
    Search        = { fg = white   , bg = yellow_0 },
    IncSearch     = { fg = white   , bg = yellow_0 },
    SearchCurrent = { fg = white   , bg = yellow_4 },
    VertSplit     = { fg = gray_3   },
    ErrorMsg      = { fg = red_6    },
    WarningMsg    = { fg = yellow_6 },
    MoreMsg       = { fg = green_6  },
    Question      = { fg = green_6  },
    SpecialKey    = { fg = gray_6   },
    SpellBad      = { undercurl=true, sp = red_1},
  }

  hi {
    DiffAdd       = { bg = green_0  },
    DiffDelete    = { bg = red_0    },
    DiffChange    = { bg = purple_0 },
    DiffText      = { bg = purple_1 },
    diffAdded     = { bg = green_0  },
    diffRemoved   = { bg = red_0    },
  }

  hi {
    GitGutterAdd          = { fg = green_4  },
    GitGutterChange       = { fg = purple_3 },
    GitGutterDelete       = { fg = red_4    },
    GitGutterChangeDelete = { fg = purple_3 },
  }

  -- nvim-cmp
  hi {
    CmpItemAbbr      = {fg=gray_5},
    CmpItemAbbrMatch = {fg=gray_8, undercurl=true},
    CmpItemMenu      = {fg=purple_6},
    CmpItemKind      = {fg=blue_7},
  }

  hi {
    GitSignsAdd       = { fg = green_4  },
    GitSignsChange    = { fg = purple_3 },
    GitSignsDelete    = { fg = red_4    },
    GitSignsAddSec    = { fg = green_1  },
    GitSignsChangeSec = { fg = purple_1 },
    GitSignsDeleteSec = { fg = red_1    },
  }

  hi {
    Operator    = { fg = red_7    },
    Keyword     = { fg = red_6    },
    Statement   = { fg = red_6    },
    Conditional = { fg = red_6    },
    Comment     = { fg = gray_4   , italic=true},
    Function    = { fg = purple_7 },
    Structure   = { fg = blue_8   },
    String      = { fg = blue_8   },
    Constant    = { fg = blue_7   },
    Special     = { fg = blue_7   },
    Delimiter   = { fg = red_7    },
    Identifier  = { fg = blue_9   },
    Typedef     = { fg = green_8  },
    Type        = { fg = green_8  },
    Title       = { fg = purple_6 },
  }

  hi {
    TSComment         = { fg = gray_4, italic=true},
    TSVariable        = { fg = gray_8   },
    TSField           = { fg = blue_7   },
    TSProperty        = { fg = gray_7   },
    TSParameter       = { fg = orange_7 },
    TSConstant        = { fg = blue_7   },
    TSConsBuiltin     = { fg = blue_7   },
    TSFunction        = { fg = purple_7 },
    TSFuncBuiltin     = { fg = purple_6 },
    TSFuncMacro       = { fg = purple_7 },
    TSMethod          = { fg = purple_7 },
    TSInclude         = { fg = purple_7 },
    TSAttribute       = { fg = purple_7 },
    TSNamespace       = { fg = purple_7 },
    TSConstMacro      = { fg = purple_7 },
    TSString          = { fg = blue_8   },
    TSStringRegex     = { fg = blue_8   },
    TSStringEscape    = { fg = blue_8   },
    TSCharacter       = { fg = blue_8   },
    TSNumber          = { fg = blue_8   },
    TSBoolean         = { fg = blue_8   },
    TSFloat           = { fg = blue_8   },
    TSVariableBuiltin = { fg = blue_8   },
    TSLiteral         = { fg = blue_8   },
    TSConstructor     = { fg = blue_8   },
    TSKeyword         = { fg = red_6    },
    TSKeywordFunction = { fg = red_6    },
    TSConditional     = { fg = red_6    },
    TSRepeat          = { fg = red_6    },
    TSLabel           = { fg = red_6    },
    TSTag             = { fg = red_6    },
    TSException       = { fg = red_6    },
    TSOperator        = { fg = red_7    },
    TSKeywordOperator = { fg = red_7    },
    TSPunctDelimiter  = { fg = red_7    },
    TSPunctBracket    = { fg = gray_8   },
    TSPunctSpecial    = { fg = gray_8   },
    TSType            = { fg = green_8  },
    TSTypeBuiltin     = { fg = green_8  },
  }

  for kind, color in pairs{
    Error = red_4,
    Warn  = yellow_6,
    Hint  = gray_7,
    Info  = gray_7,
  } do
    hi {
      ['Diagnostic'..kind]          = {fg=color},
      ['DiagnosticUnderline'..kind] = {sp=color, undercurl=true},
    }
  end

end

return M
