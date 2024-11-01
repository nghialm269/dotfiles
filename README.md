## Install:

```sh
git clone git@github.com:nghialm269/dotfiles.git && cd dotfiles
git submodule update --init --recursive

stow -t ~ stow
stow -t ~ zsh
stow -t ~ i3
stow -t ~ rofi
stow -t ~ redshift
sudo stow -t / hwdb
```

## Some notes:

### Create symlinks:

```sh
cd zsh/.oh-my-zsh-custom/plugins/catppuccin-zsh-syntax-highlighting
ln -s zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh catppuccin-zsh-syntax-highlighting.plugin.zsh
```
