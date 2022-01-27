# Bash Utilities

> **Author:** Daniel F. Rivera C. <<dsoftcolombia@gmail.com>>

## Description

This repository is intended to provide a simple way to customize linux terminal behaviour and give linux users tools to execute some administration tasks easy. It was tested on WSL.

## Features

* Displays git information
* Aliases for using WSL interoperability
* Quick access to apache webservice funcionalities
* Autostart on login request for apache service
* Quick access to mysql service funcionalities
* Autostart on login request for mysql service
* Quick access to lamp server funcionalities
* Autostart on login request for lamp server
* Quick access to elasticsearch service funcionalities
* Autostart on login for elasticsearch service
* Quick access to magento server funcionalities
* Autostart on login request for magento server
* Quick access to docker service funcionalities
* Autostart on login request for docker service
* Management of files and folders permissions
* Provides support to additional configurations

## Additional Configuration Note

If you like to include extra features, aliases or on run scripts you must do it creating a new file. It must be `~/.bash_aliases_extra`

## Tools

---



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