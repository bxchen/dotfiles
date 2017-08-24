# set history
HISTSIZE=999999999
SAVEHIST=999999999
HISTFILE=~/.zsh_history
#setopt appendhistory
# append history immediately, not when shell exits
setopt INC_APPEND_HISTORY
# share history between all sessions
setopt SHARE_HISTORY
# ignore duplicate lines in the history
setopt HIST_IGNORE_DUPS
# extended history with time stamp
setopt EXTENDED_HISTORY

# Lines configured by zsh-newuser-install
setopt extendedglob
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
source ~/dotfiles/zsh/zsh-git-prompt/zshrc.sh
local gitprompt='$(git_super_status)'
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[yellow]%}%m:%{$reset_color%}%2~%{$reset_color%}${gitprompt}% [%{$fg_no_bold[green]%}%*%{$reset_color%}]%# "
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

## add git-flow-completion
source ~/dotfiles/zsh/git-flow-completion/git-flow-completion.zsh

# autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# autocompletion of command line switches for aliases
setopt completealiases

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
# If the platform is Linux (native or cygwin)
if [[ $platform == 'Linux' ]] || [[ $platform =~ "CYGWIN" ]]; then
    alias ls="ls --color -F"
    alias ll="ls --color -lh"
    alias workhorse='ssh -Y workhorse'
    alias hercules='ssh -Y hercules'
    #alias hercules='ssh -Y 128.135.74.214'
    alias nether='ssh -Y nether'
    alias titanomachy='ssh -Y titanomachy'
    alias romulus='ssh -Y romulus'
    alias remus='ssh -Y remus'
    alias midway='ssh -Y bxchen@midway.rcc.uchicago.edu'
# If the platform is OS X
elif [[ $platform == 'Darwin' ]]; then
    alias ls="ls -GF"
    alias ll="ls -lhG"
    alias router='ssh router'
fi

alias pet1='ssh -Y pet1'
alias siraf='ssh -Y siraf-login'

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
[[ -n "${key[Up]}"   ]]  && bindkey  "${key[Up]}"    history-beginning-search-backward
[[ -n "${key[Down]}" ]]  && bindkey  "${key[Down]}"  history-beginning-search-forward

#bindkey  "^[[A"  history-beginning-search-backward
#bindkey  "^[[B"  history-beginning-search-forward
#bindkey "${key[PageUp]}" history-search-backward
#bindkey "${key[PageDown]}" history-search-forward


#------------------------------
# gpg-agent
# script from archlinux wiki
# https://wiki.archlinux.org/index.php/SSH_keys#ssh-agent
# https://wiki.archlinux.org/index.php/GnuPG
#------------------------------
# 
# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null



#------------------------------
# Environment Variables 
#------------------------------
#
export PATH=~/bin:$PATH
export PYTHONPATH=${PYTHONPATH}:${HOME}/python

export EDITOR=$(which vim)

export TERM=xterm-256color
# for tmux: export 256color
# trimmed down version from the solution in this post
# https://www.reddit.com/r/vim/comments/1a29vk/fixing_vims_background_color_erase_for_256color/
if [ -n "$TMUX" ]; then
    export TERM=screen-256color
# 	function refresh {
# 		export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
# 		export $(tmux show-environment | grep "^DISPLAY")
# 	}
	function refresh_tmux_env {
# 		TMUX_ENV_GAN=$(tmux show-environment | grep "^GIT_AUTHOR_NAME")
# 		[[ -n "$TMUX_ENV_GAN" ]] && export "$TMUX_ENV_GAN"
		TMUX_ENV_SSH_AUTH_SOCK=$(tmux show-environment | grep "^SSH_AUTH_SOCK")
		[[ -n "$TMUX_ENV_SSH_AUTH_SOCK" ]] && export "$TMUX_ENV_SSH_AUTH_SOCK"
		TMUX_ENV_DISPLAY=$(tmux show-environment | grep "^DISPLAY")
		[[ -n "$TMUX_ENV_DISPLAY" ]] && export "$TMUX_ENV_DISPLAY"
	}
else
#	function refresh { }
	function refresh_tmux_env { }
fi

function preexec {
#     refresh
	refresh_tmux_env
}
