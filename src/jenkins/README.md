# basher jenkins

Provides commands to manage jenkins service.

## Aliases

`jenkins-site`

> Alias to wrap opening of main jenkins site using `explorer.exe` windows utility.
>
> It assumes that jenkins is configure to launch on `http://localhost:8081`.

## Commands

`basher jenkins:status [?options]`

> Shows jenkins service status
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

`basher jenkins:start [?options]`

> Starts jenkins service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher jenkins:stop [?options]`

> Stops jenkins service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher jenkins:restart [?options]`

> Restarts jenkins service
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
