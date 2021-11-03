# Show git branch name
force_color_prompt=yes
color_prompt=yes
parse_git_branch() {
  branchname=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  mergeconflict=$(git status 2>/dev/null | grep 'unmerged')
  stillmerging=$(git status 2>/dev/null | grep 'merging')
  cherrypickconflict=$(git status 2>/dev/null | grep 'Unmerged' | sed -e 's/://')
  stillcherrypicking=$(git status 2>/dev/null | grep 'cherry-picking')
  if [ ! -z "$branchname" ]; then
    if [ ! -z "$mergeconflict" ]; then
      echo "($branchname | Merging | Unmerged paths)"
    else
      if [ ! -z "$stillmerging" ]; then
        echo "($branchname | Merging | Ready to finish)"
      else
        if [ ! -z "$cherrypickconflict" ]; then
          echo "($branchname | Cherry-Picking | Unmerged paths)"
        else
          if [ ! -z "$stillcherrypicking" ]; then
            echo "($branchname | Cherry-Picking | Ready to finish)"
          else
            echo "($branchname)"
          fi
        fi
      fi
    fi
  fi
}
check_if_git_branch() {
  branchname=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ ! -z "$branchname" ]; then
    echo ":"
  fi
}
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]$(check_if_git_branch)\[\033[01;34m\]\w\[\033[00m\]\n\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:$(parse_git_branch)$(check_if_git_branch)\w\n\$ '
fi

unset color_prompt force_color_prompt
