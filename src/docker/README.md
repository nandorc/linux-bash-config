# basher docker

Provides commands to manage docker service.

## Commands

`basher docker:status [?options]`

> Shows docker service status
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

`basher docker:start [?options]`

> Starts docker service
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

`basher docker:stop [?options]`

> Stops docker service
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

`basher docker:restart [?options]`

> Restarts docker service
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

`basher docker:install [?options]`

> Installs docker service
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
