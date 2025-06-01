#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# install.sh
#
# - Homebrew が入っていなければ自動でインストール
# - brew コマンドを PATH に通す設定を ~/.zprofile または ~/.zshrc に追加
# - brew update → brew upgrade
# - あなたの環境でインストール済みの Formula 一覧を install し直し
# - Cask も同様にインストール
# -----------------------------------------------------------------------------

# 1. Homebrew のインストール（未インストール時のみ）
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew が見つかりません。インストールを開始します…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Homebrew を PATH に通すための設定をシェル設定ファイルに追加
  BREW_PREFIX="$(/usr/bin/which brew | sed -E 's:/bin/brew::')"
  echo ""
  echo "── Homebrew のパスをシェル設定に追加します ──"
  # macOS の場合、デフォルトでは zsh を想定
  if [[ -n "${ZSH_VERSION:-}" ]]; then
    SHELL_RC="$HOME/.zprofile"
  else
    SHELL_RC="$HOME/.bash_profile"
  fi

  # すでに設定があるか確認し、なければ追加
  if ! grep -q "eval \"\$\\($BREW_PREFIX/bin/brew shellenv\\)\"" "$SHELL_RC" 2>/dev/null; then
    echo "eval \"\$($BREW_PREFIX/bin/brew shellenv)\"" >> "$SHELL_RC"
    echo "  -> $SHELL_RC に追加しました。"
  else
    echo "  -> $SHELL_RC に既に Homebrew の設定があるようです。"
  fi

  # ここで一度シェルを読み込んでおく（以降の brew コマンドが使えるように）
  eval "$($BREW_PREFIX/bin/brew shellenv)"
else
  echo "Homebrew は既にインストール済みです。"
  eval "$(/usr/local/bin/brew shellenv 2>/dev/null || /opt/homebrew/bin/brew shellenv 2>/dev/null)"
fi

# 2. Homebrew のアップデート＆アップグレード
echo ""
echo "── Homebrew のアップデートとアップグレード ──"
brew update
brew upgrade
brew tap FelixKratz/formulae

# 3. インストールしたい Formula の配列
FORMULAE=(
  autoconf
  borders
  ca-certificates
  cairo
  certifi
  fontconfig
  freetype
  gcc
  gettext
  git
  git-lfs
  glib
  gmp
  icu4c@77
  isl
  jpeg-turbo
  jq
  krb5
  libevent
  libmpc
  libmpfr
  libunistring
  libuv
  libx11
  libxau
  libxcb
  libxdmcp
  libxext
  libxrender
  libyaml
  lpeg
  lua
  luajit
  lzo
  m4
  mpdecimal
  neovim
  nodebrew
  nowplaying-cli
  oniguruma
  openssl@3
  pcre2
  pnpm
  postgresql@14
  pyenv
  python@3.13
  r
  rbenv
  readline
  ruby-build
  sketchybar
  sqlite
  stow
  switchaudio-osx
  tcl-tk@8
  tmux
  tree
  tree-sitter
  unibilium
  utf8proc
  xorgproto
  xz
  yt-dlp
  zstd
  zsh-syntax-highlighting
)

# 4. インストールしたい Cask の配列
CASKS=(
  aerospace
  alt-tab
  docker
  font-hack-nerd-font
  font-sf-pro
  homerow
  iterm2
  karabiner-elements
  notion
  notion-mail
  psychopy
  rstudio
  sf-symbols
  steam
  visual-studio-code
)

# 5. Formula を順番にインストール
echo ""
echo "── Formula をインストールします ──"
for pkg in "${FORMULAE[@]}"; do
  if brew list --formula | grep -qw "$pkg"; then
    echo "  • $pkg は既にインストール済み、スキップ"
  else
    echo "  • $pkg をインストール中…"
    brew install "$pkg"
  fi
done

# 6. Cask を順番にインストール
echo ""
echo "── Cask をインストールします ──"
for cask in "${CASKS[@]}"; do
  if brew list --cask | grep -qw "$cask"; then
    echo "  • $cask は既にインストール済み、スキップ"
  else
    echo "  • $cask をインストール中…"
    brew install --cask "$cask"
  fi
done

# 7. インストール後のクリーンアップ
echo ""
echo "── 不要なキャッシュや古いバージョンを削除 ──"
brew cleanup

echo ""
echo "✅ インストールが完了しました。"
echo "ターミナルを再起動するか、以下を実行してシェル設定を読み込んでください："
echo "  source \"$SHELL_RC\""



# ------ シンボリックリンク ------
# 2. ~/.config 以下の旧設定をバックアップ（存在すれば）
backup_dir="$HOME/.config/backup-before-dotfiles-$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

for d in aerospace sketchybar nvim borders fastfetch; do
  if [[ -e "$HOME/.config/$d" && ! -L "$HOME/.config/$d" ]]; then
    echo "バックアップ: ~/.config/$d → $backup_dir/$d"
    mv "$HOME/.config/$d" "$backup_dir/$d"
  elif [[ -L "$HOME/.config/$d" ]]; then
    echo "既存のシンボリックリンク ~/.config/$d を削除"
    rm -f "$HOME/.config/$d"
  fi
done

# 3. シンボリックリンクを作成
echo ""
echo "── シンボリックリンクを作成します ──"
for d in aerospace sketchybar nvim borders fastfetch; do
  src="$HOME/dotfiles/.config/$d"
  dest="$HOME/.config/$d"

  if [[ ! -e "$src" ]]; then
    echo "警告: リポジトリ内に $src が見つかりません。スキップします。"
    continue
  fi

  ln -sfn "$src" "$dest"
  echo "  • $dest →→→ $src"
done

# 5. AeroSpace.app の起動（起動中ならリロード）
echo ""
echo "── AeroSpace.app を起動または再読み込みします ──"
if pgrep -x "AeroSpace" >/dev/null 2>&1; then
  echo "  • すでに AeroSpace が起動中。設定をリロードします…"
  osascript -e 'tell application "AeroSpace" to activate'
else
  echo "  • AeroSpace を起動します"
  open -a AeroSpace
fi

# 4. Homebrew サービスの起動／再起動
echo ""
echo "── Homebrew サービスを起動／再起動します ──"

# sketchybar (Cask 版) をサービスとして起動している想定
if brew list --cask | grep -qw "sketchybar"; then
  echo "  • sketchybar を再起動（または起動）"
  brew services restart sketchybar || brew services start sketchybar
fi

# borders をサービスとしてインストールしている想定
if brew list | grep -qw "borders"; then
  echo "  • borders を再起動（または起動）"
  brew services restart borders || brew services start borders
fi

# 必要に応じて他の brew サービスも同様にここへ追記可能
# 例：tmux をサービス化している場合
# if brew list | grep -qw "tmux"; then
#   brew services restart tmux || brew services start tmux
# fi



# 6. 必要があれば Neovim プラグイン同期など（任意）
# 下記は例なので、ご利用のプラグイン管理方法に応じて編集してください。
# echo ""
# echo "── Neovim プラグインを同期しています（:PackerSync など）──"
# nvim +PackerSync +qa

echo ""
echo "✅ セットアップ完了！"
echo "ターミナルを再起動するか、以下を実行してシェル設定を読み込んでください："
echo "  source ~/.zprofile   （または ~/.zshrc, ~/.bash_profile など）"

exit 0
