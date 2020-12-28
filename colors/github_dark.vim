hi clear
syntax reset
let g:colors_name = 'github_dark'

let s:white    = '#f0f6fc'
let s:black    = '#010409'
let s:gray_0   = '#0d1117'
let s:gray_1   = '#161b22'
let s:gray_2   = '#21262d'
let s:gray_3   = '#30363d'
let s:gray_4   = '#484f58'
let s:gray_5   = '#6e7681'
let s:gray_6   = '#8b949e'
let s:gray_7   = '#b1bac4'
let s:gray_8   = '#c9d1d9'
let s:gray_9   = '#f0f6fc'
let s:blue_0   = '#051d4d'
let s:blue_1   = '#0c2d6b'
let s:blue_2   = '#0d419d'
let s:blue_3   = '#1158c7'
let s:blue_4   = '#1f6feb'
let s:blue_5   = '#388bfd'
let s:blue_6   = '#58a6ff'
let s:blue_7   = '#79c0ff'
let s:blue_8   = '#a5d6ff'
let s:blue_9   = '#cae8ff'
let s:green_0  = '#04260f'
let s:green_1  = '#033a16'
let s:green_2  = '#0f5323'
let s:green_3  = '#196c2e'
let s:green_4  = '#238636'
let s:green_5  = '#2ea043'
let s:green_6  = '#3fb950'
let s:green_7  = '#56d364'
let s:green_8  = '#7ee787'
let s:green_9  = '#aff5b4'
let s:yellow_0 = '#341a00'
let s:yellow_1 = '#4b2900'
let s:yellow_2 = '#693e00'
let s:yellow_3 = '#845306'
let s:yellow_4 = '#9e6a03'
let s:yellow_5 = '#bb8009'
let s:yellow_6 = '#d29922'
let s:yellow_7 = '#e3b341'
let s:yellow_8 = '#f2cc60'
let s:yellow_9 = '#f8e3a1'
let s:orange_0 = '#3d1300'
let s:orange_1 = '#5a1e02'
let s:orange_2 = '#762d0a'
let s:orange_3 = '#9b4215'
let s:orange_4 = '#bd561d'
let s:orange_5 = '#db6d28'
let s:orange_6 = '#f0883e'
let s:orange_7 = '#ffa657'
let s:orange_8 = '#ffc680'
let s:orange_9 = '#ffdfb6'
let s:red_0    = '#490202'
let s:red_1    = '#67060c'
let s:red_2    = '#8e1519'
let s:red_3    = '#b62324'
let s:red_4    = '#da3633'
let s:red_5    = '#f85149'
let s:red_6    = '#ff7b72'
let s:red_7    = '#ffa198'
let s:red_8    = '#ffc1ba'
let s:red_9    = '#ffdcd7'
let s:purple_0 = '#271052'
let s:purple_1 = '#3c1e70'
let s:purple_2 = '#553098'
let s:purple_3 = '#6e40c9'
let s:purple_4 = '#8957e5'
let s:purple_5 = '#a371f7'
let s:purple_6 = '#bc8cff'
let s:purple_7 = '#d2a8ff'
let s:purple_8 = '#e2c5ff'
let s:purple_9 = '#eddeff'
let s:pink_0   = '#42062a'
let s:pink_1   = '#5e103e'
let s:pink_2   = '#7d2457'
let s:pink_3   = '#9e3670'
let s:pink_4   = '#bf4b8a'
let s:pink_5   = '#db61a2'
let s:pink_6   = '#f778ba'
let s:pink_7   = '#ff9bce'
let s:pink_8   = '#ffbedd'
let s:pink_9   = '#ffdaec'

let s:ansi_black          = s:gray_0
let s:ansi_black_bright   = s:gray_1
let s:ansi_white          = s:gray_7
let s:ansi_white_bright   = s:gray_8
let s:ansi_gray           = s:gray_5
let s:ansi_red            = s:red_6
let s:ansi_red_bright     = s:red_7
let s:ansi_green          = s:green_6
let s:ansi_green_bright   = s:green_7
let s:ansi_yellow         = s:yellow_6
let s:ansi_yellow_bright  = s:yellow_7
let s:ansi_blue           = s:blue_6
let s:ansi_blue_bright    = s:blue_7
let s:ansi_magenta        = s:purple_6
let s:ansi_magenta_bright = s:purple_7
let s:ansi_cyan           = '#76e3ea'
let s:ansi_cyan_bright    = '#b3f0ff'

let s:selection_bg = '#29384B'

function! <sid>hi(group, guifg, guibg) abort
    let guifg = a:guifg ==# '' ? 'None' : a:guifg
    let guibg = a:guibg ==# '' ? 'None' : a:guibg
    execute(join([
        \     'highlight',
        \     a:group,
        \     'gui=None',
        \     'guifg='.guifg,
        \     'guibg='.guibg,
        \ ]))
endfunction

call <sid>hi('StorageClass' , s:red_6 , ''            )
call <sid>hi('LineNr'       , s:gray_5, ''            )
call <sid>hi('SignColumn'   , s:gray_5, ''            )
call <sid>hi('CursorLineNr' , s:gray_7, ''            )
call <sid>hi('Visual'       , ''      , s:selection_bg)
call <sid>hi('Cursor'       , s:white , ''            )
call <sid>hi('Normal'       , s:gray_8, s:gray_0      )


