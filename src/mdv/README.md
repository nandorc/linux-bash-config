# basher mdv

This command allows to display Markdown files using pandoc or less.

## Commands

`basher mdv --reset`

> Re-define setted value for use_pandoc variable at config.ini file in order to specify if pandoc must be used as Markdown files formatter.

`basher mdv [path]`

`basher mdv --reset [path]`

> Display using less or pandoc a file located at [path].
>
> If `--reset` flag is sent points to re-define setted value for use_pandoc variable at config.ini file.

## Important note

The first time the command is executed, --reset flag will be automatically included in order to define config.ini file.

It also happens if use_pandoc variable doesn't exists at config.ini file for any reason.
