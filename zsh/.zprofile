export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK_THEME=Dracula
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/firefox
export PATH="/usr/sbin:/sbin:/usr/games:$PATH:$HOME/.bin"

# navigate fzf with alt+j/k
export FZF_DEFAULT_OPTS='--bind alt-j:down,alt-k:up'

setxkbmap -option caps:escape
setxkbmap -option compose:ralt
