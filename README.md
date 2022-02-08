# Basher for Linux v3.0

This repository is intended to provide a simple way to customize linux terminal behaviour and give linux users tools to execute some administration tasks easy. It was tested on WSL.

## Installation

In order to install this tool, you must clone it at user directory (~) inside a folder named `.basher`. The following commands may be helpful to add the tool and include it at bash loading process.

```
cd ~

git clone -b v3.0 https://github.com/nandorc/linux-basher.git .basher

~/.basher/setup.sh
```

That's it! If all goes well you will be able to use the `basher` commands.

In order to load `variables`, `aliases` and `styles` as well as to use auto-starting capabilities you just have to restart your system.

## Usage

Basher for Linux stands on `basher` command. The most basic instruction to send once installed could be the following.

```
basher help
```
