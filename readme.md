# dot

These are my dotfiles, managed with stow.

## Installation

```
stow */
```

[Reason for leading slash](https://stackoverflow.com/questions/64231650/why-doesnt-gnu-stow-ignore-single-files-in-main-directory)

## Install packages

```
cat packages.txt | sed -e '/^#/d' -e '/^$/d' | sudo pacman -S -
```

### login manger

[ly](https://github.com/fairyglade/ly) is used as a login manger. After installation its necessary to enable the service and update its PAM-config, so ly unlocks gnome-keyring

```
sudo rm /etc/pam.d/ly
sudo ln -s "$(pwd)/ly/pam" /etc/pam.d/ly
sudo systemctl enable lightdm.service
```

## shortcuts

### tmux

hostkey(hk): `Ctrl+a`

| key sequence | action                   | works on windows |
|--------------|--------------------------|------------------|
| ctrl+hjkl    | nav windows              | [x]              |
| hk+hjkl      | resize pane              | [x]              |
| hk+HJKL      | create pane              | [x]              |
| hk+u         | tpm uninstall            |                  |
| hk+U         | tpm update               |                  |
| hk+[         | scroll through window    | [x]              |
| V            | visual select            | [x]              |
| y            | yank to system clipboard | [x]              |
| hk+,         | rename pane              |                  |


## zsh

| key sequence  | action                     | works on windows  |
| ------------- | -------                    | ----------------- |
| ,             | accept suggestion          | [x]               |
| alt+k         | "                          | [x]               |
| alt+hl        | jump word forward/backward | [x]               |
| alt+j         | suggestion down            |                   |
