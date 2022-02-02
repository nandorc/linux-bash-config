# Basher for Linux v2.0.5

This repository is intended to provide a simple way to customize linux terminal behaviour and give linux users tools to execute some administration tasks easy. It was tested on WSL.

# Features

- bashcustomizer allows to add customizations for bash behaviour, adding aliases and checking services at startup.
- setpermissions allow to manage files and folders permissions.
- mdv provides a way to view Markdown files using less or pandoc.

# Installation

In order to install this tool, you must include it at user directory (~) as a git submodule. It is not necessary for you to commit changes at user directory, so if you want you can add a .gitignore file at that directory to avoid git tracking. Following command may help you to create it.

```
touch ~/.gitignore
```

Once created, you only have to write next content inside the file. You can use any text editor (vi, nano, code, ...).

`.gitignore`

```
/*
!/.gitignore
!/.gitmodules
!/.basher
```

If is your first time working with git modules, the following commands may be helpful to add the tool.

```
cd ~
git init
git submodule add -b master --name bash_utilities https://github.com/nandorc/linux-bash-utilities.git ./.basher
git submodule update --init --recursive
git add .
```

Once the submodule is added you have to execute `setup.sh`. Following command is and example of how to execute it.

```
~/.basher/setup.sh
```

That's it! If all goes well you just have to restart your system and will be able to use Bash Utilities commands.
