"
" style.vim
"
"

if &cp || exists("g:style_loaded")
    finish
endif

let g:style_loaded = 1
let s:save_cpo = &cpo
set cpo&vim

function! s:TabWidth(bufferScope, width, expand)

    let theSet = 'set'
    if a:bufferScope
        let theSet = 'setlocal'
    endif

    execute theSet . " tabstop=" . a:width
    execute theSet . " softtabstop=" . a:width
    execute theSet . " shiftwidth=" . a:width

    if a:expand
        execute theSet . ' expandtab'
    else
        execute theSet . ' noexpandtab'
    endif
endfunction

" automatically
" replace tab with space and
" remove trailing whitespace before write and ^M chars
function! s:StripWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")

    " do the business
    if &expandtab
        %retab
    else
        %s/\t\+$//e
    endif

    %s/\s\+$//e

    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! s:StripIfEnabled()
    if (exists('b:strip_on_save') && b:strip_on_save) || s:strip_on_save
        call s:StripWhitespace()
    endif
endfunction

function! s:SetStrip(bufferScope, value)
    if a:bufferScope
        let b:strip_on_save = a:value
    else
        let s:strip_on_save = a:value
    endif
endfunction

let s:strip_on_save = 1
autocmd BufWritePre *  call s:StripIfEnabled()

function! s:LooseStyle(bufferScope)
    call s:TabWidth(a:bufferScope, 4, 0)
    call s:SetStrip(a:bufferScope, 0)
endfunction

function! s:StrictStyle(bufferScope)
    call s:TabWidth(a:bufferScope, 4, 1)
    call s:SetStrip(a:bufferScope, 1)
endfunction

function! s:NodeStyle(bufferScope)
    call s:TabWidth(a:bufferScope, 2, 1)
    call s:SetStrip(a:bufferScope, 1)
endfunction

if !exists('g:style_type')
    let g:style_type = 'strict'
endif

if g:style_type == 'loose'
    call s:LooseStyle()
elseif g:style_type == 'node'
    call s:NodeStyle()
else
    "the default
    call s:StrictStyle()
endif


command! LooseStyle call s:LooseStyle(0)
command! StrictStyle call s:StrictStyle(0)
command! NodeStyle call s:NodeStyle(0)

command! LooseStyleLocal call s:LooseStyle(1)
command! StrictStyleLocal call s:StrictStyle(1)
command! NodeStyleLocal call s:NodeStyle(1)

let &cpo = s:save_cpo
