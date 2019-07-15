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

# key bindings
bindkey "\e[7~" beginning-of-line       #HOME
bindkey "\e[8~" end-of-line             #END
bindkey "\e[3~" delete-char             #DEL
bindkey '^o' autosuggest-accept

# use antigen
source $HOME/.antigen/antigen.zsh

# POWERLEVEL 9K Theme
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
#prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host dir virtualenv)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status ssh)
#dir
POWERLEVEL9K_DIR_HOME_BACKGROUND='092'
POWERLEVEL9K_DIR_ETC_BACKGROUND='092'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='092'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='092'
#user
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='052'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='white'
#install theme
antigen theme bhilburn/powerlevel9k powerlevel9k

# color for autosuggestions should be red
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=9"

# bundles
antigen bundle git
antigen bundle pip
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

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
alias gd='git diff'
alias gc='git commit'
alias ga='git add'
alias gpl='git pull'
alias gps='git push'
alias py='python3'
alias ll='ls -lisa'
alias la='ls -A'
alias l='ls -CF'
alias gpta='git remote | xargs -L1 git push --all'
alias tbase='tmux a -t base || tmux new -s base'
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'
alias semon='platformio device monitor'
#Adminstuff
alias a2res='sudo service apache2 restart'
alias a2rel='sudo service apache2 reload'
alias ncocc='sudo -u www-data php /var/www/nc/occ maintenance:mode'
alias ppsql='sudo -u postgres psql'
alias sserv='sudo service'
alias tlscheck='nmap --script ssl-enum-ciphers -p 443'