call <sid>hi('CursorLine'   , ''        , s:gray_1  )
call <sid>hi('Todo'         , s:yellow_6, ''        )
call <sid>hi('Directory'    , s:purple_7, ''        )
call <sid>hi('Preproc'      , s:purple_7, ''        )
call <sid>hi('StatusLine'   , s:gray_8  , s:gray_2  )
call <sid>hi('StatusLineNC' , s:gray_4  , s:gray_1  )
call <sid>hi('Folded'       , s:gray_6  , s:gray_1  )
call <sid>hi('PMenu'        , s:gray_8  , s:gray_1  )
call <sid>hi('PMenuSel'     , s:gray_8  , s:gray_3  )
call <sid>hi('NonText'      , s:gray_4  , ''        )
call <sid>hi('Search'       , s:white   , s:yellow_0)
call <sid>hi('IncSearch'    , s:white   , s:yellow_0)
call <sid>hi('SearchCurrent', s:white   , s:yellow_4)
call <sid>hi('ErrorMsg'     , s:red_6   , ''        )
call <sid>hi('WarningMsg'   , s:yellow_6, ''        )
call <sid>hi('MoreMsg'      , s:green_6 , ''        )
call <sid>hi('Question'     , s:green_6 , ''        )

call <sid>hi('DiffAdd'   , '', s:green_0 )
call <sid>hi('DiffDelete', '', s:red_0   )
call <sid>hi('DiffChange', '', s:purple_0)
call <sid>hi('DiffText'  , '', s:purple_1)

call <sid>hi('GitGutterAdd'         , s:green_4 , '')
call <sid>hi('GitGutterChange'      , s:purple_3, '')
call <sid>hi('GitGutterDelete'      , s:red_4   , '')
call <sid>hi('GitGutterChangeDelete', s:purple_3, '')

call <sid>hi('Operator'     , s:red_7   , '')
call <sid>hi('Keyword'      , s:red_6   , '')
call <sid>hi('Statement'    , s:red_6   , '')
call <sid>hi('Conditional'  , s:red_6   , '')
call <sid>hi('Comment'      , s:gray_4  , '')
call <sid>hi('Function'     , s:purple_7, '')
call <sid>hi('Structure'    , s:blue_8  , '')
call <sid>hi('String'       , s:blue_8  , '')
call <sid>hi('Constant'     , s:blue_7  , '')
call <sid>hi('Special'      , s:blue_7  , '')
call <sid>hi('Delimiter'    , s:red_7   , '')
call <sid>hi('Identifier'   , s:gray_8  , '')
call <sid>hi('Typedef'      , s:green_8 , '')
call <sid>hi('Type'         , s:green_8 , '')

call <sid>hi('Title'        , s:purple_6 , '')

call <sid>hi('TSComment'        , s:gray_4  , '')
call <sid>hi('TSVariable'       , s:gray_8  , '')
call <sid>hi('TSField'          , s:blue_7  , '')
call <sid>hi('TSProperty'       , s:gray_7  , '')
call <sid>hi('TSParameter'      , s:orange_7, '')
call <sid>hi('TSConstant'       , s:blue_7  , '')
call <sid>hi('TSConsBuiltin'    , s:blue_7  , '')
call <sid>hi('TSFunction'       , s:purple_7, '')
call <sid>hi('TSFuncBuiltin'    , s:purple_6, '')
call <sid>hi('TSFuncMacro'      , s:purple_7, '')
call <sid>hi('TSMethod'         , s:purple_7, '')
call <sid>hi('TSInclude'        , s:purple_7, '')
call <sid>hi('TSAttribute'      , s:purple_7, '')
call <sid>hi('TSNamespace'      , s:purple_7, '')
call <sid>hi('TSConstMacro'     , s:purple_7, '')
call <sid>hi('TSString'         , s:blue_8  , '')
call <sid>hi('TSStringRegex'    , s:blue_8  , '')
call <sid>hi('TSStringEscape'   , s:blue_8  , '')
call <sid>hi('TSCharacter'      , s:blue_8  , '')
call <sid>hi('TSNumber'         , s:blue_8  , '')
call <sid>hi('TSBoolean'        , s:blue_8  , '')
call <sid>hi('TSFloat'          , s:blue_8  , '')
call <sid>hi('TSVariableBuiltin', s:blue_8  , '')
call <sid>hi('TSLiteral'        , s:blue_8  , '')
call <sid>hi('TSConstructor'    , s:blue_8  , '')
call <sid>hi('TSKeyword'        , s:red_6   , '')
call <sid>hi('TSKeywordFunction', s:red_6   , '')
call <sid>hi('TSConditional'    , s:red_6   , '')
call <sid>hi('TSRepeat'         , s:red_6   , '')
call <sid>hi('TSLabel'          , s:red_6   , '')
call <sid>hi('TSTag'            , s:red_6   , '')
call <sid>hi('TSException'      , s:red_6   , '')
call <sid>hi('TSOperator'       , s:red_7   , '')
call <sid>hi('TSKeywordOperator', s:red_7   , '')
call <sid>hi('TSPunctDelimiter' , s:red_7   , '')
call <sid>hi('TSPunctBracket'   , s:gray_8  , '')
call <sid>hi('TSPunctSpecial'   , s:gray_8  , '')
call <sid>hi('TSType'           , s:green_8 , '')
call <sid>hi('TSTypeBuiltin'    , s:green_8 , '')

