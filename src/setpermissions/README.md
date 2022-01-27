# setpermissions tool

This tool allow users to manage files and folders permissions and ownership based on `find`, `chmod` and `chown` commands.

It needs **sudo** privileges to be executed.

By default it assign **2775** access to folders, **0664** access to files and **0774** access to executable files.

## Sintaxis

`setpermissions [?options] [path]`

> If [path] is not defined or refers to a no existent file or folder path, an error will be displayed.

## Options

`-h`

> If this flag is sent, this information will be printed on screen.

`-owner [ownername]`

> If is set, it specify the linux user name as [ownername] to be used at **user:group** ownership assignment through `chown` command.

`-group [groupname]`

> If is set, it specify the linux group name as [groupname] to be used at **user:group** ownership assignment through `chown` command.

`-file [permission]`

> If is set, it modifies the default value assigned for files when setting permissions. By default, files take **0664** permission.

`-folder [permission]`

> If is set, it modifies the default value assigned for folders when setting permissions. By default, folders take **2775** permission.

`-exe [permission]`

> If is set, it modifies the default value assigned for executable files when setting permissions. By default, executable files take **0774** permission.