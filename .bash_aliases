# Read configuration
if [ -f ~/.bash_customizations/config.sh ]; then
  . ~/.bash_customizations/config.sh
fi

# To add additional aliases and configuration, you could use ~/.bash_aliases_extra file
if [ -f ~/.bash_aliases_extra ]; then
  . ~/.bash_aliases_extra
fi
