# basher docker

Provides commands to manage docker service.

## Commands

`basher docker:status [?options]`

> Shows docker service status
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

`basher docker:start [?options]`

> Starts docker service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher docker:stop [?options]`

> Stops docker service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher docker:restart [?options]`

> Restarts docker service
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
