# disable vi mode
bindkey -e
# set environment variables
export PATH=$HOME/.bin/:$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH

# always start tmux
_not_inside_tmux() {
  [[ -z "$TMUX" ]]
}

_is_not_root() {
  [[ $(whoami) != "root" ]]
}

if _not_inside_tmux && _is_not_root; then
    tat
fi

# HOME and END keys
bindkey "^[[H" beginning-of-line
bindkey '\eOH'  beginning-of-line
bindkey "\E[1~" beginning-of-line
bindkey "^[[F" end-of-line
bindkey '\eOF'  end-of-line
bindkey "\E[4~" end-of-line
# history settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
#auto cd
setopt autocd autopushd

###prompt
autoload -U colors && colors
PS1='%{$fg[magenta]%}% $( [[ $(whoami) == "root" ]] && echo "%{$fg[red]%}root@%{$fg[magenta]%}" )%m %{$fg[yellow]%}%~ %{$reset_color%}%% '
#load vcf_info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# return code
local returncode="%(?..%{$fg[red]%} %? %{$reset_color%})"

#set prompt
update_rprompt() {
RPROMPT="${returncode}%{$fg[green]%}\$vcs_info_msg_0_"
}

# Set up precmd hook to call update_rprompt
precmd() {
    update_rprompt
}

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
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Alt+Shift+Backspace
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^H' backward-kill-dir

# Alt+Shift+h
backward-word-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-word
}
zle -N backward-word-dir
bindkey '^[H' backward-word-dir
# Alt+Shift+l
forward-word-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle forward-word
}
zle -N forward-word-dir
bindkey '^[L' forward-word-dir

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

## aliases
# Git worktree selector with fzf
wt() {
  local create=false
  local delete=false
  local sync=false
  local name=""
  local target=""

  _wt_usage() {
    cat <<USAGE
Usage: wt [-c <name>] [-d [path]] [-s] [-h]

Options:
  -c <name>   Create a new worktree with branch name <name>
  -d [path]   Delete a worktree (fuzzy select if no path given, use '.' for current)
  -s          Pull all existing worktrees and remove stale ones
  -h          Show this help message
USAGE
  }

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -c) create=true; name="$2"; shift 2 ;;
      -d) delete=true; shift; [[ $# -gt 0 && ! "$1" =~ ^- ]] && { target="$1"; shift; } ;;
      -s) sync=true; shift ;;
      -h) _wt_usage; return 0 ;;
      *) _wt_usage; return 1 ;;
    esac
  done

  if ($create || $sync) && $delete; then
    echo "Error: -c and -s are mutually exclusive with -d"
    return 1
  fi

  if $create; then
    [[ -z "$name" ]] && { echo "Error: -c requires a name"; return 1; }

    local root=$(git rev-parse --show-toplevel)
    local new_path="$root/.w/$name"

    git fetch origin || return 1
    if git show-ref --verify --quiet "refs/heads/$name"; then
      echo "Using existing local branch: $name"
      git worktree add "$new_path" "$name" || return 1
    elif git show-ref --verify --quiet "refs/remotes/origin/$name"; then
      echo "Creating branch $name from origin/$name"
      git worktree add "$new_path" -b "$name" --track "origin/$name" || return 1
    else
      echo "Error: neither local branch '$name' nor remote branch 'origin/$name' exists"
      return 1
    fi

    cd "$new_path"

  elif $sync; then
    local wt_path
    local output
    local state

    git worktree list --porcelain |
      awk '/^worktree /{print substr($0,10)}' |
      while read -r wt_path; do
        echo "==> $wt_path"

        output=$(git -C "$wt_path" pull 2>&1)
        state=$?

        echo "$output"

        if [[ $state -ne 0 ]] &&
           echo "$output" | grep -q 'but no such ref was fetched\.'; then
          echo "Removing stale worktree: $wt_path"
          git worktree remove "$wt_path" || return 1
        elif [[ $state -ne 0 ]]; then
          echo "Error pulling $wt_path"
          return $state
        fi
      done

  elif $delete; then
    local to_delete

    if [[ -n "$target" ]]; then
      to_delete=$(realpath "$target")
    else
      to_delete=$(git worktree list | fzf --height 40% --reverse | awk '{print $1}')
    fi

    [[ -z "$to_delete" ]] && return 0

    local main_wt=$(git worktree list | head -1 | awk '{print $1}')

    if [[ "$to_delete" == "$main_wt" ]]; then
      echo "Error: cannot delete main worktree"
      return 1
    fi

    [[ "$(realpath .)" == "$to_delete"* ]] && cd "$main_wt"
    git worktree remove "$to_delete"

  else
    local selected=$(git worktree list | fzf --height 40% --reverse | awk '{print $1}')
    [[ -n "$selected" ]] && cd "$selected"
  fi
}


