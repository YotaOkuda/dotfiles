#!/bin/bash

# dotfilesのパスを変数に定義
DOT_DIR="$HOME/ghq/github.com/YotaOkuda/dotfiles"

# 管理したいアプリのリスト (.config配下)
apps=(
  "tmux"
  "nvim"
  "aerospace"
  "sketchybar"
  "fastfetch"
  "gh"
  "borders"
  "karabiner"
  "ghostty"
)

# 1. .config配下のリンク作成
for app in "${apps[@]}"; do
  # 既存の実体ディレクトリが「リンクではない」場合は削除（上書き失敗を防ぐ）
  if [ -d "$HOME/.config/$app" ] && [ ! -L "$HOME/.config/$app" ]; then
    echo "Warning: $HOME/.config/$app is a real directory. Moving to .bak"
    mv "$HOME/.config/$app" "$HOME/.config/${app}.bak"
  fi

  # -s: symbolic, -f: force(上書き), -v: verbose(報告)
  ln -snfv "$DOT_DIR/.config/$app" "$HOME/.config/$app"
done

# 2. zshの設定 (ホーム直下)
ln -sfv "$DOT_DIR/.config/zsh/.zshrc" "$HOME/.zshrc"

echo "--- Setup Complete ---"
