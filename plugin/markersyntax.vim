if !exists( 'g:markersyntaxWords' )
    let g:markersyntaxWords      = ['TODO',    'FIXME', 'BUG', 'NOTE']
endif
if !exists( 'g:markersyntaxColors' )
    let g:markersyntaxColors     = ['#fabd2f', '#fe8019', '#fb4934', '#b8bb26']
endif
if !exists( 'g:marksersyntaxColorsGUI' )
    let g:marksersyntaxColorsGUI = ['214',     '208', '167', '142']
endif

if !exists( 'g:wordsCaseSensitive' )
    let g:wordsCaseSensitive = 1
endif

let s:hasBuiltColors = 0

function! s:apply_color(n, word, id)

    if (g:wordsCaseSensitive == 1)
        " Case sensitive format
        let pat = '\C' . '\V\<' . escape(a:word, '\') . '\>'
    else
        " Case insensitive format
        let pat = '\c' . '\V\<' . escape(a:word, '\') . '\>'
    endif

    let color = g:markersyntaxColors[a:n]

    try
        call matchadd("markercolor" . (a:n), pat, 1, a:id)
    catch /E801/
        " match id already taken.
    endtry
endfunction

function! ColorWord(word)
    if !(s:hasBuiltColors)
        call s:buildColors()
    endif

    " gets current word index lowest unused index
    let n = index(g:markersyntaxWords, a:word)

    " Create a big id, to don't conflict
    let id = 728281 + n
    let g:markersyntaxWords[n] = a:word

    call s:apply_color(n, a:word, id)
endfunction

function! MarkerSyntax() range
    for word in g:markersyntaxWords
        call ColorWord(word)
    endfor
endfunction

function! s:uiMode()
    " Stolen from airline's airline#init#gui_mode()
    return ((has('nvim') && exists('$NVIM_TUI_ENABLE_TRUE_COLOR') && !exists("+termguicolors"))
                \ || has('gui_running') || (has("termtruecolor") && &guicolors == 1) || (has("termguicolors") && &termguicolors == 1)) ?
                \ 'gui' : 'cterm'
endfunction

" Initialise highlight colors check the available colors with :hi!
function! s:buildColors()
    if (s:hasBuiltColors)
        return
    endif
    let ui = s:uiMode()
    let wordColors = (ui == 'gui') ? g:markersyntaxColors : g:marksersyntaxColorsGUI

    let currentIndex = 0
    for wordColor in wordColors
        execute 'hi! def markercolor' . currentIndex . ' ' . ui . 'bg=' . wordColor . ' ' . ui . 'fg=Black'
        let currentIndex += 1
    endfor
    let s:hasBuiltColors = 1
endfunc

au Syntax * call MarkerSyntax()
au ColorScheme * call MarkerSyntax()
