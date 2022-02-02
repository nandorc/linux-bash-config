# Bash Libraries v1.0.1

Collection of general purpose libraríes to use on bash projects as git submodules.

## Instalation

Add this repo as a git submodule in your bash project. Following is the recomended command to use when including submodule.

```
git submodule add -b master --name lib/ext/dsoft https://github.com/nandorc/linux-bash-libraries.git ./lib/ext/dsoft

git submodule update --init
```

## Current available libraries

### `lib/ext/dsoft/messages.sh`

> This library allows to print pre-formatted messages for error, information and warning. Included methods are:
>
> - printMessage [message] [spacing]
> - printErrorMessage [message] [spacing]
> - printInfoMessage [message] [spacing]
> - printWarningMessage [message] [spacing]
>
> [spacing] must be 'none', 'before', 'after' or 'both'.
>
> [message] may include escaped sequences.

### `lib/ext/dsoft/inihandler.sh`

> This library allows to manage .ini files for setting or getting variables. Included methods are:
> 
> - getINIVar [path] [name]
> - getAllIniVars [path]
> - setINIVar [path] [name] [value]
> - dropINIVar [path] [name]
> 
> [path] refers to the .ini file location. If is setting a variable and file doesn't exists, it will be created.
> 
> [name] refers to the name of the variable is being getted or setted. When getting a non existent variable, result will be 'undefined'.
> 
> [value] refers to the value that is going to be stored. If no value is given, it will set a variable to an empty value.
