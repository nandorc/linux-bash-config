# basher perms

This tool allow users to manage files and folders permissions and ownership based on `find`, `chmod` and `chown` commands.

It needs **sudo** privileges to be executed.

By default it assign **2775** access to folders, **0664** access to files and **0774** access to executable files.

## Commands

`basher perms [?options] [path]`

> If [path] is not defined or refers to a no existent file or folder path, an error will be displayed.

## Options

`--defaults`

> If this flag is sent, it will assign default permissions to files and folders except those explicitly defined.

`--owner [ownername]`

> If is set, it specify the linux user name as [ownername] to be used at **user:group** ownership assignment through `chown` command.

`--group [groupname]`

> If is set, it specify the linux group name as [groupname] to be used at **user:group** ownership assignment through `chown` command.

`--file [permission]`

> Set the value assigned for files when setting permissions. If `--defaults` flag is sent and `--file` option is not setted files take **0664** permission.

`--folder [permission]`

> Set the value assigned for folders when setting permissions. If `--defaults` flag is sent and `--folder` option is not setted folders take **2775** permission.

`--exe [permission]`

> Set the value assigned for executable files when setting permissions. If `--defaults` flag is sent and `--exe` option is not setted executable files take **0774** permission.