alias ls='ls --color=auto'
alias gs='git status'
alias grbroot='git rebase -i $(git log --reverse --ancestry-path $(git merge-base "$(git rev-parse --abbrev-ref origin/HEAD)" HEAD)..HEAD --pretty=format:%H | head -1)^'
alias gsu='git status -uno'
alias grep='grep --color=auto'
alias pm='sudo pacman'
alias p='podman'
alias s='sudo systemctl'
alias j='sudo journalctl'
alias order66='sudo pacman -Rsn $(pacman -Qqtd)' # remove orpahned pacakges
alias sv='sudo nvim'
alias v='nvim'
alias ll='ls -lisa'
alias la='ls -A'
alias l='ls -CF'
alias z='devour zathura'
alias zf='devour zathura $(find ~ -name "*.pdf" | fzf)'
alias wifi='nmcli device wifi list | tail -n +2 | grep -v "^\*" | awk '\''{print $2}'\'' | sort -u | fzf | awk '\''{system("nmcli device wifi connect " $1)}'\'''

# tmux
tmux-ansible() {
  local session="ansible"
  local workdir="$HOME/work/ansible"

  # Check if session already exists
  if tmux has-session -t "$session" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      # Inside tmux: switch to existing session
      tmux switch-client -t "$session"
    else
      # Outside tmux: attach
      tmux attach -t "$session"
    fi
    return
  fi

  # Create new session detached
  tmux new-session -d -s "$session" -c "$workdir"

   # Rename first window and run git status
  tmux rename-window -t "$session:0" 'main'
  tmux send-keys -t "$session:main" "git status" C-m

  # Create second window with vertical split (top/bottom)
  tmux new-window -t "$session:1" -n 'split' -c "$workdir"
  tmux split-window -v -t "$session:1" -c "$workdir"

  # Ensure the first window is active when attaching
  tmux select-window -t "$session:main"

  # Connect appropriately depending on whether we're in tmux
  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach -t "$session"
  fi
}


# microcontroller
alias semon='platformio device monitor'
alias avrtest='avrdude -p m328p -c gpio'
alias temp='watch -n 2 sensors'
# adminstuff
alias certinfo='nmap -p 443 --script ssl-cert'
alias queryLdap='ldapsearch -x -b "$LDAP_BASE" -H "$LDAP_HOST" -D "$LDAP_USER" -w "$LDAP_PASSWORD"'

# ssh
ssh() {
    remote_tmp=$(command ssh "$1" "mktemp /tmp/bashrc_temp.XXXXXX")
    command scp ~/.bashrc_remote "$1:$remote_tmp"
    command ssh -t $1 "export BASHRC_TEMP=$remote_tmp; bash --rcfile $remote_tmp; rm $remote_tmp"
}

alias sshs='ssh $(grep -h -r "^\s*Host " ~/.ssh/config ~/.ssh/config.d/* | awk "{print \$2}" | sort | fzf)'
alias forever='for ((;;))'

# pacman
function pacman-rm(){
    pacman -Qet |  fzf --multi --preview 'pacman -Qi {1}' | cut -d ' ' -f 1 | xargs -ro sudo pacman -R
}

# vagrant
vrestart(){
    vagrant destroy -f $1
    vagrant up $1
    vagrant ssh $1
}

cht() {
    curl --silent cht.sh/$1 | less -R
}

alias ap='ansible-playbook --diff'
# work
alias idm-tools-db='mariadb -u idm-tools -p -h idm-tools-db.zih.tu-dresden.de --ssl-ca ~/work/idm/idm-tools-db/cert-ca.pem --ssl-cert ~/work/idm/idm-tools-db/cert-client.pem --ssl-key ~/work/idm/idm-tools-db/cert-client.nokey'
alias pw='pwgen -s 40 1'
alias newrole='cookiecutter ~/private/cookiecutter-ansible-role'
alias wget="curl -O --retry 999 --retry-max-time 0 -C -"
alias theme-light="gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'"
alias theme-dark="gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"

rmFromKnownHosts() {
    grep $1 ~/.ssh/known_hosts
    sed -i "/^$1/d" ~/.ssh/known_hosts
    echo "removed"
}

