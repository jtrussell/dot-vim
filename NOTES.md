## Filetype specific mappings

	au FileType php noremap <C-l> :!php -l %<CR>


## Vim has a sweet "Clever Tricks" section in the manual!

	:h user_12.txt

## Show/Hide Hidden Characters

	:set list!  or  :set invlist

## Uppercase/Lowercase text

	:h gu

## Diff two open buffers by using the following command in each

	:diffthis

## Quickly jump to a given golumn (i.e. 80th)

	80| 

## Reformat text around max column length

	visual selection -> gq

## To paste yanked text into a command

	<Ctrl>r *pause* "

## Get rid of those pesky `^M` s...

	:%s/<Ctrl-v><enter>$//g

Use `\zs` to start matching after a pattern

## Macros...

To start recording `q<char>` ... e.g `qq`
To stop recording: `q`
To play back: `@q`
Play back 9 times: `9@q`

## Changing directories

### Change the current working directory to that of the current file

	:cd %:p:h

### Change the cwd to that of the current file (current window only)

	:lcd %:p:h

## Window commands

typically start with `<C-w>` (see `:help Ctrl-W`) i.e. `<C-w><Shift-t>` moves
current window to own tab

## Syntax Highlighting

The command `:highligh` displays all how all syntax groups are affected by the
current color scheme
