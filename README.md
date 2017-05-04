# MarkerSyntax

Simple plugin used to highlight markers with the desired background.

![](https://preview.ibb.co/e9jWO5/Screen_Shot_2017_05_04_at_21_07_01.png)

### Installation

Using package managers:

`Plug 'e0d1n/markersyntax'`

### Configuration

Change which words to highlight:

`let g:markersyntaxWords      = ['TODO',    'FIXME', 'BUG', 'NOTE']`

Change the colors used by the terminal (No GUI) to show each word:

`let g:markersyntaxColors     = ['#fabd2f', '#fe8019', '#fb4934', '#b8bb26']`

Change the colors used by a GUI, like gvim and MacVim:

`let g:markersyntaxColorsGUI = ['214',     '208', '167', '142']`

Case insensitive highlighting:

`let g:wordsCaseSensitive = 0
default to 1`



