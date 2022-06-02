# basher wsl

Provides aliases to ease use of WSL interoperability.

## Aliases

`open [source]`

> Command to wrap 'explorer.exe' tool.
>
> If [source] is a file or a folder it allows to open it using Windows native applications.
>
> If [source] is a URL (like [https://google.com.co](https://google.com.co)) it opens the resource using the default web browser.

`clip`

> Command to wrap 'clip.exe' tool.
>
> This allows to send to Windows clipboard a text printed in command line. Following is the most simple case of use.
>
> ```bash
> #!/bin/bash
> 
> echo "This will be sent to Windows clipboard" | clip
> ```
