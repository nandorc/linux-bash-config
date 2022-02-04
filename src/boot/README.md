# basher boot command

This command allow users to manage on boot services checking and starting.

`basher boot --help`

> Prints this information about command options.

`basher boot:reset [?options]`

> Reset stored values at features.ini file.
>
> [?options]
>
> `--no-restart`
>
> > Points to not showing a message to indicate the need for a system reboot.

`basher boot:enable [?options] [features...]`

> Enable boot features check.
>
> [features...] is the space separated list of names of intended features to be enabled.
>
> If no [features...] given, enables all available features.

`basher boot:disable [?options] [features...]`

> Disable boot features check.
>
> [features...] is the space separated list of names of intended features to be disabled.
>
> If no [features...] given, disables all available features.

## Common [?options]

`--no-color`

> Points to not use colors on messages.

`--spacing [spacing]`

> Referes to blank lines to be used around command execution messages.
>
> Spacing must be 'none', 'before', 'after' or 'both'.
>
> 'both' is used by default.
