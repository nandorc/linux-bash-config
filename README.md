# Basher for Linux v4.1.0

This repository is intended to provide a simple way to customize linux terminal behaviour and give linux users tools to execute some administration tasks easy. It was tested on WSL at distro **Ubuntu** which refers to **Ubuntu focal 20.04.4 LTS**.

## Installation

In order to install this tool, you must clone it at user directory (~) inside a folder named `.basher`. The following commands may be helpful to add the tool and include it at bash loading process.

```bash
#!/bin/bash

# Move to user directory
cd ~

# Clone basher for linux at .basher folder
git clone -b v4.1.0 https://github.com/nandorc/linux-basher.git .basher

# Execute tool setup
~/.basher/setup.sh
```

That's it! If all goes well you just have to restart your system or execute `source ~/.basher/etc/loader.sh` in order to use `basher` commands, `variables`, `aliases` and `styles`.

## Usage

Basher for Linux stands on `basher` command. The most basic instruction to send once installed could be the following.

```bash
#!/bin/bash

# Request for first use information about basher command
basher help
```
