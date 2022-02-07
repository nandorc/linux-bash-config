# basher elasticsearch

Provides commands to manage elasticsearch service.

## Commands

`basher elasticsearch:set-path`

> Ask for elasticsearch root folder path and store it.

`basher elasticsearch:status [?options]`

> Shows elasticsearch service status
>
> [?options]
>
> `--output type`
>
> > Set the expected output type.
> >
> > It must be 'string', 'response' or 'bool'.
> >
> > If nothing sent, 'string' will be used as default.
> >
> > When using 'string' or 'response' output types, `--no-color` and `--spacing` options may be used.

`basher elasticsearch:start [?options]`

> Starts elasticsearch service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher elasticsearch:stop [?options]`

> Stops elasticsearch service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher elasticsearch:restart [?options]`

> Restarts elasticsearch service
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
