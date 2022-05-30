# basher apache

Provides variables, aliases and commands to manage apache2 service.

## Variables

`$webserver`

> Stores location of main webserver directory (the directory used for apache to store sites by default).

## Commands

`basher apache:status [?options]`

> Shows apache service status
>
> [?options]
>
> `--output [type]`
>
> > Set the expected output type.
> >
> > It must be 'string' or 'bool'.
> >
> > If isn't sent or is sent with an empty or invalid value, 'string' will be used.
>
> `--no-spaces`
>
> > Only when --output is string, it may control when to supress from adding before and after blank rows on response.

`basher apache:start [?options]`

> Starts apache service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.
>
> `--compact`
>
> > It controls when to supress additional information messages.

`basher apache:stop [?options]`

> Stops apache service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.
>
> `--compact`
>
> > It controls when to supress additional information messages.

`basher apache:restart [?options]`

> Restarts apache service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.
>
> `--compact`
>
> > It controls when to supress additional information messages.
