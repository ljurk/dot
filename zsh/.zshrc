# set environment variables
export PATH=$HOME/.scripts/:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# history settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt HIST_IGNORE_DUPS
#auto cd
setopt autocd autopushd

###prompt
##left
autoload -Uz promptinit && promptinit
prompt redhat
autoload -U colors && colors
PS1="%{$fg[magenta]%}% %m %{$fg[yellow]%}%~ %{$reset_color%}%% "
##right
#load vcf_info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# return code
local returncode="%(?..%{$fg[red]%} %? %{$resetcolor%})"
#set prompt
RPROMPT="${returncode}%{$fg[green]%}\$vcs_info_msg_0_"
#format vcf_info string
zstyle ':vcs_info:git:*' formats '[%b]'

## execution time
# If command execution time above min. time, plugins will not output time.
ZSH_COMMAND_TIME_MIN_SECONDS=3
# Message to display (set to "" for disable).
ZSH_COMMAND_TIME_MSG="Execution time: %s sec"
# Message color.
ZSH_COMMAND_TIME_COLOR="cyan"

# key bindings
bindkey "\e[7~" beginning-of-line       #HOME
bindkey "\e[8~" end-of-line             #END
bindkey "\e[3~" delete-char             #DEL
bindkey ',' autosuggest-accept
#alt+vim keys for navigating up and down in history and left and right in words
bindkey '^[k' up-line-or-search
bindkey '^[j' down-line-or-search
bindkey '^[l' forward-word
bindkey '^[h' backward-word
#fzf
bindkey -s '^[c' 'cdfzf\n'

# color for autosuggestions should be red
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=9"

# use antigen
source /usr/share/zsh/share/antigen.zsh

# bundles
antigen bundle git
antigen bundle pip
antigen bundle vagrant
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle gpg-agent
antigen bundle srijanshetty/zsh-pandoc-completion
antigen bundle popstas/zsh-command-time
antigen bundle sparsick/ansible-zsh

# apply antigen bundles & theme
antigen apply

# Preferred editor
export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

#swap escape with caps
#xmodmap /home/ljurk/dotfiles/.Xmodmap

## aliases
alias :q='exit'
alias ls='ls --color=auto'
alias gs='git status'
alias grep='grep --color=auto'
alias ag='sudo apt-get'
alias p='sudo pacman'
alias order66='sudo pacman -Rsn $(pacman -Qqtd)' # remove orpahned pacakges
alias diskusage='sudo du -sh * | sort -hf'
alias sv='sudo vim'
alias v='vim'
alias ll='ls -lisa'
alias la='ls -A'
alias l='ls -CF'
alias z='devour zathura'
alias zf='devour zathura $(find ~ -name "*.pdf" | fzf)'
# tmux
alias tbase='tmux a -t base || tmux new -s base'
alias tans='tmux a -t ansible || tmux new -s ansible'
alias tweb='tmux a -t web || tmux new -s web'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'
# microcontroller
alias semon='platformio device monitor'
alias avrtest='avrdude -p m328p -c gpio'
alias temp='watch -n 2 sensors'
# adminstuff
alias tlscheck='nmap --script ssl-enum-ciphers -p 443'
certinfo() {
    curl --insecure -vvI "https://$1" 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'
}
certissuer() {
    certinfo $1 | grep "*  issuer" | sed -e "s/\*  issuer: //"
}
# docker
alias d="docker"
alias dcp="docker-compose"
alias dcup="docker-compose up"
dgetid() {
    docker ps -qf "name=$1"
}
# ssh tunnel
alias proxy-on='ssh -fN cmgraylogProxy'
alias proxy-check='ssh -O check cmgraylogProxy'
alias proxy-off='ssh -O exit cmgraylogProxy'
alias forever='for ((;;))'
