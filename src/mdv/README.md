# mdv command

This command allows to display Markdown files using pandoc or less.

`mdv --help`

> Print this information.

`mdv --reset`

> Define or re-define setted value for use_pandoc variable at config.ini file in order to specify if pando must be used as Markdown files formatter.

`mdv [path]`

> Display using less or pandoc a file located at [path].

## Important note

The first time any of the commands described here is executed, --reset comand will be dispatch in order to define config.ini file. It also happens if use_pandoc variable doesn't exists at config.ini file.