grun() {
    cmd="git config --global --add safe.directory '*';gitlab-runner exec docker --docker-pull-policy=if-not-present $1"
    sudo podman run --entrypoint bash --rm -w $PWD -v $PWD:$PWD -v ~/containers/auth.json:/root/.docker/config.json -v /var/run/podman/podman.sock:/var/run/docker.sock docker.io/gitlab/gitlab-runner:v15.11.1 -c "$cmd"
}

gstashes() {
    git stash list | fzf --ansi --no-sort --reverse --tiebreak=index \
                         --preview 'git stash show --color -p $(echo {} | grep -oP "(?<=stash@\{)\d+(?=\})")' \
                         --preview-window=right:60%
}

# git log show with fzf
gli() {
  # param validation
  if [[ ! `git log -n 1 $@ | head -n 1` ]] ;then
    return
  fi

  # filter by file string
  local filter
  # param existed, git log for file if existed
  if [ -n $@ ] && [ -f $@ ]; then
    filter="-- $@"
  fi

  local gitlog=(
    git log
    --graph --color=always
    --abbrev=7
    --format='%C(auto)%h %an %C(blue)%s %C(yellow)%cr'
    $@
  )

  # fzf command
  local fzf=(
    fzf
    --ansi --no-sort --reverse --tiebreak=index
    --preview "f() { set -- \$(echo -- \$@ | grep -o '[a-f0-9]\{7\}'); [ \$# -eq 0 ] || git show --color=always \$1 $filter; }; f {}"
    --bind "ctrl-q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % $filter | less -R') << 'FZF-EOF'
                {}
                FZF-EOF"
   --preview-window=right:60%
  )

  # piping them
  $gitlog | $fzf
}

gstatus() {
  # Format the issues list for fzf
  formatted_issues=$(git status --short)

  # Use fzf to select an issue and preview its content
  selected_issue=$(echo "$formatted_issues" | fzf --preview-window=right:60% \
                                                  --preview '
        file=$(echo {} | cut -c4-)
        state=$(echo {} | cut -c1)

        if [[ "$state" == " " ]]; then
          git diff --color "$file"
        else
          bat --style=plain,numbers --color=always "$file"
        fi')

  # If an issue was selected, display it using glab issue view
  if [[ -n "$selected_issue" ]]; then
      nvim "${selected_issue: 3}"
  fi
}

gmrs() {
  # Format the issues list for fzf
  formatted_issues=$(glab mr list --per-page 999 --output json | jq -r '.[] | "#\(.iid): \(.title) (\(.labels | join(", ")))"')

  # Use fzf to select an issue and preview its content
  selected_issue=$(echo "$formatted_issues" | fzf --preview-window=right:60% --preview 'script -q -c "glab mr view $(echo {} | cut -d# -f2 | cut -d: -f1)" /dev/null')

  # If an issue was selected, display it using glab issue view
  if [[ -n "$selected_issue" ]]; then
    echo "$issue_id"
    issue_id=$(echo "$selected_issue" | cut -d# -f2 | cut -d: -f1)
    glab mr view "$issue_id" --web
  fi
}

gissues() {
  # Format the issues list for fzf
  formatted_issues=$(glab issue list --per-page 999 --output json | jq -r '.[] | "#\(.iid): \(.title) (\(.labels | join(", ")))"')

  # Use fzf to select an issue and preview its content
  selected_issue=$(echo "$formatted_issues" | fzf --preview-window=right:60% --preview 'script -q -c "glab issue view $(echo {} | cut -d# -f2 | cut -d: -f1)" /dev/null')

  # If an issue was selected, display it using glab issue view
  if [[ -n "$selected_issue" ]]; then
    issue_id=$(echo "$selected_issue" | cut -d# -f2 | cut -d: -f1)
    glab issue view "$issue_id" --web
  fi
}
alias gpop='git popbranch'
alias gissue='glab issue view $(git rev-parse --abbrev-ref HEAD | cut -d - -f1)'
alias gbranches='git branch -a | sed "s#remotes/origin/##g" | sort | uniq | fzf | xargs git checkout'
alias gupmain="git checkout $(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@') && git pull && git checkout -"

gdf() {
  selected=$(git status -uno --short | fzf --reverse --preview-window=right:60% \
    --preview 'file=$(echo {} | cut -c4-); git diff --color "$file"')
  if [[ -n "$selected" ]]; then
    file=$(echo "$selected" | cut -c4-)
    git add "$file"
  fi
}

stowy() {
   command stow $(ls -d */ | cut -d/ -f1 | grep -vE '^(mime|mail|packages|wifi|lightdm|grub)$') "$@"
}

source <(fzf --zsh)
