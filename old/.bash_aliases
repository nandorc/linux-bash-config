# Read Bash Utilities Configuration File
if [ -f ~/.bash_utilities/src/config.sh ]; then
  . ~/.bash_utilities/src/config.sh
fi

# To add additional aliases and configuration, you could use ~/.bash_aliases_extra file
if [ -f ~/.bash_aliases_extra ]; then
  . ~/.bash_aliases_extra
fi
