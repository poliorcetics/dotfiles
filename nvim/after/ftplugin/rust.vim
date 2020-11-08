" Only define following variable if Auto-pairs plugin is used
if &runtimepath =~? 'auto-pairs'
    let b:AutoPairs = AutoPairsDefine(
        \ {'(':')', '[':']', '{':'}', '```':'```', '`':'`', '<':'>', '"':'"'},
        \ ["'"]
    \ )
endif
