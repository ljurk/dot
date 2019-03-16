#set environment variables
export PATH=$PATH:$HOME/.scripts/

export PATH=$PATH:$HOME/.local/bin

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

source $HOME/.antigen/antigen.zsh

# POWERLEVEL 9K Theme
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status ssh)
antigen theme bhilburn/powerlevel9k powerlevel9k

# color for autosuggestions should be red
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=9"

antigen bundle git
antigen bundle pip

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

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

