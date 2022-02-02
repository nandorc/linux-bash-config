# basher boot command

This command allow users to manage on boot services checking and starting.

`basher boot --help`

> Prints this information about command options.

`basher boot:reset [--no-color] [--spacing spacing]`

> Reset stored values at features.ini file.
>
> [--no-color] points to use plain messages.
>
> [--spacing spacing] referes to blank lines to be used around command execution messages. Spacing must be 'none', 'before', 'after' or 'both'. 'both' is used by default.

`basher boot:enable [features...]`

> Enable boot features check. [features...] is the space separated list of names of intended features to be enabled. If no [features...] given, enables all features.
