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

## neat to know

### Enable tapping

To enable tapping on the touchpad run

```
xinput --set-prop 12 "libinput Tapping Enabled" 1
```

### Hide firefox tab-bar

`<FIREFOX_PROFILE_FOLDER>/chrome/userChrome.css`:

```
/* hides the native tabs */
#TabsToolbar {
  visibility: collapse;
}
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
