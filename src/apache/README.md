# basher apache

Provides variables and aliases to manage apache2 service.

## Variables

`$webserver`

> Change location to main webserver directory (the directory used for apache to store sites by default).

`$localhost`

> Change location to default apache site directory.

## Aliases

`localhost`

> Shows on deafult web browser the default site for apache (http://localhost).

## Commands

`basher apache:status [?options]`

> Shows apache service status
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

`basher apache:start [?options]`

> Starts apache service
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher apache:stop [?options]`

> Stops apache service
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
