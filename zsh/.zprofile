export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME=Dracula
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/firefox
export GOPATH="$HOME/go"
export PATH="/usr/sbin:/sbin:/usr/games:$PATH:$HOME/.bin:/home/ljurk/.cargo/bin:$GOPATH/bin"

# navigate fzf with alt+j/k
export FZF_DEFAULT_OPTS='--bind alt-j:down,alt-k:up,alt-K:preview-up,alt-J:preview-down'

export ANSIBLE_VAULT_IDENTITY_LIST=grafana@vault-client.py,debian_repo@vault-client.py,gitlab_runner@vault-client.py,mondb@vault-client.py,licenses@vault-client.py,datagateway@vault-client.py,kurzlink@vault-client.py,ubuntu_mirror_server@vault-client.py,harbor_build@vault-client.py

export REGISTRY_AUTH_FILE="$HOME/containers/auth.json"

setxkbmap -option caps:escape
setxkbmap -option compose:ralt
