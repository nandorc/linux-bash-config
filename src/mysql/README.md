# basher mysql

Provides commands to manage mysql service.

## Commands

`basher mysql:status [?options]`

> Shows mysql service status
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

`basher mysql:start [?options]`

> Starts mysql service
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

`basher mysql:stop [?options]`

> Stops mysql service
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

`basher mysql:restart [?options]`

> Restarts mysql service
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

`basher mysql:install [?options]`

> Installs mysql service
>
> [?options]
>
> `--force`
>
> > It controls when to forced install service.
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.
>
> `--compact`
>
> > It controls when to supress additional information messages.
