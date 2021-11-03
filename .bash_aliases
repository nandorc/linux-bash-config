# Read variables
if [ -f ~/.bash_customizations/.custom_bash_config ]; then
  . ~/.bash_customizations/.custom_bash_config
fi

# To add additional aliases and configuration, you could use ~/.bash_aliases_extra file
if [ -f ~/.bash_aliases_extra ]; then
  . ~/.bash_aliases_extra
fi
