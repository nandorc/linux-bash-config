# basher magento

Provides commands to manage a Magento environment (apache, mysql and elasticsearch)

## Commands

`basher magento:status [?options]`

> Shows magento services status
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

`basher magento:start [?options]`

> Starts magento services
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher magento:stop [?options]`

> Stops magento services
>
> [?options]
>
> > `--no-color` and `--spacing` may be used to controls message behaviour.

`basher magento:restart [?options]`

> Restarts magento services
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
