# basher elasticsearch

Provides commands to manage elasticsearch service. Installer is based on [Elasticsearch installation instructions for docker](https://www.elastic.co/guide/en/elasticsearch/reference/7.10/elasticsearch.html)

## Commands

`basher elasticsearch:status [?options]`

> Shows elasticsearch service status
>
> [?options]
>
> `--output [type]`
>
> > Set the expected output type.
> >
> > It must be 'string', 'response' or 'bool'.
> >
> > If isn't sent or is sent with an empty or invalid value, 'string' will be used.
>
> `--no-spaces`
>
> > When --output is string or response, it may control when to supress from adding before and after blank rows on response.

`basher elasticsearch:start [?options]`

> Starts elasticsearch service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.

`basher elasticsearch:stop [?options]`

> Stops elasticsearch service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.

`basher elasticsearch:restart [?options]`

> Restarts elasticsearch service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.

`basher elasticsearch:install [?options]`

> Installs elasticsearch service
>
> [?options]
>
> `--force`
>
> > It controls when to forced install service.
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.
>
> `--compact`
>
> > It controls when to supress additional information messages.
