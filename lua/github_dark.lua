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
    if v.link then
      vim.cmd('hi link '..name..' '..v.link)
    else
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
end


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

-- local black    = 0x010409
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
    StorageClass = { fg = red[6]  },
    LineNr       = { fg = gray[5] },
    SignColumn   = { fg = gray[5] },
    FoldColumn   = { fg = gray[3] },
    CursorLineNr = { fg = gray[7] },
    Visual       = { bg = selection_bg },
    Cursor       = { fg = white  },
    Normal       = { fg = gray[8], bg = gray[0] },
    NormalFloat  = { fg = gray[8], bg = gray[1] },
    FloatBorder  = { fg = gray[4], bg = gray[1] },
  }

  hi {
    CursorLine    = { bg = gray[1]   },
    Todo          = { fg = yellow[6] },
    Directory     = { fg = purple[7] },
    Preproc       = { fg = purple[7] },
    StatusLine    = { fg = gray[8] , bg = gray[2]   },
    StatusLineNC  = { fg = gray[4] , bg = gray[1]   },
    Folded        = { fg = gray[6] , bg = gray[1]   },
    PMenu         = { fg = gray[8] , bg = gray[1]   },
    PMenuSel      = { fg = gray[8] , bg = gray[3]   },
    NonText       = { fg = gray[3]   },
    Search        = { fg = white  , bg = yellow[0] },
    IncSearch     = { fg = white  , bg = yellow[0] },
    SearchCurrent = { fg = white  , bg = yellow[4] },
    VertSplit     = { fg = gray[3]   },
    ErrorMsg      = { fg = red[6]    },
    WarningMsg    = { fg = yellow[6] },
    MoreMsg       = { fg = green[6]  },
    Question      = { fg = green[6]  },
    SpecialKey    = { fg = gray[6]   },
    SpellBad      = { undercurl=true, sp = pink[1]},
    -- TabLine       = { bg = gray[2] },
    TabLineFill   = { fg = gray[6], bg = gray[1] },
    TabLineSel    = {               bg = gray[2], bold=true },
  }

  hi {
    DiffAdd       = { bg = green[0]  },
    DiffDelete    = { bg = red[0]    },
    DiffChange    = { bg = purple[0] },
    DiffText      = { bg = purple[1] },
    diffAdded     = { bg = green[0]  },
    diffRemoved   = { bg = red[0]    },
  }

  -- nvim-cmp
  hi {
    CmpItemAbbr      = {fg=gray[5]   },
    CmpItemAbbrMatch = {fg=gray[8]   },
    CmpItemMenu      = {fg=purple[6] },
    CmpItemKind      = {fg=blue[7]   },
  }

  hi {
    GitSignsAdd            = { fg = green[4]  },
    GitSignsChange         = { fg = purple[3] },
    GitSignsDelete         = { fg = red[4]    },

    GitSignsAddInline      = { bg = green[2]  },
    GitSignsChangeInline   = { bg = purple[2] },
    GitSignsDeleteInline   = { bg = red[2]    },

    GitSignsAddLnInline    = { bg = green[1]  },
    GitSignsChangeLnInline = { bg = purple[1] },
    GitSignsDeleteLnInline = { bg = red[1]    },

    GitSignsAddLn          = { bg = green[0]  },
    GitSignsChangeLn       = { bg = purple[0] },
    GitSignsDeleteLn       = { bg = red[0]    },

    GitSignsAddSec         = { fg = green[1]  },
    GitSignsChangeSec      = { fg = purple[3] },
    GitSignsDeleteSec      = { fg = red[1]    },
  }

  -- vim-gitgutter
  hi {
    GitGutterAdd          = { link='GitSignsAdd'    },
    GitGutterChange       = { link='GitSignsChange' },
    GitGutterDelete       = { link='GitSignsDelete' },
    GitGutterChangeDelete = { link='GitSignsChange' },
  }

  hi {
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
  }

  hi {
    TSVariable        = { fg = gray[8]   },
    -- TSField           = { fg = blue[7]   },
    -- TSProperty        = { fg = gray[7]   },
    -- TSParameter       = { fg = orange[7] },
    -- TSNamespace       = { link = 'Function' },
    -- TSConstructor     = { link = 'String' },

    TSAnnotation         = { link = 'PreProc'        },
    TSAttribute          = { link = 'PreProc'        },
    TSBoolean            = { link = 'Boolean'        },
    TSCharacter          = { link = 'Character'      },
    TSComment            = { link = 'Comment'        },
    TSConditional        = { link = 'Conditional'    },
    TSConstBuiltin       = { link = 'Special'        },
    TSConstMacro         = { link = 'Define'         },
    TSConstant           = { link = 'Constant'       },
    TSConstructor        = { link = 'Special'        },
    TSDanger             = { link = 'WarningMsg'     },
    TSEnvironment        = { link = 'Macro'          },
    TSEnvironmentName    = { link = 'Type'           },
    TSException          = { link = 'Exception'      },
    TSField              = { link = 'Identifier'     },
    TSFloat              = { link = 'Float'          },
    TSFuncBuiltin        = { link = 'Special'        },
    TSFuncMacro          = { link = 'Macro'          },
    TSFunction           = { link = 'Function'       },
    TSInclude            = { link = 'Include'        },
    TSKeyword            = { link = 'Keyword'        },
    TSKeywordFunction    = { link = 'Keyword'        },
    TSKeywordOperator    = { link = 'Operator'       },
    TSKeywordReturn      = { link = 'Keyword'        },
    TSLabel              = { link = 'Label'          },
    TSLiteral            = { link = 'String'         },
    TSMath               = { link = 'Special'        },
    TSMethod             = { link = 'Function'       },
    TSNamespace          = { link = 'Include'        },
    TSNote               = { link = 'SpecialComment' },
    TSNumber             = { link = 'Number'         },
    TSOperator           = { link = 'Operator'       },
    TSParameter          = { link = 'Identifier'     },
    -- TSParameter          = { fg = orange[7] },
    -- TSParameterReference = { link = 'Identifier'     },
    TSParameterReference = { fg = orange[7] },
    TSPlaygroundFocus    = { link = 'Visual'         },
    TSPlaygroundLang     = { link = 'String'         },
    TSProperty           = { link = 'Identifier'     },
    TSPunctBracket       = { link = 'Delimiter'      },
    TSPunctDelimiter     = { link = 'Delimiter'      },
    TSPunctSpecial       = { link = 'Delimiter'      },
    TSQueryLinterError   = { link = 'Error'          },
    TSRepeat             = { link = 'Repeat'         },
    TSString             = { link = 'String'         },
    TSStringEscape       = { link = 'SpecialChar'    },
    TSStringRegex        = { link = 'String'         },
    TSStringSpecial      = { link = 'SpecialChar'    },
    TSSymbol             = { link = 'Identifier'     },
    TSTag                = { link = 'Label'          },
    TSTagAttribute       = { link = 'Identifier'     },
    TSTagDelimiter       = { link = 'Delimiter'      },
    TSText               = { link = 'TSNone'         },
    TSTextReference      = { link = 'Constant'       },
    TSTitle              = { link = 'Title'          },
    TSType               = { link = 'Type'           },
    TSTypeBuiltin        = { link = 'Type'           },
    TSURI                = { link = 'Underlined'     },
    TSVariableBuiltin    = { link = 'Special'        },
    TSWarning            = { link = 'Todo'           },
  }

  for kind, color in pairs{
    Error = red[4],
    Warn  = yellow[6],
    Hint  = gray[7],
    Info  = gray[7],
  } do
    hi {
      ['Diagnostic'..kind]          = {fg=color},
      ['DiagnosticUnderline'..kind] = {sp=color, undercurl=true},
    }
  end

end

return M
