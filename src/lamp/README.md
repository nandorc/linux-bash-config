# basher lamp

Provides commands to manage a LAMP environment.

## Commands

`basher lamp:status [?options]`

> Shows lamp services status
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

`basher lamp:start [?options]`

> Starts lamp services
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher lamp:stop [?options]`

> Stops lamp services
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher lamp:restart [?options]`

> Restarts lamp services
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
