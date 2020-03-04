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

###prompt
##left
autoload -Uz promptinit && promptinit
prompt redhat
autoload -U colors && colors
PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[magenta]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

##right
#load vcf_info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#set prompt
RPROMPT="%{$fg[green]%}\$vcs_info_msg_0_"
#format vcf_info string
zstyle ':vcs_info:git:*' formats '[%b]'

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

# use antigen
source $HOME/.antigen/antigen.zsh

# color for autosuggestions should be red
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=9"

# bundles
antigen bundle git
antigen bundle pip
antigen bundle vagrant
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle gpg-agent
antigen bundle srijanshetty/zsh-pandoc-completion

# apply antigen bundles & theme
antigen apply

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

#swap escape with caps
#xmodmap /home/ljurk/dotfiles/.Xmodmap
#aliases
alias :q='exit'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias sn='sudo nano'
alias ag='sudo apt-get'
alias sp='sudo pacman'
alias diskusage='sudo du -sh * | sort -hf'
alias sv='sudo vim'
alias v='vim'
alias g='git'
alias gs='git status'
alias gch='git checkout'
alias gd='git diff'
alias gc='git commit'
alias ga='git add'
alias gpl='git pull'
alias gps='git push'
alias py='python3'
alias ll='ls -lisa'
alias la='ls -A'
alias l='ls -CF'
alias z='zathura'
alias gpta='git remote | xargs -L1 git push --all'
alias tbase='tmux a -t base || tmux new -s base'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'
alias semon='platformio device monitor'
alias temp='watch -n 2 sensors'
#Adminstuff
alias a2res='sudo service apache2 restart'
alias a2rel='sudo service apache2 reload'
alias ncocc='sudo -u www-data php /var/www/nc/occ maintenance:mode'
alias ppsql='sudo -u postgres psql'
alias sserv='sudo service'
alias tlscheck='nmap --script ssl-enum-ciphers -p 443'
# Vagrant aliases
alias vs="vagrant status"
alias vssh="vagrant ssh"
alias vup="vagrant up --no-provision"
alias vp="vagrant provision"
alias vr="vagrant reload"
alias vd="vagrant destroy"
# ansible
alias a="ansible"
alias ap="ansible-playbook"
alias av="ansible-vault edit"
# docker
alias d="docker"
alias dcp="docker-compose"
alias dcup="docker-compose up"
## For My Proxy Tunnel
alias proxy-on='ssh -fN cmgraylogProxy'
alias proxy-check='ssh -O check cmgraylogProxy'
alias proxy-off='ssh -O exit cmgraylogProxy'
