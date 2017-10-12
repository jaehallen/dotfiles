#
# ~/.extend.bashrc
#
# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
		;;
esac

# Load dircolors
if [[ -f ~/.dir_colors ]] ; then
	eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
	eval $(dircolors -b /etc/DIR_COLORS)
fi

#Custom Prompt
export reset='\[\e[0m\]' # No Color
export black='\[\e[30m\]'
export red='\[\e[31m\]'
export green='\[\e[32m\]'
export yellow='\[\e[33m\]'
export blue='\[\e[34m\]'
export magenta='\[\e[35m\]'
export cyan='\[\e[36m\]'
export white='\[\e[37m\]'
git_branch () { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'; }

PS1="\n${green}┌──┤${red}\u${reset}@${red}\h${reset}${green}├${reset}${green}${reset}${cyan}\w${reset}${green}┤${reset}${red}\$(git_branch)${reset}\n${green}└─ ${reset}"
PS2="${green}└─ ${reset}"

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
shopt -s expand_aliases
# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Path to personal script
#PATH=$PATH:$HOME/.local/bin

#FZF 
[[ -f /usr/share/fzf/key-bindings.bash ]] && . /usr/share/fzf/key-bindings.bash 
[[ -f /usr/share/fzf/completion.bash ]] && . /usr/share/fzf/completion.bash 

#nodenv
export PATH=$HOME/.nodenv/bin:$PATH
eval "$(nodenv init -)"

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
      dirpath="$HOME/Downloads/extracted-packages"
    case "$1" in
      *.tar.bz2)   tar xjf $1 -C $dirpath  ;;
      *.tar.gz)    tar xzf $1 -C $dirpath   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       
      dirname=$(echo "$1" | awk -F'.zip' '{print $1}')
      echo $dirname
      unzip ${1} -d $dirpath/$dirname   ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
export EDITOR=vim
export BROWSER='chromium'
export NO_AT_BRIDGE=1
export GREP_COLOR='00;35'
export RANGER_LOAD_DEFAULT_RC=FALSE

# pacaur and cower aur directory
[[ ! -d "$HOME/.cache/aur" ]] && mkdir -p "$HOME/.cache/aur"
export AURDEST="$HOME/.cache/aur"
alias cower='cower --color=auto -t $HOME/.cache/aur'

# set colors for use throughout the prompt
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

#confirmation
alias mv='mv -i'
alias ln='ln -i'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias chown='chown --preserve-root'
alias chown='chmod --preserve-root'
alias chown='chgrp --reserve-root'
alias rm='rm -I --preserve-root'
alias np='vim -w PKGBUILD'
alias more=less
alias con='vim $HOME/.i3/config'
alias comp='vim $HOME/.config/compton.conf'
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias inst='sudo pacman -S'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias mirrors='sudo pacman-mirrors -g'
alias printer='system-config-printer'
alias update='yaourt -Syua'

xhost +local:root > /dev/null 2>&1
complete -cf sudo
