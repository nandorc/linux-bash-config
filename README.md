# Bash Utilities

> **Author:** Daniel F. Rivera C. <<dsoftcolombia@gmail.com>>

## Description

This repository is intended to provide a simple way to customize linux terminal behaviour and give linux users tools to execute some administration tasks easy. It was tested on WSL.

## Features

* Displays git information
* Support quick access to apache webservice funcionalities
* Autostart on login request for apache webservice
* Management of files and folders permissions
* Provides support to additional configurations

## Additional Configuration Notes

If you like to include extra features, aliases or on run scripts you must do it creating a new file. It must be `~/.bash_aliases_extra`

## Tools

---

### bashcustomize
 
This tool allows users to set or unset variables which manage the behavoiur of the linux terminal.
 
> `bashcustomize help`
>
> Print help message with basic information about available commands

> `bashcustomize list`
>
> Prints defined variables list

> `bashcustomize set [name] [?value]`
>
> Set a customization variable, if no [value] provided is set to blank

> `bashcustomize unset [name]`
>
> Unset (delete) a customization variable

> `bashcustomize reset`
>
> Set default values on variables

---

### setpermissions

This tool allow users to manage files and folders permissions and ownership based on `find`, `chmod` and `chown` commands. It needs **sudo** privileges to be executed. By default it assign **2775** access to folders, **0664** access to files and **0774** access to executable files.

 `setpermissions [?options] [path]`
> **Options:**
>
>> `-owner [ownername]`
>>
>> If is set, it specify the linux user name as *ownername* to be used at **user:group** ownership assignment through `chown` command.
>
>> `-group [groupname]`
>>
>> If is set, it specify the linux group name as *groupname* to be used at **user:group** ownership assignment through `chown` command.
>
>> `-file [permission]`
>> 
>> If is set, it modifies the default value assigned  for files when setting permissions. By default, files take **0664** permission.
>
>> `-folder [permission]`
>> 
>> If is set, it modifies the default value assigned  for folders when setting permissions. By default, folders take **2775** permission.
>
>> `-exe [permission]`
>> 
>> If is set, it modifies the default value assigned  for executable files when setting permissions. By default, executable files take **0774** permission.

---