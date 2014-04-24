# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
unsetopt notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bxchen/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# prevent zsh from killing all background jobs upon exiting the shell
setopt nohup

#--------------------
#  Prompt
#--------------------
autoload -U promptinit
promptinit

autoload -U colors && colors

## add git-prompt
#fpath=(~/dotfiles/git-prompt $fpath)
source ~/dotfiles/git-prompt/zshrc.sh
local gitprompt='$(git_super_status)'
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[yellow]%}%m:%{$reset_color%}%2~%{$reset_color%}${gitprompt}% [%{$fg_no_bold[green]%}%*%{$reset_color%}]%# "
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# autocompletion of command line switches for aliases
setopt completealiases

# ignore duplicate lines in the history
setopt HIST_IGNORE_DUPS

# Directory stack
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

#--------------------
#  Alias
#--------------------
# get the platform of the current machine
platform=$(uname);
# If the platform is Linux, try an apt-get to install zsh and then recurse
if [[ $platform == 'Linux' ]]; then
	alias ls="ls --color -F"
	alias ll="ls --color -lh"
    alias workhorse='ssh -X workhorse'
    alias hercules='ssh -X hercules'
    alias nether='ssh -X nether'
    alias titanomachy='ssh -X titanomachy'
    alias midway='ssh -X bxchen@midway.rcc.uchicago.edu'
# If the platform is OS X, tell the user to install zsh :)
elif [[ $platform == 'Darwin' ]]; then
	alias ls="ls -GF"
	alias ll="ls -lhG"
fi

alias pet1='ssh -X pet1'
alias siraf='ssh -X siraf-login'

#--------------------
# Key bindings
#--------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
#bindkey -e
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# history search
[[ -n "${key[Up]}"   ]]  && bindkey  "${key[Up]}"    history-search-backward
[[ -n "${key[Down]}" ]]  && bindkey  "${key[Down]}"  history-search-forward

#bindkey  "^[[A"  history-beginning-search-backward
#bindkey  "^[[B"  history-beginning-search-forward
#bindkey "${key[PageUp]}" history-search-backward
#bindkey "${key[PageDown]}" history-search-forward

