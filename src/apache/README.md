# basher apache

Provides variables, aliases and commands to manage apache2 service.

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

`basher apache:start`

> Starts apache service

`basher apache:stop`

> Stops apache service

`basher apache:restart`

> Restarts apache service
