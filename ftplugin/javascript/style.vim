

function! s:isNode()
    let shebang = getline(1)
    if shebang =~# '^#!.*/bin/env\s\+node\>'
        return 1
    endif

    if shebang =~# '^#!.*/bin/node\>'
        return 1
    endif

    return 0
endfunction

if s:isNode()
    exec ":NodeStyleLocal"
endif
