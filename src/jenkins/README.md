# basher jenkins

Provides commands to manage jenkins service. Installer is based on [Jenkins installation instructions for docker](https://www.jenkins.io/doc/book/installing/docker/)

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
> `--output [type]`
>
> > Set the expected output type.
> >
> > It must be 'string' or 'bool'.
> >
> > If isn't sent or is sent with an empty or invalid value, 'string' will be used.
>
> `--no-spaces`
>
> > When --output is string, it may control when to supress from adding before and after blank rows on response.

`basher jenkins:start [?options]`

> Starts jenkins service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.

`basher jenkins:stop [?options]`

> Stops jenkins service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.

`basher jenkins:restart [?options]`

> Restarts jenkins service
>
> [?options]
>
> `--no-spaces`
>
> > It controls when to supress from adding before and after blank rows on response.

`basher jenkins:install [?options]`

> Installs jenkins service
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

## Usage

In order to unlock jenkins for being able to use it, you must need `initialAdminPassword` which can be obtained executing the following command.

~~~bash
#!bin/bash

docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword | clip
~~~
