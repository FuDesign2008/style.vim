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

function! s:TabWidth(width, expand)
    execute "set tabstop=" . a:width
    execute "set softtabstop=" . a:width
    execute "set shiftwidth=" . a:width

    if a:expand
        set expandtab
    else
        set noexpandtab
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
    if s:strip_on_save
        call s:StripWhitespace()
    endif
endfunction

let s:strip_on_save = 1
autocmd BufWritePre *  call s:StripIfEnabled()

function! LooseStyle()
    call s:TabWidth(4, 0)
    let s:strip_on_save = 0
endfunction

function! StrictStyle()
    call s:TabWidth(4, 1)
    let s:strip_on_save = 1
endfunction

function! NodeStyle()
    call s:TabWidth(2, 1)
    let s:strip_on_save = 1
endfunction

if !exists('g:style_type')
    let g:style_type = 'strict'
endif

if g:style_type == 'loose'
    call s:LooseStyle()
elseif g:style_type = 'node'
    call s:NodeStyle()
else
    "the default
    call s:StrictStyle()
endif



command! LooseStyle call s:LooseStyle()
command! StrictStyle call s:StrictStyle()
command! NodeStyle call s:NodeStyle()

let &cpo = s:save_cpo
