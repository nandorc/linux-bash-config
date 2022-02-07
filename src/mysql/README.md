# basher mysql

Provides variables and aliases to manage mysql service.

## Commands

`basher mysql:status [?options]`

> Shows mysql service status
>
> [?options]
>
> `--output type`
>
> > Set the expected output type.
> >
> > It must be 'string' or 'bool'.
> >
> > If nothing sent, 'string' will be used as default.
> >
> > When using 'string' output type, `--no-color` and `--spacing` options may be used.

`basher mysql:start [?options]`

> Starts mysql service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher mysql:stop [?options]`

> Stops mysql service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher mysql:restart [?options]`

> Restarts mysql service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

## Common [?options]

`--no-color`

> Points to not use colors on messages.

`--spacing [spacing]`

> Referes to blank lines to be used around command execution messages.
>
> Spacing must be 'none', 'before', 'after' or 'both'.
>
> 'both' is used by default.
