# Current available libraries

## `lib/messages.sh`

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

## `lib/inihandler.sh`

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
