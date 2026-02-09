# Yota's Dotfiles
This repository contains scripts and configuration files to set up a development environment for macOS.

<br>

## Contents
#### Editor  
  - neovim
#### WM  
  - aerospace
#### Menubar  
  - sketchybar
#### Keyboard Custom
  - karabiner
#### Other  
  - borders  
  - fastfetch
#### Unused  
  - skhd  
  - yabai

<br>

## Installation & Setup
```bash
gh repo clone YotaOkuda/dotfiles ~/ghq/github.com/YotaOkuda/dotfiles
cd ~/ghq/github.com/YotaOkuda/dotfiles
make setup
```

個別ターゲットの実行も可能:
```bash
make brew        # Homebrew インストール + brew bundle
make link        # シンボリックリンク作成
make submodule   # git submodule (powerlevel10k)
make sketchybar  # SbarLua ビルド + フォント
make neovim      # Lazy プラグイン同期
make tmux        # tpm + プラグインインストール
make services    # sketchybar / borders サービス起動
```

<br>

## Credits
The setting I referred to.

- https://github.com/FelixKratz/SketchyBar
- https://github.com/jackplus-xyz/dotfiles
- https://github.com/SoichiroYamane/dotfiles
- https://github.com/sofijacom/dotfiles-fastfetch
